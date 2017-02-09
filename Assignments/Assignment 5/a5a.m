!Assignment 5
!David Ng
!30009245

include(macro_defs.m)			!macro defs

define(STACKSIZE, 5)			!STACKSIZE macro
define(FALSE, 0)				!FALSE macro				
define(TRUE, 1)					!TRUE macro

		.section ".bss"			!bss section
		.align 4				!align
stack:							!stack label

		.skip 4 * STACKSIZE		!skip for stack global variable

		.section ".data"		!data section
		.global top_m			!global pseudo op
top_m:	.word -1				!top global variable

		.section ".text"		!text section
fmt6:	.asciz	"\nStack overflow! Cannot push value onto stack.\n"	!asciz for overflow error message

		.align 4				!align
		.global push 			!global pseudo op
push:							!push label
	
		save %sp, -92 & -8, %sp !save instruction

		call stackFull 			!call stackFull
		nop						!nop

		mov %o0, %g1			!%o0 to %g1
		cmp %g1, 1				!compare with 1
		bne pushElse			!branch not equal to pushElse
		nop						!nop

		set fmt6, %o0			!set fmt6
		call printf 			!print
		nop						!nop

		ba pushEnd				!branch always to pushEnd
		nop						!nop

pushElse:						!pushElse label

		sethi %hi(stack), %g1	!sethi of stack
		or %g1, %lo(stack), %o4	!or with lo of stack
	
		sethi %hi(top_m), %g1	!sethi of top_m
		or %g1, %lo(top_m), %o5	!or with lo of top_m
	
		sethi %hi(top_m), %g1	!sethi of top_m
		or %g1, %lo(top_m), %g1	!or with lo of top_m
	
		ld [%g1], %g1			!load
		add	%g1, 1, %g1			!add top by 1
	
		st %g1, [%o5]			!store
		sll	%g1, 2, %o5			!shift left logical

		st %i0, [%o4+%o5]		!store value in stack[++top]
	
pushEnd:						!pushEnd label

		ret 					!ret
		restore					!restore

fmt7:	.asciz	"\nStack underflow! Cannot pop an empty stack.\n"	!asciz

define(value_r, l0)				!define value_r

		.align 4				!align
		.global pop 			!global pseudo op
pop:							!pop label

		save %sp, -92 & -8, %sp !save instruction

		call stackEmpty 		!call stackEmpty
		nop						!nop

		mov %o0, %g1			!%o0 to %g1
		cmp %g1, 1				!compare with 1
		bne popElse				!branch not equal to
		nop						!nop

		set fmt7, %o0			!set fmt7 to display underflow error message
		call printf 			!print
		nop						!nop

		mov -1, %i0				!return -1

		ba popEnd				!branch always to popEnd
		nop						!nop

popElse:						!popElse label

		sethi	%hi(stack), %g1	!sethi of stack
		or %g1, %lo(stack), %o5	!or with lo of stack

		set top_m, %o1			!set top_m
		ld [%o1], %l1			!load top_m to %l1

		sll %l1, 2, %o3			!shift left logical
		
		ld [%o3 +%o5], %value_r	!load stack[top] into value

		sethi %hi(top_m), %g1	!sethi of top_m
		or %g1, %lo(top_m), %o5	!or with lo of top_m

		sethi %hi(top_m), %g1	!sethi of top_m
		or %g1, %lo(top_m), %g1 !or with lo of top_m

		ld [%g1], %l1			!load 
		add %l1, -1, %l1		!subtract 1 from top_m

		st %l1, [%o5]			!store

		mov %value_r, %i0		!return value_r

popEnd:							!popEnd label

		ret 					!ret
		restore					!restore

		.global stackFull 		!global pseudo op
stackFull:						!stackFull label
	
		save %sp, -92 & -8, %sp !save instruction

		set top_m, %o1			!set %o1 to top_m
		ld [%o1], %l1			!load into %l1

		cmp %l1, (STACKSIZE -1)	!compare with STACKSIZE - 1
		bne stackFullElse		!branch not equal to stackFullElse
		nop						!nop

		mov TRUE, %i0			!return TRUE
		ba stackFullEnd			!branch always to stackFullEnd
		nop						!nop

stackFullElse:					!stackFullElse label

		mov FALSE, %i0			!return FALSE

stackFullEnd:					!stackFullEnd label

		ret 					!ret
		restore					!restore

		.global stackEmpty 		!global pseudo op
stackEmpty:						!stackEmpty label

		save %sp, -92 & -8, %sp !save instruction

		set top_m, %o1			!set %o1 to top_m
		ld [%o1], %l1			!load into %l1

		cmp %l1, -1				!compare with -1
		bne stackEmptyElse	 	!branch not equal to stackEmptyElse
		nop						!nop

		mov TRUE, %i0			!return TRUE
		ba stackEmptyEnd		!branch always to stackEmptyEnd
		nop						!nop

stackEmptyElse:					!stackEmptyElse label	

		mov FALSE, %i0			!return FALSE

stackEmptyEnd:					!stackEmptyEnd label

		ret 					!ret
		restore					!restore

define(i_r, l0)					!define i_r

fmt:	.asciz	"\nEmpty stack\n"				!asciz
fmt2:	.asciz	"\nCurrent stack contents:\n"	!asciz
fmt3:	.asciz	"  %d"							!asciz
fmt4:	.asciz	" <-- top of stack"				!asciz
fmt5:	.asciz	"\n"							!asciz
	
		.align 4				!align
		.global display 		!global pseudo op
display:						!display label
	
		save %sp, -92 & -8, %sp !save instruction

		call stackEmpty 		!call stackEmpty
		nop						!nop	

		mov	%o0, %g1			!%o0 to %g1
		cmp	%g1, 1				!compare with 1
		bne	displayElse			!branch not equal to displayElse
		nop						!nop

		set fmt, %o0			!set fmt to print that the stack is empty
		call printf 			!print
	 	nop						!nop

	 	ba displayEndFor		!branch always displayEndFor
	 	nop						!nop

displayElse:					!displayElse label

		set fmt2, %o0			!set fmt2 to proclaim display of current stack contents
		call printf 			!print
		nop						!nop

		set top_m, %o1			!%o1 to top_m
		ld [%o1], %i_r			!load value to i_r

displayFor:						!displayFor label

		cmp %i_r, 0				!compare with 0
		bl displayEndFor		!branch less than to displayEndFor
		nop						!nop

		set fmt3, %o0			!set fmt3 to print value

		sethi	%hi(stack), %g1	!sethi of stack
		or %g1, %lo(stack), %o2	!or with lo of stack
		
		sll %i_r, 2, %o3		!shift left logical
		ld	[%o2+%o3], %o1		!load 

		call printf 			!print
		nop						!nop

		set top_m, %o1			!set %o1 to top_m
		ld [%o1], %o1 			!load

		cmp %i_r, %o1			!compare i_r with top_m
		bne displayIf			!branch not equal to displayIf
		nop						!nop

		set fmt4, %o0			!set fmt4 to print top of stack
		call printf 			!print
		nop						!nop

displayIf:						!displayIf
		
		set fmt5, %o0			!set fmt5 for new line
		call printf 			!printf
		nop						!nop

		add -1, %i_r, %i_r		!subtract 1 from %i_r

		ba displayFor 			!branch always to displayFor
		nop						!nop

displayEndFor:					!displayEndFor label

		ret 					!ret
		restore					!restore







