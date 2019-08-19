; SPDX-License-Identifier: GPL-2.0
	segment	.data
fmt	db	"%s: %d! == %d", 0xa, 0
n	dq	4
want	dq	24		; 4! == 24
	segment	.text
	global	main, factorial
	extern	printf
main	push	rbp
	mov	rbp, rsp
.argc	equ	0
.argv	equ	8
.n	equ	16
.want	equ	24
	sub	rsp, 32
	mov	[rsp+.argc], rdi
	mov	[rsp+.argv], rsi
	mov	rax, [n]
	mov	[rsp+.n], rax
	mov	rax, [want]
	mov	[rsp+.want], rax
	mov	rdi, [rsp+.n]
	mov	esi, 1
	call	factorial
	cmp	rax, [rsp+.want]
	jne	.out
	mov	rdi, fmt
	mov	rsi, [rsp+.argv]
	mov	rsi, [rsi+0x0]
	mov	rdx, [rsp+.n]
	mov	rcx, rax
	call	printf
	xor	eax, eax
.out	leave
	ret
factorial
	push	rbp
	mov	rbp, rsp
	cmp	rdi, 1
	jg	.more
	mov	rax, rdi
	imul	rax, rsi
	leave
	ret
.more
	imul	rsi, rdi
	dec	rdi
	call	factorial
	leave
	ret
