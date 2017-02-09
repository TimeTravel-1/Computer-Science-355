 




		.align 4
		.global month
month:	.word jan_m, feb_m, mar_m, apr_m, may_m, jun_m, jul_m, aug_m, sep_m, oct_m, nov_m, dec_m

jan_m:	.asciz "January"
feb_m:	.asciz "February"
mar_m:	.asciz "March"
apr_m:	.asciz "April"
may_m:	.asciz "May"
jun_m:	.asciz "June"
jul_m:	.asciz "July"
aug_m:	.asciz "August"
sep_m:	.asciz "September"
oct_m:	.asciz "October"
nov_m:	.asciz "November"
dec_m:	.asciz "December"



		.section ".text"		
		.align 4

fmt:	.asciz " %dth, %d\n"
fmt1:	.asciz " %dst, %d\n"
fmt2:	.asciz " %dnd, %d\n"
fmt3:	.asciz " %drd, %d\n"
fmt4:	.asciz " %d\n"
fmt5: 	.asciz "usage mm dd yyyy\n"


		.section ".text"
		.align 4
		.global main
main:
	
		save %sp, -92 & -8, %sp	

		cmp %i0, 4
		be next
		nop

		set fmt5, %o0
		call printf
		nop

		ba end
		nop

next:
		
		ld [%i1+4], %o0
		call atoi
		nop

		mov %o0, %l1

		ld [%i1+8], %o0
		call atoi
		nop

		mov %o0, %l2

		ld [%i1+12], %o0
		call atoi
		nop

		mov %o0, %l3

		cmp %l1, 0
		bg continue
		nop

		ba fail
		nop

		cmp %l1, 12
		ble continue
		nop

		ba fail
		nop

		cmp %l2, 0
		bg continue
		nop

		ba fail
		nop

		cmp %l2, 31
		ble continue
		nop

		ba fail
		nop

		cmp %l3, 0
		bg continue
		nop

		ba fail
		nop

fail:	

		set fmt5, %o0
		call printf
		nop

		ba end
		nop

continue:

		sll %l1, 2, %l1
		add -4, %l1, %l1
		set month, %o2
		ld [%o2 + %l1], %o1
		
		cmp %l2, 1
		be first
		nop

		cmp %l2, 21
		be first
		nop

		cmp %l2, 31
		be first
		nop

		cmp %l2, 2
		be second
		nop

		cmp %l2, 22
		be second
		nop

		cmp $l2, 3
		be third

		cmp $l2, 23
		be third

		set fmt, %o0
		ba printout
		nop

first:	
	
		set fmt1, %o0
		ba printout
		nop

second:
		
		set fmt2, %o0
		ba printout
		nop

third:	

		set fmt3, %o0
		ba printout
		nop

printout:

		mov $l2, %o1
		call printf
		nop

end:
		
		mov 1, %g1
		ta 0
