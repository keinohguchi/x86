; SPDX-License-Identifier: GPL-20
	segment	.data
a	dq	100
b	dq	200
diff	dq	0
	segment	.text
	global	main
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	rax, 10		; add 10 to a, which makes a 110
	sub	[a], rax	; subtract rax from a, a == -10
	sub	[b], rax	; subtract rax from b, b == 90
	mov	rax, [b]	; load b into rax, rax == 90
	sub	rax, [a]	; subtract a from rax, rax == 100
	mov	[diff], rax	; subtract a from b, diff == 100
	sub	eax, 100	; return 0 if rax/eax is 100
	leave
	ret
