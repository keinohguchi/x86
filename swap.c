/* SPDX-License-Identifier: GPL-2.0 */
int a = 1;
int b = 2;

int main(void)
{
	if (a < b) {
		int tmp = a;
		a = b;
		b = tmp;
	} else
		return 1;
	return 0;
}
