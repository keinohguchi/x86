; SPDX-License-Identifier: GPL-2.0
segment .text
global main
main:
	mov	eax, 1	; 1 is the exit syscall number
	mov	ebx, 0	; the status value to return
	int	0x80	; execute a syscam call
