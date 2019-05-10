; SPDX-License-Identifier: GPL-2.0
	segment	.data
a	dq	246
b	dq	328
c	dq	410
	segment	.text
	global	main
main:
	mov	rax, [a]
	imul	rax, rax	; rax = rax*rax
	mov	rbx, [b]
	imul	rbx, rbx	; rbx = rbx*rbx
	mov	rcx, [c]
	imul	rcx, rcx
	add	rax, rbx	; rax += rbx
	sub	rax, rcx	; return 0 if a^2+b^2==c^2
	ret
