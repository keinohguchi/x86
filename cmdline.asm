; SPDX-License-Identifier: GPL-2.0
	section	.data
fmt	db	"%s ", 0
	section	.text
	global	main
	extern	printf, putchar
main
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	rcx, rsi
	mov	rsi, [rcx]
.more:	lea	rdi, [fmt]
	mov	[rsp], rcx
	xor	eax, eax
	call	printf
	mov	rcx, [rsp]
	add	rcx, 8
	mov	rsi, [rcx]
	cmp	rsi, 0
	jnz	.more
	mov	edi, 0xa
	call	putchar
	xor	eax, eax
	leave
	ret
