; SPDX-License-Identifier: GPL-2.0
	segment .data
zero	dd	0
one	dd	1
neg1	dd	-1
a	dd	175
b	dd	4097
d	dd	65536
e	dd	100000000
	segment	.text
	global	main
main:
	xor	rax, rax
	ret