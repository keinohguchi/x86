; SPDX-License-Identifier: GPL-2.0
	segment	.bss
set	resq	10
	segment	.text
	global	main
main:
	push	rbp
	mov	rbp, rsp
	bts	qword [set], 4		; set bit 4 of set
	bts	qword [set], 7		; set bit 7 of set
	bts	qword [set], 8		; set bit 8 of set
	bts	qword [set+8], 12	; set bit 76(8*8+12) of set
	mov	rax, 76			; rax=76
	mov	rbx, rax		; rbx=76
	shr	rbx, 6			; rbx=1, 76>>6, aka 76/64
	mov	rcx, rax		; rcx=76
	and	rcx, 0x3f		; rcx=12, 76&0x3f, aka 76%64
	xor	edx, edx		; rdx=0
	bt	[set+8*rbx], rcx	; test_bit(12, (char *)set+8*1)
	setc	dl			; edx equals the tested bit
	bts	[set+8*rbx], rcx	; test_and_set_bit(12, (char *)set+8*1)
	btr	[set+8*rbx], rcx	; test_and_clear_bit(12, (char *)set+8*1)
	xor	rax, rax
	ret
