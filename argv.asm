; SPDX-License-Identifier: GPL-2.0
	segment	.data
format:	db	"%s", 0xa, 0
	segment	.text
	global	main, printf
main:
	push	rbp
	mov	rbp, rsp
	mov	rdx, [format]
	sub	rsp, 16		; 16 bytes stack alignment
.i	equ	0
	mov	rcx, rsi	; copy the argv to rcx
	xor	rax, rax
	leave
	ret
