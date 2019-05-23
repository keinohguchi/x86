; SPDX-License-Identifier: GPL-2.0
	segment	.data
a	dq	1
b	dq	2
max	dq	0
	segment	.text
	global	main
main:
	mov	rdx, [a]
	mov	rcx, [b]
	mov	eax, 1		; ret = 1;
	cmp	rdx, rcx	; if (a < b) {
	jnl	.end
	mov	rdx, rcx	; 	a = b;
	xor	eax, eax	;	ret = 0;
.end:				; }
	mov	[max], rdx	; max = a;
	ret
