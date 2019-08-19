; SPDX-License-Identifier: GPL-2.0
	segment	.data
prognam	dq	0
n	dq	4
want	dq	24
fmt	db	"%s: %ld! == %ld", 0xa, 0
failfmt	db	"%s: %ld!(%ld) != %ld", 0xa, 0
	segment	.text
	global	main, factorial
	extern	atoi, printf
main	push	rbp
	mov	rbp, rsp
	mov	rax, [rsi]
	mov	[prognam], rax
	cmp	rdi, 3
	jne	.start
	sub	rsp, 16
	mov	[rsp], rsi
	mov	rdi, [rsi+8]
	call	atoi
	mov	[n], rax
	mov	rsi, [rsp]
	mov	rdi, [rsi+16]
	call	atoi
	mov	[want], rax
.start	mov	rdi, [n]
	mov	esi, 1
	call	factorial
	cmp	rax, [want]
	jz	.pass
	mov	rdi, failfmt
	mov	rsi, [prognam]
	mov	rdx, [n]
	mov	rcx, rax
	mov	r8, [want]
	xor	eax, eax
	call	printf
	mov	eax, 1
	jmp	.out
.pass	mov	rdi, fmt
	mov	rsi, [prognam]
	mov	rdx, [n]
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
