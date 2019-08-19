/* SPDX-License-Identifier: GPL-2.0 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(void)
{
	char *const target = realpath("./factorial", NULL);
	const struct test {
		const char	*const name;
		char		*const argv[4];
	} *t, tests[] = {
		{
			.name	= "no arguments",
			.argv	= {target, NULL},
		},
		{
			.name	= "1!",
			.argv	= {target, "1", "1", NULL},
		},
		{
			.name	= "2!",
			.argv	= {target, "2", "2", NULL},
		},
		{
			.name	= "3!",
			.argv	= {target, "3", "6", NULL},
		},
		{
			.name	= "4!",
			.argv	= {target, "4", "24", NULL},
		},
		{
			.name	= "5!",
			.argv	= {target, "5", "120", NULL},
		},
		{
			.name	= "6!",
			.argv	= {target, "6", "720", NULL},
		},
		{
			.name	= "7!",
			.argv	= {target, "7", "5040", NULL},
		},
		{
			.name	= "8!",
			.argv	= {target, "8", "40320", NULL},
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
			if (ret == -1)
				exit(EXIT_FAILURE);
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
