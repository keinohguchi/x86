; SPDX-License-Identifier: GPL-2.0
	segment	.data
prognam	dq	0
n	dq	4
want	dq	24
passfmt	db	"%s: %ld! == %ld", 0xa, 0
failfmt	db	"%s: %ld!(%ld) != %ld", 0xa, 0
	segment	.text
	global	main, factorial, parse, check
	extern	atoi, printf
main	push	rbp
	mov	rbp, rsp
	mov	rax, [rsi]	; argv[0]
	mov	[prognam], rax
	cmp	edi, 3
	jnz	.start
	mov	rcx, rsi
	mov	rdi, [rcx+8]	; argv[1]
	mov	rsi, [rcx+16]	; argv[2]
	call	parse
.start	mov	rdi, [n]
	mov	esi, 1
	call	factorial
	mov	rdi, rax
	call	check
	leave
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
parse	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	[rsp], rsi
	call	atoi
	mov	[n], rax
	mov	rdi, [rsp]
	call	atoi
	mov	[want], rax
	leave
	ret
check	cmp	rdi, [want]
	jz	.pass
	lea	rdi, [failfmt]
	mov	rsi, [prognam]
	mov	rdx, [n]
	mov	rcx, rax
	mov	r8, [want]
	xor	eax, eax
	call	printf
	mov	eax, 1
	ret
.pass	lea	rdi, [passfmt]
	mov	rsi, [prognam]
	mov	rdx, [n]
	mov	rcx, rax
	xor	eax, eax
	call	printf
	xor	eax, eax
	ret
