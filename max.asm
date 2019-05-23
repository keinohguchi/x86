; SPDX-License-Identifier: GPL-2.0
	segment	.data
a	dq	1
b	dq	1
max	dq	0
	segment	.text
	global	main
main:
	mov	rax, [a]
	mov	rbx, [b]
	cmp	rax, rbx	; if (a < b) {
	jnl	.else
	mov	[max], rbx	; 	max = b;
	jmp	.end
.else:				; } else {
	mov	[max], rax	; 	max = a;
.end:				; }
	xor	eax, eax
	ret
