; SPDX-License-Identifier: GPL-2.0
	section	.data
data	dq	0xfedcba9876543210
sum	dq	0
	section	.text
	global	main
main:
	push	rbp
	mov	rbp, rsp
	xor	eax, eax
	xor	ebx, ebx
	mov	ecx, 64
	mov	rdx, [data]
.while:
	bt	edx, 0
	setc	bl
	add	eax, ebx
	shr	rdx, 1
	sub	ecx, 1
	jnz	.while
	mov	[sum], rax
	cmp	qword [sum], 32	; data should contains 32 ones
	jnz	.err
	xor	eax, eax
.err
	leave
	ret
