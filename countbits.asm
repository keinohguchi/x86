; SPDX-License-Identifier: GPL-2.0
	segment	.data
data	dq	0xfedcba9876543210	; example data for bit counting
want	dd	32			; 32 ones in data above
prognam	dq	0
passfmt	db	"%s: %#lx contains %d 1(s)", 0xa, 0
	segment	.text
	global	main, parse, check
	extern	strtol, atoi, printf
main	push	rbp
	mov	rbp, rsp
	mov	rax, [rsi]
	mov	[prognam], rax
	cmp	rdi, 3
	jne	.start
	mov	rcx, rsi
	mov	rdi, [rcx+8]	; argv[1]
	mov	rsi, [rcx+16]	; argv[2]
	call	parse
.start	xor	eax, eax
	xor	ebx, ebx
	mov	ecx, 64
	mov	rdx, [data]
.while	bt	edx, 0
	setc	bl
	add	eax, ebx
	shr	rdx, 1
	sub	ecx, 1
	jnz	.while
	mov	rdi, rax
	call	check
	leave
	ret
parse	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	[rsp], rsi
	mov	rsi, 0
	mov	rdx, 16
	call	strtol
	mov	[data], rax
	mov	rdi, [rsp]
	call	atoi
	mov	[want], eax
	leave
	ret
check	cmp	edi, [want]
	jz	.pass
	mov	eax, 1
	ret
.pass	lea	rdi, [passfmt]
	mov	rsi, [prognam]
	mov	rdx, [data]
	mov	ecx, [want]
	xor	eax, eax
	call	printf
	xor	eax, eax
	ret
