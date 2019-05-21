; SPDX-License-Identifier: GPL-2.0
	segment	.data
switch:
	dq	main.case0
	dq	main.case1
	dq	main.case2
i	dq	2
	segment	.text
	global	main
main:
	mov	rax, [i]	; rax == 2
	jmp	[switch+rax*8]	; switch[16] == main.case2
.case0:
	mov	rbx, 100
	jmp	.end
.case1:
	mov	rbx, 101
	jmp	.end
.case2
	mov	rbx, 102
	jmp	.end
.end
	xor	eax, eax
	ret
