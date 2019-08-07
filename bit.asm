; SPDX-License-Identifier: GPL-2.0
	segment	.text
	global	main
main:
	push	rbp
	mov	rbp, rsp
	; shr/shl test
	mov	eax, 0x12345678
	shr	eax, 8			; eax=0x00123456
	and	eax, 0xff		; eax=0x56
	mov	eax, 0x12345678
	mov	edx, 0xaa
	mov	ebx, 0xff
	shl	ebx, 8			; ebx=0xff00
	not	ebx			; ebx=0xffff00ff
	and	eax, ebx		; eax=0x12340078
	shl	edx, 8			; edx=0x0000aa00
	or	eax, edx		; eax=0x1234aa78
	sub	eax, 0x1234aa78		; eax=0
	jnz	.out
	; ror/rol test
	mov	eax, 0x12345678
	ror	eax, 8			; eax=0x78123456
	shr	eax, 4			; eax=0x07812345
	shl	eax, 4			; eax=0x78123450
	or	eax, 1010b		; eax=0x7812345a
	rol	eax, 8			; eax=0x12345a78
	sub	eax, 0x12345a78		; eax=0
	; bt/bts/btr test
	segment	.bss
set	resq	10
	segment	.text
	bts	qword [set], 4		; set[0]=0x0000000000000010
	bts	qword [set], 7		; set[0]=0x0000000000000090
	bts	qword [set], 8		; set[0]=0x0000000000000190
	bts	qword [set+8], 12	; set[1]=0x0000000000001000
	mov	rax, 76
	mov	rbx, rax
	shr	rbx, 6			; rbx=0x0000000000000001
	mov	rcx, rax
	and	rcx, 0x3f		; rcx=0x000000000000000c
	xor	edx, edx
	bt	qword [set+8*rbx], rcx	; check 76th bit
	setc	dl			; edx is equal to the tested bit
	sub	edx, 1b
	jnz	main.out
	xor	edx, edx
	bts	qword [set+8*rbx], rcx	; check and set 76th bit
	setc	dl
	sub	edx, 1b
	jnz	main.out
	xor	edx, edx
	bts	qword [set+8*2], 0	; check and set 124th bit
	setc	dl
	sub	edx, 1b
	jz	main.out
	xor	edx, edx
	btr	qword [set+8*rbx], rcx	; check and reset 76th bit
	setc	dl
	sub	edx, 1b
	jnz	main.out
	xor	edx, edx
	btr	qword [set+8*3], 0	; check and reset 192th bit
	setc	dl
	sub	edx, 1b
	jz	main.out
	xor	eax, eax
main.out:
	leave
	ret
