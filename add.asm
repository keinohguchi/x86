; SPDX-License-Identifier: GPL-2.0
	segment	.data
a	dq	175
b	dq	4097
	segment	.text
	global	main
main:
	mov	rax, a		; move address of a into rax
	mov	rax, [a]	; move a (175) into rax
	add	rax, [b]	; add b (4097) to rax
	xor	eax, eax	; return 0
	ret
