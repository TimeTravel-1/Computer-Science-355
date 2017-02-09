fmt:	.asciz "%d/n"
		.align 4

		.global main

main:	save %sp, -(92+4) & -8, %sp
		
		mov 3, %o0
		call cube
		nop
		st %o0, [%fp - 4]

		set fmt, %o0
		ld[%fp - 4], %o1
		call printf
		nop

		mov 1, %g1
		ta 0

cube:	save %sp, -92 & -8, %sp
		smul %i0, %i0, %l0
		smul %i0, %l0, %i0

		ret
		restore