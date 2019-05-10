; SPDX-License-Identifier: GPL-2.0
	segment	.text
	global	main
main:
	push	rbp
	mov	rbp, rsp
	mov	rax, 0x7fffffffffffffff	; set LONG_MAX to rax
	mov	rbx, 256
	imul	rbx			; rax * rbx puts result rdx:rax
	sub	rdx, 0x7f		; make rdx 0 if it's 0x7f
	sub	eax, 0xffffff00		; return 0 if eax is 0xffffff00
	leave
	ret
