; SPDX-License-Identifier: GPL-2.0
	segment	.data
x	dq	325	; dividend
y	dq	16	; divisor
quot	dq	0	; quotient
rem	dq	0	; remainder
	segment	.text
	global	main
main:
	mov	rax, [x]
	mov	rdx, 0		; remainder will be stored in rdx
	idiv	qword [y]	; divide x by y
	mov	[quot], rax	; quotient is in rax
	mov	[rem], rdx	; remainder is in rdx
	sub	rax, 20		; return 0 if quotient is 20
	ret

