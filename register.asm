; SPDX-License-Identifier: GPL-2.0
	segment	.data
a	dq	175	; 0xAF
b	dq	4097	; 0x1001
sum	dq	0
diff	dq	0
	segment	.text
	global	main
main:
	mov	rax, a
	mov	rax, [a]
	mov	rbx, rax
	add	rax, [b]
	mov	[sum], rax	; 4272/0x10B0
	sub	rbx, [b]
	mov	[diff], rbx	; -3922/0xFFFFFFFFFFFFF0AE
	xor	eax, eax
	ret
