; SPDX-License-Identifier: GPL-2.0
	section	.text
	global	main
main:
	mov	rax, 0x123456789abcdef0	; move 0x123456789abcdef0 to rax register
	mov	eax, 100		; move 100 to eax register, which null out the top half
	xor	eax, eax		; return 0
	ret
