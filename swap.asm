; SPDX-License-Identifier: GPL-2.0
	segment	.data
a	dq	1
b	dq	2
	segment	.text
	global	main
main:
	mov	rax, [a]
	mov	rbx, [b]
	cmp	rax, rbx
	jge	.end
	mov	[a], rbx
	mov	[b], rax
.end:
	xor	eax, eax
	ret
