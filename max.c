/* SPDX-License-Identifier: GPL-2.0 */
int a = 1;
int b = 1;
int max;

int main(void)
{
	if (a < b)
		max = b;
	else {
		max = a;
		return 1; /* error */
	}
	return 0;
}
