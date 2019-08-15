; SPDX-License-Identifier: GPL-2.0
	section	.data
fmt	db	"%s ", 0
	section	.text
	global	main
	extern	printf, putchar
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
.more
	mov	[rsp], rsi
	mov	rdx, [rsp]
	mov	rdi, fmt
	mov	rsi, [rdx]
	xor	eax, eax
	call	printf
	mov	rsi, [rsp]
	add	rsi, 8
	mov	rax, [rsi]
	cmp	rax, 0
	jnz	.more
	mov	rdi, 0xa
	call	putchar
	xor	eax, eax
	leave
	ret
