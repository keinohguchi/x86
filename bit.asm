; SPDX-License-Identifier: GPL-2.0
	segment	.text
	global	main
main:
	push	rbp
	mov	rbp, rsp
	; shr/shl test
	mov	eax, 0x12345678
	shr	eax, 8		; eax=0x00123456
	and	eax, 0xff	; eax=0x56
	mov	eax, 0x12345678
	mov	edx, 0xaa
	mov	ebx, 0xff
	shl	ebx, 8		; ebx=0xff00
	not	ebx		; ebx=0xffff00ff
	and	eax, ebx	; eax=0x12340078
	shl	edx, 8		; edx=0x0000aa00
	or	eax, edx	; eax=0x1234aa78
	sub	eax, 0x1234aa78	; eax=0
	jnz	.out
	; ror/rol test
	mov	eax, 0x12345678
	ror	eax, 8		; eax=0x78123456
	shr	eax, 4		; eax=0x07812345
	shl	eax, 4		; eax=0x78123450
	or	eax, 1010b	; eax=0x7812345a
	rol	eax, 8		; eax=0x12345a78
	sub	eax, 0x12345a78	; eax=0
.out:
	leave
	ret
