/* SPDX-License-Identifier: GPL-2.0 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

struct test {
	const char	*const name;
	char		*const argv[4];
};

int main(void)
{
	char *const target = realpath("./bit", NULL);
	const struct test *t, tests[] = {
		{
			.name	= "no cmdline arguments",
			.argv	= {target, NULL},
		},
		{
			.name	= "dummy arguments",
			.argv	= {target, "one", "two", NULL},
		},
		{.name = NULL},
	};
	int fail = 0;

	for (t = tests; t->name; t++) {
		int ret, status;
		pid_t pid;

		pid = fork();
		if (pid == -1)
			goto perr;
		else if (pid == 0) {
			ret = execv(target, t->argv);
			if (ret == -1) {
				perror(t->name);
				exit(EXIT_FAILURE);
			}
		}
		ret = waitpid(pid, &status, 0);
		if (ret == -1)
			goto perr;
		if (WIFSIGNALED(status)) {
			fprintf(stderr, "%s: signaled by %s\n",
				t->name, strsignal(WTERMSIG(status)));
			goto err;
		}
		if (!WIFEXITED(status)) {
			fprintf(stderr, "%s: does not exit\n",
				t->name);
			goto err;
		}
		if (WEXITSTATUS(status))
			goto err;
		continue;
perr:
		perror(t->name);
err:
		fail++;
	}
	if (fail)
		exit(EXIT_FAILURE);
	exit(EXIT_SUCCESS);
}
