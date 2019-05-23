; SPDX-License-Identifier: GPL-2.0
	segment	.data
low	dq	1
mid	dq	2
hi	dq	3
	segment	.bss
result	resq	1
	segment	.text
	global	main
main:
	mov	rdx, [mid]
	mov	rcx, [low]
	mov	eax, -1		; ret = -1
	cmp	rdx, rcx	; if (mid < low)
	jl	.out
	mov	rcx, [hi]
	cmp	rdx, rcx	; else if (mid < hi)
	jge	.else
	xor	eax, eax	;	ret = 0;
	jmp	.out
.else:				; else
	mov	eax, 1		; 	ret = 1;
.out:
	ret
