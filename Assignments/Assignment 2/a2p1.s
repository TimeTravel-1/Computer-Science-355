!Assignment 2
!David Ng
!30009245

fmt:							!fmt label										

		.asciz "Value of Checksum is: \t0x%8.8x\tValue of Input Register is: \t0x%8.8x\t before data is fed.\n"	!asciz format

fmt1:							!fmt1 label
		
		.asciz "Value of Checksum is: \t0x%8.8x\tValue of Input Register is: \t0x%8.8x\t after data is fed.\n"	!asciz format
		.align 4				!align
		.global main			!global pseudo op

main:							!main label

		save %sp, -96, %sp 		!save instruction
		
		set 0x0000ffff, %l0		!set checksum register
		set 0xaaaa8c01, %l4		!set %l4 register
		set 0xff001234, %l5		!set %l5 register
		set 0x13579bdf, %l6		!set %l6 register
		set 0xc8b4ae32,	%l7		!set %l7 register
		
loop:							!loop label

		mov 0, %l1				!set counter

		set fmt, %o0			!set to display	
		mov	%l0, %o1			!%l0 register
						
		call printf				!print out values
		mov %l4, %o2			!%l4 register from above

test:							!test label

      	cmp %l1, 31             !compare counter to step through range from 0 to 31
      	bg,a done             	!branch greater than to done
      	set 0xffff0000, %l3		!(first instruction after done) set bitmask to retrieve only the 16 rightmost bits of %l0

      	sll	%l0, 1, %l0			!shift left logical by one
		set 0x80000000, %l3		!set bitmask to find leftmost bit

      	btst %l4, %l3			!btst to determine leftmost bit					
      	be leftmost				!branch equal 
      	sll %l4, 1, %l4			!shift left logical by one

      	add 1, %l0, %l0			!increment %l0 by 1 if leftmost bit of %l4 was 1

leftmost:						!leftmost label
	
		set 0x10000, %l3		!set bitmask to retrieve 17th bit (since 16th was shifted to the left)

		btst %l0, %l3 			!btst to determine xor operation
      	be doxor				!branch equal 
      	set 0x1021, %l3			!set bitmask to xor (toggle) the 13th, 6th, and 1st bit (since they are shifted to the left)
      	
		btog %l3, %l0			!xor operation

doxor:							!doxor label
		
		ba test					!branch always
		inc %l1					!increment counter

done:							!done label
		
		bclr %l3, %l0			!bclr

		set fmt1, %o0			!set to display
		mov	%l0, %o1			!%l0 register
		
		call printf				!print out values
		mov %l4, %o2			!%l4 register					
		
		ba loop1				!branch always

loop1:							!loop1 label

		mov 0, %l1				!set counter

		set fmt, %o0			!set to display	
		mov	%l0, %o1			!%l0 register
		
		call printf				!print out values
		mov %l5, %o2			!%l5 register

test1:							!test1 label

      	cmp %l1, 31             !compare counter to step through range from 0 to 31
      	bg,a done1             	!branch greater than to done1
      	set 0xffff0000, %l3		!set bitmask to retrieve only the 16 rightmost bits of %l0

      	sll	%l0, 1, %l0			!shift left logical by one
		set 0x80000000, %l3		!set bitmask to find leftmost bit

      	btst %l5, %l3			!btst to determine leftmost bit					
      	be leftmost1			!branch equal 
      	sll %l5, 1, %l5			!shift left logical by one

      	add 1, %l0, %l0			!increment %l0 by 1 if leftmost bit of %l5 was 1

leftmost1:						!leftmost1 label
	
		set 0x10000, %l3		!set bitmask to retrieve 17th bit (since 16th was shifted to the left)

		btst %l0, %l3 			!btst to determine xor operation
      	be doxor1				!branch equal 
      	set 0x1021, %l3			!set bitmask to xor (toggle) the 13th, 6th, and 1st bit (since they are shifted to the left)

      	btog %l3, %l0			!xor operation
      	
doxor1:							!doxor1 label

		ba test1				!branch always
		inc %l1					!increment counter

done1:							!done1 label
		
		bclr %l3, %l0			!bclr

		set fmt1, %o0			!set to display
		mov	%l0, %o1			!%l0 register
		
		call printf				!print out values
		mov %l5, %o2			!%l5 register

		ba loop2				!branch always

loop2:							!loop2 label

		mov 0, %l1				!set counter

		set fmt, %o0			!set to display	
		mov	%l0, %o1			!%l0 register
		
		call printf				!print out values
		mov %l6, %o2			!%l6 register

test2:							!test2 label

      	cmp %l1, 31             !compare counter to step through range from 0 to 31
      	bg,a done2             	!branch greater than to done2
      	set 0xffff0000, %l3		!set bitmask to retrieve only the 16 rightmost bits of %l0
		
      	sll	%l0, 1, %l0			!shift left logical by one
		set 0x80000000, %l3		!set bitmask to find leftmost bit

      	btst %l6, %l3			!btst to determine leftmost bit					
      	be leftmost2			!branch equal 
      	sll %l6, 1, %l6			!shift left logical by one

      	add 1, %l0, %l0			!increment %l0 by 1 if leftmost bit of %l6 was 1

leftmost2:						!leftmost2 label
	
		set 0x10000, %l3		!set bitmask to retrieve 17th bit (since 16th was shifted to the left)

		btst %l0, %l3 			!btst to determine xor operation
      	be doxor2				!branch equal 
      	set 0x1021, %l3			!set bitmask to xor (toggle) the 13th, 6th, and 1st bit (since they are shifted to the left)

      	btog %l3, %l0			!xor operation

doxor2:							!doxor2 label

		ba test2				!branch always
		inc %l1					!increment counter

done2:							!done2 label

		bclr %l3, %l0			!bclr

		set fmt1, %o0			!set to display
		mov	%l0, %o1			!%l0 register
		
		call printf				!print out values
		mov %l6, %o2			!%l6 register

		ba loop3				!branch always

loop3:							!loop3 label

		mov 0, %l1				!set counter

		set fmt, %o0			!set to display	
		mov	%l0, %o1			!%l0 register
		
		call printf				!print out values
		mov %l7, %o2			!%l7 register

test3:							!test3 label

      	cmp %l1, 31             !compare counter to step through range from 0 to 31
      	bg,a done3             	!branch greater than to done
      	set 0xffff0000, %l3		!set bitmask to retrieve only the 16 rightmost bits of %l0
		

      	sll	%l0, 1, %l0			!shift left logical by one
		set 0x80000000, %l3		!set bitmask to find leftmost bit

      	btst %l7, %l3			!btst to determine leftmost bit					
      	be leftmost3			!branch equal 
      	sll %l7, 1, %l7			!shift left logical by one

      	add 1, %l0, %l0			!increment %l0 by 1 if leftmost bit of %l7 was 1

leftmost3:						!leftmost3 label
	
		set 0x10000, %l3		!set bitmask to retrieve 17th bit (since 16th was shifted to the left)

		btst %l0, %l3 			!btst to determine xor operation
      	be doxor3				!branch equal 
      	set 0x1021, %l3			!set bitmask to xor (toggle) the 13th, 6th, and 1st bit (since they are shifted to the left)
		
		btog %l3, %l0			!xor operation

doxor3:							!doxor3 label

		ba test3				!branch always
		inc %l1					!increment counter

done3:							!done3 label

		bclr %l3, %l0			!bclr

		set fmt1, %o0			!set to display
		mov	%l0, %o1			!%l0 register
		
		call printf				!print out values
		mov %l7, %o2			!%l7 register

		mov 1, %g1				!exit request
		ta 0 					!trap to system
