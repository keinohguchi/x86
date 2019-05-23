/* SPDX-License-Identifier: GPL-2.0 */
int low = 1;
int mid = 2;
int hi  = 3;
int ret;

int main(void)
{
	if (mid < low)
		ret = -1;
	else if (mid < hi)
		ret = 0;
	else
		ret = 1;
	return ret;
}
