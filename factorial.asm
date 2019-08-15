; SPDX-License-Identifier: GPL-2.0
	section	.data
input	dq	4
	section	.text
	global	main, factorial
main:
	push	rbp
	mov	rbp, rsp
	mov	rdi, [input]
	mov	esi, 1
	call	factorial
	cmp	rax, 24		; 4! == 24
	jne	.fail
	xor	eax, eax
.fail
	leave
	ret
factorial:
	push	rbp
	mov	rbp, rsp
	cmp	rdi, 1
	jg	.more
	mov	rax, rdi
	imul	rax, rsi
	leave
	ret
.more
	imul	rsi, rdi
	dec	rdi
	call	factorial
	leave
	ret
