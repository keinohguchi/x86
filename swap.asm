; SPDX-License-Identifier: GPL-2.0
	segment	.data
a	dq	1
b	dq	2
	segment	.text
	global	main
main:
	mov	rdx, [a]
	mov	rcx, [b]
	mov	eax, 1		; ret = 1;
	cmp	rdx, rcx	; if (a < b) {
	jge	.end
	mov	[a], rbx	;	a = b;
	mov	[b], rax	;	b = a;
	xor	eax, eax	;	ret = 0;
	jmp	.end		; }
.end:
	ret			; return ret;
