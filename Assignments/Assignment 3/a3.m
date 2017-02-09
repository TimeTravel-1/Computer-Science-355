!Assignment 3
!David Ng
!30009245

define(local_var, `define(last_sym, 0)')	!macro
define(`var', `define(`last_sym', eval((last_sym - ifelse($3,,$2,$3)) & -$2))$1 = last_sym')	!macro
define(`end_main', `mov 1, %g1 
	ta 0')							!macro
	
local_var							!local variables
var(v_s, 4, 4*40)					!array v

define(i_r, l0)						!register int i
define(j_r, l1)						!register int j
define(tmp_r, l2)					!register int tmp
define(SIZE, 40)					!size constant

fmt:								!fmt label

		.asciz "v[%-d]: %d\n"		!asciz

fmt1:								!fmt label

		.asciz "\nSorted array:\n"	!asciz
		.align 4					!align	
		.global main 				!global pseudo op

main:								!main label

		save %sp, eval((-92 + last_sym) & -8), %sp 	!save instruction
		mov 0, %i_r					!initialize i to 0
		

test:								!test label

		cmp %i_r, SIZE           	!compare i with 40 to decide when to exit loop
     	bge,a sort					!branch greater than or equal to
     	mov 1, %i_r					!set i to 1

     	call rand					!call for a random positive integer
     	set 0x000000FF, %l3			!0xFF

     	
     	and	%l3, %o0, %o0			!rand() & 0xFF

		sll	%i_r, 2, %o3			!multiply i by 4
     	add %fp, %o3, %o3			!add frame pointer
		st %o0,	[%o3 + v_s]			!store in array

		mov %o0, %o3				!move array element to %o3

     	set fmt, %o0				!set to display
     	mov %i_r, %o1				!i value
     	

     	call printf 				!call printf
     	mov %o3, %o2				!v[i] value

     	
     	ba test						!branch always to test
     	add %i_r, 1, %i_r			!increment i

sort:								!sort label

		cmp %i_r, SIZE				!compare i with 40
		bge printdata				!branch greater than or equal to
		sll %i_r, 2, %o3			!multiply i by 4

		
		add %fp, %o3, %o3			!add frame pointer
		ld [%o3 + v_s], %o3			!load array value

		mov %o3, %tmp_r				!move array value to tmp
		mov %i_r, %j_r				!set j to be equal to i

innerloop:							!innerloop label

		cmp %j_r, 0 				!compare j with 0
		ble endloop					!branch less than or equal to
		add %j_r, -1, %l4			!store j-1

		
		sll %l4, 2, %o3				!multiply j-1 by 4	
		add %fp, %o3, %o3			!add frame pointer
		ld [%o3 + v_s], %o3			!load array value

		cmp %tmp_r, %o3				!compare tmp with value
		bge endloop					!branch greater than or equal to
		sll %j_r, 2, %o4			!multiply j by 4

		
		add %fp, %o4, %o4			!add frame pointer
		st %o3, [%o4 + v_s]			!store value to array

		
		ba innerloop				!branch always to innerloop
		add %j_r, -1, %j_r			!subtract 1 from j

endloop:							!endloop label

		sll %j_r, 2, %o3			!multiply j by 4	
		add %fp, %o3, %o3			!add frame pointer
		st %tmp_r, [%o3 + v_s]		!store value	

		
		ba sort 					!branch always to sort
		add %i_r, 1, %i_r			!add 1 to i

printdata:							!printdata label
	
		set fmt1, %o0				!set format
		call printf 				!call printf
		mov 0, %i_r					!move 0 to i

printloop:							!printloop label

		cmp %i_r, SIZE				!compare i with 40
		bge done					!branch greater than or equal to
		sll	%i_r, 2, %o3			!multiply i by 4

		
     	add %fp, %o3, %o3			!add frame pointer
     	ld [%o3 + v_s], %o2			!load array value	

		set fmt, %o0				!set to display
     	
     	
     	call printf 				!call printf
     	mov %i_r, %o1				!move i to print

     	
     	ba printloop				!branch always to printloop
     	add %i_r, 1, %i_r			!add 1 to i

done:								!done label

		end_main					!exit request and trap to system
