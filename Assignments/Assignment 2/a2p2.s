!Assignment 2
!David Ng
!30009245

fmt:							!fmt label		
		
		.asciz "The Multiplicand is: \t0x%8.8x\tThe Multiplier is: \t0x%8.8x\tThe Product is:\t0x%8.8x before multiplication.\n"	!asciz format

fmt1:							!fmt1 label

		.asciz "The Multiplicand is: \t0x%8.8x\tThe Multiplier is: \t0x%8.8x\tThe Product is:\t0x%8.8x after multiplication.\n"		!asciz format
		.align 4				!align	
		.global main 			!global pseudo op

main:							!main label

		save %sp, -96, %sp 		!save instruction
			
		set 0x4ee67b7, %l1		!multiplicand	
		set 0x072e8b8c, %l2		!multiplier
		set 0, %l3				!product
		set 0, %l4				!negative

		set fmt, %o0			!set to display
		mov %l1, %o1			!%l1 register
		mov %l2, %o2 			!%l2 register
								
		call printf				!call printf
		mov %l3, %o3 			!%l3 register

		set 0, %l5				!counter for looping	

		cmp %l2, 0				!check if multiplier negative
		bge loop 				!branch greater or equal to
		cmp %l5, 32				!check if exit loop
		
		mov 1, %l4				!set negative 
		
loop:							!loop label

		cmp %l5, 32				!check if exit loop
		bge,a neg				!branch greater or equal to
		cmp %l4, 1				!check if negative
		
		btst 0x1, %l2			!retrieve least significant bit			
		ble,a mult 				!branch less than or equal to 
		srl %l2, 1, %l2			!shift right logical multiplier
		
		add	%l1, %l3, %l3		!add multiplicand to product
		srl %l2, 1, %l2			!shift right logical multiplier
		
mult:							!mult label

		and	0x1, %l3, %o0		!retrieve rightmost bit
		cmp	%o0, 0				!compare with 0
		ble,a result			!branch less than or equal to
		sra %l3, 1, %l3			!shift right arithmetic product
		
		set	0x80000000, %o0		!set rightmost bit
		add	%o0, %l2, %l2		!add 1 to leftmost bit of product
		sra %l3, 1, %l3			!shift right arithmetic product
	
result:							!result label

		inc %l5					!increment counter
		ba,a loop 				!branch always 
		cmp %l5, 32				!check if exit loop
			
neg:							!neg label

		cmp %l4, 1				!check if negative		
		bne,a output			!branch not equal to 
		set fmt1, %o0			!set to display

		sub %l3, %l1, %l3 		!subtract multiplicand from product
		
output:							!output label
	
		set fmt1, %o0			!set to display
		mov %l1, %o1			!%l1 register
		mov %l2, %o2			!%l2 register
		
		call printf				!calling printf
		mov %l3, %o3			!%l3 register
			
		set 0x4ee67b7, %l1		!multiplicand	
		set 0xf8d17474, %l2		!multiplier
		set 0, %l3				!product
		set 0, %l4				!negative

		set fmt, %o0			!set to display
		mov %l1, %o1			!%l1 register
		mov %l2, %o2 			!%l2 register
								
		call printf				!call printf
		mov %l3, %o3 			!%l3 register

		set 0, %l5				!counter for looping	

		cmp %l2, 0				!check if multiplier negative
		bge loop2 				!branch greater or equal to
		cmp %l5, 32				!check if exit loop
		
		mov 1, %l4				!set negative 
	
loop2:							!loop2 label

		cmp %l5, 32				!check if exit loop
		bge,a neg2				!branch greater or equal to
		cmp %l4, 1				!check if negative set
		
		btst 0x1, %l2			!retrieve least significant bit			
		ble,a mult2 			!branch less than or equal to 
		srl %l2, 1, %l2			!shift right logical multiplier
		
		add	%l1, %l3, %l3		!add multiplicand to product
		srl %l2, 1, %l2			!shift right logical multiplier
		
mult2:							!mult2 label

		and	0x1, %l3, %o0		!retrieve rightmost bit
		cmp	%o0, 0				!compare with 0
		ble,a result2			!branch less than or equal to
		sra %l3, 1, %l3			!shift right arithmetic product
		
		set	0x80000000, %o0		!set rightmost bit
		add	%o0, %l2, %l2		!add 1 to leftmost bit of product
		sra %l3, 1, %l3			!shift right arithmetic product
	
result2:						!result2 label

		inc %l5					!increment counter
		ba,a loop2 				!branch always 
		cmp %l5, 32				!check if exit loop
			
neg2:							!neg2 label

		cmp %l4, 1				!check if negative		
		bne,a output2			!branch not equal to 
		set fmt1, %o0			!set to display

		sub %l3, %l1, %l3 		!subtract multiplicand from product
		
output2:						!output2 label
		
		set fmt1, %o0			!set to display
		mov %l1, %o1			!%l1 register
		mov %l2, %o2			!%l2 register
		
		call printf				!calling printf
		mov %l3, %o3			!%l3 register
			
		set 0xfb119849, %l1		!multiplicand	
		set 0xf8d17474, %l2		!multiplier
		set 0, %l3				!product
		set 0, %l4				!negative

		set fmt, %o0			!set to display
		mov %l1, %o1			!%l1 register
		mov %l2, %o2 			!%l2 register
								
		call printf				!call printf
		mov %l3, %o3 			!%l3 register

		set 0, %l5				!counter for looping	

		cmp %l2, 0				!check if multiplier negative
		bge loop3 				!branch greater or equal to
		cmp %l5, 32				!check if exit loop
		
		mov 1, %l4				!set negative 

loop3:							!loop3 label

		cmp %l5, 32				!check if exit loop
		bge,a neg3				!branch greater or equal to
		cmp %l4, 1				!check if negative set
		
		btst 0x1, %l2			!retrieve least significant bit			
		ble,a mult3 			!branch less than or equal to 
		srl %l2, 1, %l2			!shift right logical multiplier
		
		add	%l1, %l3, %l3		!add multiplicand to product
		srl %l2, 1, %l2			!shift right logical multiplier
		
mult3:							!mult3 label

		and	0x1, %l3, %o0		!retrieve rightmost bit
		cmp	%o0, 0				!compare with 0
		ble,a result3			!branch less than or equal to
		sra %l3, 1, %l3			!shift right arithmetic product
		
		set	0x80000000, %o0		!set rightmost bit
		add	%o0, %l2, %l2		!add 1 to leftmost bit of product
		sra %l3, 1, %l3			!shift right arithmetic product
	
result3:						!result3 label

		inc %l5					!increment counter
		ba,a loop3 				!branch always 
		cmp %l5, 32				!check if exit loop
	
neg3:							!neg3 label

		cmp %l4, 1				!check if negative		
		bne,a output3			!branch not equal to 
		set fmt1, %o0			!set to display

		sub %l3, %l1, %l3 		!subtract multiplicand from product
		
output3:						!output3 label

		set fmt1, %o0			!set to display
		mov %l1, %o1			!%l1 register
		mov %l2, %o2			!%l2 register
		
		call printf				!calling printf
		mov %l3, %o3			!%l3 register

		mov 1, %g1				!exit request
		ta	0					!trap to system
		
