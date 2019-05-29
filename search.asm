; SPDX-License-Identifier: GPL-2.0
	segment	.data
data	db	"hello world", 0
needle	db	'w'
n	dq	0
	segment	.text
	global	main
main:
	mov	bl, [needle]
	xor	ecx, ecx
	mov	al, [data+rcx]
	; if (c == 0)
	cmp	al, 0
	jz	.fail
.do:	; do {
	cmp	al, bl
	je	.found
	inc	rcx
	mov	al, [data+rcx]
	; while (c != 0)
	cmp	al, 0
	jnz	.do
.fail:
	mov	rcx, -1
.found:
	mov	eax, 1
	mov	[n], rcx
	cmp	rcx, 6		; if (n != 6) return 1;
	jne	.out
	xor	eax, eax
.out:
	ret
