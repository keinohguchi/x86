; SPDX-License-Identifier: GPL-2.0
	section	.data
input	dq	4
result	dq	0
fmt	db	"factorial(%ld)=%ld", 0xa, 0
	section	.text
	global	main
	global	factorial
	extern	printf
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
