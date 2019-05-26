; SPDX-License-Identifier: GPL-2.0
	segment	.data
data	dq	0xfedcba9876543210
sum	dq	0
	segment	.text
	global	main
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	rax, [data]	; data
	xor	ebx, ebx	; bit check
	xor	ecx, ecx	; i = 0;
	xor	edx, edx	; sum = 0;
.while:
	cmp	rcx, 64
	jnl	.end
	bt	rax, 0
	setc	bl
	add	edx, ebx
	shr	rax, 1
	inc	rcx
	jmp	.while
.end:
	mov	eax, 1		; ret = 1;
	cmp	rdx, 32		; if (sum != 32)
	jne	.out
	mov	[sum], rdx
	xor	eax, eax
.out:
	leave
	ret
