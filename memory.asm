; SPDX-License-Identifier: GPL-2.0
	segment	.data
a	dd	1
b	dd	1.1
c	times 10 dd	0
d	dw	1, 2
e	db	0xfb
f	db	"hello world", 0
	segment	.bss
g	resd	1
h	resd	10
i	resd	100
	segment	.text
	global	main
main:
	push	rbp
	mov	rbp, rsp
	xor	eax, eax
	leave
	ret
