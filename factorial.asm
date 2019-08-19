; SPDX-License-Identifier: GPL-2.0
	segment	.data
n	dq	4
want	dq	24		; 4! == 24
	segment	.text
	global	main, factorial
main	push	rbp
	mov	rbp, rsp
.n	equ	0
.want	equ	8
	sub	rsp, 16
	mov	rax, [n]
	mov	[rsp+.n], rax
	mov	rax, [want]
	mov	[rsp+.want], rax
	mov	rdi, [rsp+.n]
	mov	esi, 1
	call	factorial
	cmp	rax, [rsp+.want]
	jne	.out
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
