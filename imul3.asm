; SPDX-License-Identifier: GPL-2.0
	segment	.data
x	dq	32
	segment	.text
	global	main
main:
	imul	rbx, [x], 100	; rbx == 32*100
	imul	rdx, rbx, 50	; rdx == rbx(3200)*50
	mov	rax, rdx	; store rdx in rax
	sub	rax, 160000	; return 0 if rdx == 160000
	ret
