/* SPDX-License-Identifier: GPL-2.0 */
long data = 0xfedcba9876543210;
long sum;

int main(void)
{
	int i;

	/* counts the bits */
	while (i < 64) {
		sum += data & 1;
		data = data >> 1;
		i++;
	}
	if (sum != 32)
		return 1;
	return 0;
}

