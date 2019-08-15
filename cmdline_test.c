/* SPDX-License-Identifier: GPL-2.0 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(void)
{
	char *const target = realpath("./cmdline", NULL);
	const struct test {
		const char	*const name;
		char		*const argv[12];
	} *t, tests[] = {
		{
			.name	= "no command line argument",
			.argv	= {target, NULL},
		},
		{
			.name	= "one command line arguments",
			.argv	= {target, "1", NULL},
		},
		{
			.name	= "two command line arguments",
			.argv	= {target, "1", "2", NULL},
		},
		{
			.name	= "ten command line arguments",
			.argv	= {
				target, "1", "2", "3", "4", "5",
				"6", "7", "8", "9", "10", NULL,
			},
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
		else if (pid == 0)
			if (execv(target, t->argv) == -1) {
				perror(t->name);
				exit(EXIT_FAILURE);
			}
		ret = waitpid(pid, &status, 0);
		if (ret == -1)
			goto perr;
		if (WIFSIGNALED(status)) {
			fprintf(stderr, "%s: signeled by %s\n",
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
