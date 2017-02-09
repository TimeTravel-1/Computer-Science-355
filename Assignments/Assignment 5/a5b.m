!David Ng
!Assignment 5
!30009245

include(macro_defs.m)			!macro defs

define(argc_r, i0)				!pointer to %i0
define(argv_r, i1)				!pointer to %i1

		.align 4				!align
		.global month 			!global pseudo op
month:	.word jan_m, feb_m, mar_m, apr_m, may_m, jun_m, jul_m, aug_m, sep_m, oct_m, nov_m, dec_m	!month label

jan_m:	.asciz "January"		!asciz
feb_m:	.asciz "February"		!asciz
mar_m:	.asciz "March"			!asciz
apr_m:	.asciz "April"			!asciz
may_m:	.asciz "May"			!asciz
jun_m:	.asciz "June"			!asciz
jul_m:	.asciz "July"			!asciz
aug_m:	.asciz "August"			!asciz
sep_m:	.asciz "September"		!asciz
oct_m:	.asciz "October"		!asciz
nov_m:	.asciz "November"		!asciz
dec_m:	.asciz "December"		!asciz

		.section ".text"		!text section
		.align 4				!align

fmt:	.asciz " %dth, %d\n"	!fmt label for standard output
fmt1:	.asciz " %dst, %d\n"	!fmt label for 1st, 21st, 31st
fmt2:	.asciz " %dnd, %d\n"	!fmt label for 2nd, 22d
fmt3:	.asciz " %drd, %d\n"	!fmt label for 3rd, 23rd
fmt5: 	.asciz "usage mm dd yyyy\n"	!error message when three arguments are not present, or when things are out of range. 

		.section ".text"		!text section
		.align 4				!align 
		.global main 			!global pseudo op
main:							!main label
	
		save %sp, -92 & -8, %sp	!save instruction

		cmp %argc_r, 4			!compare with 4 to determine whether or not three arguments were given
		be next					!branch equal to next
		nop						!nop

		set fmt5, %o0			!set fmt5 which is error message
		call printf 			!print
		nop						!nop

		ba end					!branch always to end
		nop						!nop

next:							!next label

		mov 1, %l6				!move 1 to %l6
		sll %l6, 2, %l5			!shift elft logical
							
		ld [%argv_r+%l5], %o0	!load first number (Month) into %o0
		call atoi				!convert string to number
		nop						!nop

		mov %o0, %l1			!move result to %l1

		add 1, %l6, %l6			!increment by 1
		sll %l6, 2, %l5			!shift left logical

		ld [%argv_r+%l5], %o0	!load second number (Date) into %o0
		call atoi				!convert string to number
		nop						!nop

		mov %o0, %l2			!move result to %l2

		add 1, %l6, %l6			!increment by 1
		sll %l6, 2, %l5			!shift left logical

		ld [%argv_r+%l5], %o0	!load third number (Year) into %o0
		call atoi				!convert string to number
		nop						!nop

		mov %o0, %l3			!move result to %l3

		cmp %l1, 0				!compare month with 0
		ble fail				!branch less than or equal to fail
		nop						!nop

		cmp %l1, 12				!compare month with 12
		bg fail					!branch greater than to fail
		nop						!nop

		cmp %l2, 0				!compare date with 0
		ble fail				!branch less than or equal to fail
		nop						!nop

		cmp %l2, 31 			!compare date with 31
		bg fail					!branch greater than to fail
		nop						!nop

		cmp %l3, 0				!compare year with 0
		ble fail				!branch less than or equal to fail
		nop						!nop

		ba continue				!otherwise, continue
		nop						!nop

fail:							!fail label

		set fmt5, %o0			!set fmt5 which is error message
		call printf 			!print
		nop						!nop

		ba end					!branch always to end
		nop						!nop

continue:						!continue label
		
		cmp %l2, 1 				!compare date with 1
		be first				!branch equal to first
		nop						!nop

		cmp %l2, 21 			!compare date with 21
		be first				!branch equal to first
		nop						!nop

		cmp %l2, 31 			!compare date with 31
		be first				!branch equal to first
		nop						!nop

		cmp %l2, 2 				!compare date with 2
		be second				!branch equal to second
		nop						!nop

		cmp %l2, 22 			!compare date with 22
		be second				!branch equal to second
		nop						!nop

		cmp %l2, 3 				!compare date witht 3
		be third				!branch equal to third
		nop						!nop

		cmp %l2, 23 			!compare date with 23
		be third				!branch equal to third
		nop						!nop

		set fmt, %l5			!otherwise, use generic fmt
		ba printout				!branch always to printout
		nop						!nop

first:							!first label
	
		set fmt1, %l5			!set %l5 as fmt1
		ba printout				!branch always to printout
		nop						!nop

second:							!second label
		
		set fmt2, %l5			!set %l5 as fmt2
		ba printout				!branch always to printout
		nop						!nop

third:							!third label

		set fmt3, %l5			!set %l5 as fmt3
		ba printout				!branch always to printout
		nop						!nop

printout:						!printot label

		sll %l1, 2, %l1			!shift left logical
		add -4, %l1, %l1		!subtract 4 to get correct month
		set month, %o2			!set month
		ld [%o2 + %l1], %o0		!load month into %o0

		call printf 			!print
		nop						!nop

		mov %l5, %o0			!move correct fmt to %o0
		mov %l2, %o1			!move date to %o1
		mov %l3, %o2			!move year to %o2
		call printf 			!print
		nop						!nop

end:							!end label
		
		mov 1, %g1				!exit request
		ta 0					!trap to system
