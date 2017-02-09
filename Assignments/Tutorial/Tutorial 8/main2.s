	.section “.data”
	.align 4
	
	x_m:	.single 0r7.5
	y_m:	.single 0x2.0
	z_m:	.single 0r0.0
fmt:	
	
	.asciz "result is %f\n"

	.align 4
	.global main

main:
	
	save %sp, -120, %sp
	mov 5.5, %o0
	mov 1.25, %o1
	call subtract
	nop

	mov %o0, %o1
	set fmt, %o0
	call printf
	nop

	mov 1, %g1
	ta 0