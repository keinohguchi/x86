; SPDX-License-Identifier: GPL-2.0
	segment .data
zero	dd	0.0
one	dd	1.0
neg1	dd	-1.0
a	dd	1.75
b	dd	122.5
d	dd	1.1
e	dd	10000000000.0
	segment	.text
	global	main
main:
	xor	rax, rax
	ret
