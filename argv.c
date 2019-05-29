/* SPDX-License-Identifier: GPL-2.0 */
#include <stdio.h>

int main(int argc, char *const argv[])
{
	int i;

	for (i = 0; argv[i]; i++)
		printf("%s\n", argv[i]);
	return 0;
}
