fmt:	.asciz	"value is: %x\n"
		.align 	4
		.global main

main:	save 	%sp, 	-96, 	%sp

		call rand
		nop

		set 	fmt, 	%o0
		call 	printf
		nop
		
		mov 1, 	%g1
		ta 0
