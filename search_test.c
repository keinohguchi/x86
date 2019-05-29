/* SPDX-License-Identifier: GPL-2.0 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(void)
{
	char *target = realpath("./search", NULL);
	const struct {
		const char	*const name;
		char		*const argv[3];
	} *t, tests[] = {
		{
			.name	= "no argument",
			.argv	= {target, NULL},
		},
		{.name = NULL}, /* sentry */
	};
	int fail = 0;

	for (t = tests; t->name; t++) {
		int ret, status;
		pid_t pid;

		pid = fork();
		if (pid == -1)
			goto perr;
		else if (pid == 0) {
			execv(t->argv[0], t->argv);
			fprintf(stderr, "%s: %s\n", t->name,
				strerror(errno));
			exit(EXIT_FAILURE);
		}
		ret = waitpid(pid, &status, 0);
		if (ret == -1)
			goto perr;
		if (WIFSIGNALED(status)) {
			fprintf(stderr, "%s: signaled with %s\n",
				t->name, strsignal(WTERMSIG(status)));
			goto err;
		}
		if (!WIFEXITED(status)) {
			fprintf(stderr, "%s: does not exit\n",
				t->name);
			goto err;
		}
		if (WEXITSTATUS(status)) {
			fprintf(stderr, "%s: exit with %d\n",
				t->name, WEXITSTATUS(status));
			goto err;
		}
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
