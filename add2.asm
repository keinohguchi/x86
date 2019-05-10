; SPDX-License-Identifier: GPL-2.0
	segment	.data
a	dq	151
b	dq	310
sum	dq	0
	segment	.text
	global	main
main:
	push	rbp		; establish a stack frame
	mov	rbp, rsp
	sub	rsp, 16		; make a 16 bytes stack space
	mov	rax, 9		; put 9 to rax register
	add	[a], rax	; add 9 to a, which will be 160
	mov	rax, [b]	; load 310 to rax
	add	rax, 10		; add 10 to rax
	add	rax, [a]	; add a, 160 now, to rax
	mov	[sum], rax	; store rax to sum
	sub	eax, 480	; return 0 if rax hold 480
	leave			; restore the previous stack frame
	ret			; return
