; SPDX-License-Identifier: GPL-2.0
	segment	.data
fmt	db	"%s: %#lx contains %d 1(s)", 0xa, 0
data	dq	0xfedcba9876543210	; example data for bit counting
want	dd	32			; 32 ones in data above
	segment	.text
	global	main
	extern	strtol, atoi, printf
main
	push	rbp
	mov	rbp, rsp
.argc	equ	0
.argv	equ	8
.data	equ	16
.want	equ	24
	sub	rsp, 32
	mov	[rsp+.argc], rdi
	mov	[rsp+.argv], rsi
	cmp	rdi, 3
	jne	.default
	mov	rdi, [rsi+8]
	mov	rsi, 0
	mov	rdx, 16
	call	strtol
	mov	[rsp+.data], rax
	mov	rsi, [rsp+.argv]
	mov	rdi, [rsi+16]
	call	atoi
	mov	[rsp+.want], rax
	jmp	.start
.default
	mov	rax, [data]
	mov	[rsp+.data], rax
	mov	eax, [want]
	mov	[rsp+.want], rax
.start	xor	eax, eax
	xor	ebx, ebx
	mov	ecx, 64
	mov	rdx, [rsp+.data]
.while	bt	edx, 0
	setc	bl
	add	eax, ebx
	shr	rdx, 1
	sub	ecx, 1
	jnz	.while
	cmp	eax, [rsp+.want]
	jne	.out
	mov	rdi, fmt
	mov	rsi, [rsp+.argv]
	mov	rsi, [rsi+0x0]
	mov	rdx, [rsp+.data]
	mov	rcx, rax
	xor	eax, eax
	call	printf
	xor	eax, eax
.out	leave
	ret
