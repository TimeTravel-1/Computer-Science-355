fmt:	.asciz	"value is: %x\n"
		.align 	4
		.global main

main:	save 	%sp, 	-96, 	%sp
		
		mov 	0xf, 	%l0		!1111 is our bit mask

		sll		%l0, 	2, 		%o1

		set 	fmt, 	%o0
		call 	printf
		nop
		
		mov 1, 	%g1
		ta 0
