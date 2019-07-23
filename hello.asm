; SPDX-License-Identifier: GPL-2.0
	segment	.data
msg	db	"Hello world!", 0x0a, 0
	segment	.text
	global	main
	extern	printf
main:
	push	rbp
	mov	rbp, rsp
	lea	rdi, [msg]
	call	printf
	xor	eax, eax
	leave
	ret
