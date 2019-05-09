; SPDX-License-Identifier: GPL-2.0
	segment .data
a	dd	4
b	dd	4.4
c	times	10 dd 0
d	dw	1, 2
e	db	0xfb
f	db	"hello world", 0
	segment	.bss
g	resd	1
h	resd	10
i	resb	100
	segment .text
	global main
main:
	push	rbp		; set up a stack frame
	mov	rbp, rsp	; rbp points to stack frame
	sub	rsp, 16		; leave some room
	xor	eax, eax	; return 0
	leave			; undo stack frame
	ret
