; SPDX-License-Identifier: GPL-2.0
	section	.data
fmt	db	"%s", 0xa, 0
	section	.text
	global	main
	extern	printf
main	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	rcx, rsi
	mov	rsi, [rcx]
.more	mov	[rsp], rcx
	mov	rdi, fmt
	xor	eax, eax
	call	printf
	mov	rcx, [rsp]
	add	rcx, 8
	mov	rsi, [rcx]
	cmp	rsi, 0
	jnz	.more
	xor	eax, eax
	leave
	ret
