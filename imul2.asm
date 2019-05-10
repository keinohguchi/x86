; SPDX-License-Identifier: GPL-2.0
	segment	.data
x	dq	64
	segment	.text
	global	main
main:
	mov	rax, [x]	; rax == 64
	imul	rax, 100	; rax == 6400
	mov	r9, [x]		;
	mov	r10, 100	;
	imul	r9, r10		; r9 ==  6400
	sub	rax, r9		; return 0 if rax == r9
	ret
