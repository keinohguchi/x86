/* SPDX-License-Identifier: GPL-2.0 */

unsigned long data = 0xfedcba9876543210;
unsigned long sum = 0;

int main(void)
{
	unsigned long d = data;
	unsigned long a = 0;
	int i;

	for (i = 0; i < 64; i++) {
		if (d & 0x1)
			a += 1;
		d >>= 1;
	}
	sum = a;
	if (sum != 32)
		return a;
	return 0;
}
