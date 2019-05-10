; SPDX-License-Identifier: GPL-2.0
	segment .text
	global main
main:
	mov	eax, 1	; 1 is the exit syscall number
	mov	ebx, 0	; EXIT_SUCCESS(0) to exit(2)
	int	0x80	; execute a syscam call
