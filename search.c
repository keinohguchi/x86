/* SPDX-License-Identifier: GPL-2.0 */
const char *const data = "hello world\0";
const char needle = 'w';
long n = 0;

int main(void)
{
	char c;
	int i;

	i = 0;
	c = data[i];
	if (c != 0) {
		do {
			if (c == needle)
				break;
			i++;
			c = data[i];
		} while (c != 0);
	}
	n = c == 0 ? -1 : i; /* n == 6 */
	return 0;
}
