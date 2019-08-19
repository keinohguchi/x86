; SPDX-License-Identifier: GPL-2.0
	segment	.data
fmt	db	"%s: %ld! == %ld", 0xa, 0
failfmt	db	"%s: %ld!(%ld) != %ld", 0xa, 0
n	dq	4
want	dq	24		; 4! == 24
	segment	.text
	global	main, factorial
	extern	atoi, printf
main	push	rbp
	mov	rbp, rsp
.arg0	equ	0
.argv	equ	8
.n	equ	16
.want	equ	24
	sub	rsp, 32
	mov	rax, [rsi]
	mov	[rsp+.arg0], rax
	mov	[rsp+.argv], rsi
	cmp	rdi, 3
	jne	.default
	mov	rcx, [rsp+.argv]
	mov	rdi, [rcx+8]
	call	atoi
	mov	[rsp+.n], rax
	mov	rcx, [rsp+.argv]
	mov	rdi, [rcx+16]
	call	atoi
	mov	[rsp+.want], rax
	jmp	.start
.default
	mov	rax, [n]
	mov	[rsp+.n], rax
	mov	rax, [want]
	mov	[rsp+.want], rax
.start	mov	rdi, [rsp+.n]
	mov	esi, 1
	call	factorial
	cmp	rax, [rsp+.want]
	jz	.pass
	mov	rdi, failfmt
	mov	rsi, [rsp+.arg0]
	mov	rdx, [rsp+.n]
	mov	rcx, rax
	mov	r8, [rsp+.want]
	xor	eax, eax
	call	printf
	mov	eax, 1
	jmp	.out
.pass	mov	rdi, fmt
	mov	rsi, [rsp+.arg0]
	mov	rdx, [rsp+.n]
	mov	rcx, rax
	xor	eax, eax
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
