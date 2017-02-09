!Assignment 6
!David Ng	
!30009245

	include(macro_defs.m)			!macro defs

	define(OPEN, 5)					!OPEN
	define(READ, 3)					!READ
	define(CLOSE, 6)				!CLOSE
	
fmt: .asciz "\t  Input Value (x)      Output Value (e^x)   Output Value (e^-x)\n\n"		!fmt label
fmt1: .asciz " %20.9f"				!fmt1 label
fmt2: .asciz " %20.9f\n"			!fmt2 label

	.align 8 						!align
	local_var						!local variable 
	var(buf, 1, 1*8)				!buf

	.section ".data"				!data section
	.align 8 						!align
	.global factorial_m, limit_m	!global variables
factorial_m: .double 0r1.0			!double 1.0
limit_m: .double 0r1.0e-10			!double limit

	.section ".text"				!text section
	.align 4						!align
	.global epowerx					!global pseudo op
epowerx:							!epowerx label (same routine is used for e^x and e^-x, as described possible by Professor Manzara)
	save %sp, (-92-8) & -8, %sp		!save instruction

	set factorial_m, %l0			!set factorial_m
	set limit_m, %l1				!set limit_m

	ldd [%l0], %f2					!load 1 to %f2
	ldd [%l0], %f4					!load 1 to %f4
	ldd [%l0], %f6					!load 1 to %f6		
	ldd [%l0], %f8					!load 1 to %f8	
	ldd [%l0], %f10					!load 1 to %f10
	ldd [%l1], %f12					!load 1 to %f12

	std %i0, [%fp - 8]				!store
	ldd [%fp - 8], %f0 				!load to %f0

loop:								!loop label

	fmuld %f4, %f0, %f4				!multiply for x^n (numerator)
	fmuld %f2, %f6, %f2				!multiply for factorial (denominator)
	faddd %f6, %f8, %f6 			!add to present result
	fdivd %f4, %f2, %f14			!divide to get fraction
	faddd %f10, %f14, %f10			!add temporary result

	fabss %f14, %f16				!find absolute value
	fmovs %f15, %f17				!low order bits

	fcmpd %f16, %f12				!compare with limit
	nop								!nop

	fbl continue					!branch less than to continue
	nop								!nop
	
	ba loop							!branch always to loop
	nop								!nop

continue:							!continue label
	
	ret 							!ret
	restore							!restore

	.global main 					!global pseudo op
main: 								!main label
	save %sp, (-92-16)&-8, %sp		!save instruction

	set fmt, %o0					!set fmt
	call printf 					!print
	nop								!nop

	ld [%i1 + 4], %o0 				!load file
	clr %o1							!clear  		
	clr %o2 						!clear  

	mov OPEN, %g1					!open
	ta 0 							!trap to system

	mov %o0, %l0					!file descriptor 
	add %fp, buf, %l1				!calculate offset

	bcc read_ok						!check connection
	mov 1, %g1						!exit request
	ta 0 							!trap to system

read_ok:							!read_ok label used to loop to read data
	
	mov %l0, %o0					!file descriptor
	mov %l1, %o1					!offet
	mov 8, %o2 						!amount to read

	mov READ, %g1					!read 
	ta 0 							!trap to system

	cmp %o0, 8						!compare with 8
	bl end							!branch less than to
	nop								!nop

	set fmt1, %o0					!set fmt1

	ldd [%l1], %f0					!load to %f0	
	std %f0, [%fp - 8]				!store to stack
	ld [%fp - 8], %o1				!load to %o1	
	ld [%fp - 4], %o2				!load to %o2		
	
	call printf						!print 
	nop								!nop
	
	ldd [%l1], %o0					!load to %o0

	call epowerx					!call epowerx
	nop								!nop

	set fmt1, %o0					!set fmt1
	
	std %f10, [%fp-16]				!store the returned result on the stack below the read bytes	
	ld [%fp - 16], %o1				!load to %o1
	ld [%fp - 12], %o2				!load to %o2
	
	call printf						!print
	nop								!nop
	
	add %fp, buf, %l1				!buffer 
		
	ldd [%l1], %f0					!load to %f0
	fnegs %f0, %f0					!find -x
	
	std %f0, [%fp-16]				!store to stack
	ldd [%fp-16], %o0				!load to %o0

	call epowerx					!call epowerx	
	nop								!nop
	std %f10, [%fp-16]				!store result to stack
	
	set fmt2, %o0					!set fmt2

	ld [%fp -16], %o1				!load to %o1
	ld [%fp - 12], %o2				!load to %o2
	call printf 					!print
	nop								!nop
	
	ba read_ok						!branch always to read_ok
	nop								!nop

end:								!end label

	mov CLOSE, %g1					!CLOSE	
	ta 0 							!trap to system
	
	mov 1, %g1						!exit request
	ta 0 							!trap to system
