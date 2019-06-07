; SPDX-Licesen-Identifier: GPL-2.0
	segment	.text
	global	main
main:
	push	rbp
	mov	rbp, rsp
	xor	eax, eax
	leave
	ret
