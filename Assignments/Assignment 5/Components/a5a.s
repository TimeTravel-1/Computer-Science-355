 


									
		

		.section ".bss"
		.align 4
stack:	

		.skip 4 * 5

		.section ".data"
		.global top_m
top_m:	.word -1

		.section ".text"
fmt6:	.asciz	"\nStack overflow! Cannot push value onto stack.\n"

		.align 4
		.global push
push:
	
		save %sp, -92 & -8, %sp 

		call stackFull
		nop

		mov %o0, %g1
		cmp %g1, 1
		bne pushElse
		nop

		set fmt6, %o0
		call printf
		nop
		
		ba pushEnd
		nop

pushElse:

		sethi	%hi(stack), %g1
		or	%g1, %lo(stack), %o4
	
		sethi	%hi(top_m), %g1
		or	%g1, %lo(top_m), %o5
	
		sethi	%hi(top_m), %g1
		or	%g1, %lo(top_m), %g1
	
		ld	[%g1], %g1
		add	%g1, 1, %g1
	
		st	%g1, [%o5]
		sll	%g1, 2, %o5

		st	%i0, [%o4+%o5]
	
pushEnd:

		ret
		restore

fmt7:	.asciz	"\nStack underflow! Cannot pop an empty stack.\n"



		.align 4
		.global pop
pop:

		save %sp, -92 & -8, %sp 

		call stackEmpty
		nop

		mov %o0, %g1
		cmp %g1, 1
		bne popElse
		nop

		set fmt7, %o0
		call printf
		nop

		mov -1, %i0

		ba popEnd
		nop

popElse:

		sethi	%hi(stack), %g1
		or	%g1, %lo(stack), %o5

		set top_m, %o1
		ld [%o1], %l1

		sll %l1, 2, %o3
		
		ld [%o3 + %o5], %l0

		sethi	%hi(top_m), %g1
		or	%g1, %lo(top_m), %o5

		sethi	%hi(top_m), %g1
		or	%g1, %lo(top_m), %g1

		ld [%g1], %l1
		add %l1, -1, %l1

		st %l1, [%o5]

		mov %l0, %i0

popEnd:

		ret
		restore

		.global stackFull
stackFull:
	
		save %sp, -92 & -8, %sp 

		set top_m, %o1
		ld [%o1], %l1


		cmp %l1, (5 -1)
		bne stackFullElse
		nop

		mov 1, %i0
		ba stackFullEnd
		nop

stackFullElse:	

		mov 0, %i0

stackFullEnd:

		ret
		restore

		.global stackEmpty
stackEmpty:

		save %sp, -92 & -8, %sp 

		set top_m, %o1
		ld [%o1], %l1

		cmp %l1, -1
		bne stackEmptyElse
		nop

		mov 1, %i0
		ba stackEmptyEnd
		nop

stackEmptyElse:	

		mov 0, %i0

stackEmptyEnd:

		ret
		restore



fmt:	.asciz	"\nEmpty stack\n"
fmt2:	.asciz	"\nCurrent stack contents:\n"
fmt3:	.asciz	"  %d"
fmt4:	.asciz	" <-- top of stack"
fmt5:	.asciz	"\n"
	
		.align 4
		.global display
display:
	
		save %sp, -92 & -8, %sp

		call stackEmpty
		nop

		mov	%o0, %g1
		cmp	%g1, 1
		bne	displayElse
		nop

		set fmt, %o0
		call	printf
	 	nop

	 	ba displayEndFor
	 	nop

displayElse:

		set fmt2, %o0
		call printf
		nop

		set top_m, %o1
		ld [%o1], %l0

displayFor:

		cmp %l0, 0
		bl displayEndFor
		nop

		set fmt3, %o0

		sethi	%hi(stack), %g1
		or	%g1, %lo(stack), %o2
		
		sll %l0, 2, %o3
		ld	[%o2+%o3], %o1

		call printf
		nop

		set top_m, %o1
		ld [%o1], %o1

		cmp %l0, %o1
		bne displayIf
		nop

		set fmt4, %o0
		call printf
		nop

displayIf:
		
		set fmt5, %o0
		call printf
		nop

		add -1, %l0, %l0

		ba displayFor
		nop

displayEndFor:

		ret
		restore







