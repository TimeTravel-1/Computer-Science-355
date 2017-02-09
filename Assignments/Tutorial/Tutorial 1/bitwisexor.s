fmt:	.asciz	"value is: %x\n"
		.align 	4
		.global main

main:	save 	%sp, 	-96, 	%sp
		
		mov 	0xf, 	%l0		!1111 is our bit mask
		mov 	5, 		%l1		!0101 is our data

		set 	fmt, 	%o0
		call 	printf
		xor 	%l1, 	%l0, 	%o1		!and 1111 0101

		mov 1, 	%g1
		ta 0
