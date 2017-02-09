	.file	"test.c"
	.global top
	.section	".data"
	.align 4
	.type	top, #object
	.size	top, 4
top:
	.long	-1
	.section	".rodata"
	.align 8
.LLC0:
	.asciz	"clear"
	.align 8
.LLC1:
	.asciz	"### Stack Operations ###\n\n"
	.align 8
.LLC2:
	.asciz	"Press 1 - Push, 2 - Pop, 3 - Display, 4 - Exit\n"
	.align 8
.LLC3:
	.asciz	"Your option? "
	.align 8
.LLC4:
	.asciz	"%d"
	.align 8
.LLC5:
	.asciz	"\nEnter the positive integer value to be pushed: "
	.align 8
.LLC6:
	.asciz	"\nPopped value is %d\n"
	.align 8
.LLC7:
	.asciz	"\nTerminating program\n"
	.align 8
.LLC8:
	.asciz	"\nInvalid option! Try again.\n"
	.align 8
.LLC9:
	.asciz	"\nPress the return key to continue . . . "
	.section	".text"
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
	!#PROLOGUE# 0
	save	%sp, -128, %sp
	!#PROLOGUE# 1
.LL2:
	sethi	%hi(.LLC0), %g1
	or	%g1, %lo(.LLC0), %o0
	call	system, 0
	 nop
	sethi	%hi(.LLC1), %g1
	or	%g1, %lo(.LLC1), %o0
	call	printf, 0
	 nop
	sethi	%hi(.LLC2), %g1
	or	%g1, %lo(.LLC2), %o0
	call	printf, 0
	 nop
	sethi	%hi(.LLC3), %g1
	or	%g1, %lo(.LLC3), %o0
	call	printf, 0
	 nop
	add	%fp, -20, %o5
	sethi	%hi(.LLC4), %g1
	or	%g1, %lo(.LLC4), %o0
	mov	%o5, %o1
	call	scanf, 0
	 nop
	ld	[%fp-20], %g1
	st	%g1, [%fp-28]
	ld	[%fp-28], %g1
	cmp	%g1, 2
	be	.LL7
	nop
	ld	[%fp-28], %g1
	cmp	%g1, 2
	bg	.LL12
	nop
	ld	[%fp-28], %g1
	cmp	%g1, 1
	be	.LL6
	nop
	b	.LL11
	 nop
.LL12:
	ld	[%fp-28], %g1
	cmp	%g1, 3
	be	.LL9
	nop
	ld	[%fp-28], %g1
	cmp	%g1, 4
	be	.LL10
	nop
	b	.LL11
	 nop
.LL6:
	sethi	%hi(.LLC5), %g1
	or	%g1, %lo(.LLC5), %o0
	call	printf, 0
	 nop
	add	%fp, -24, %o5
	sethi	%hi(.LLC4), %g1
	or	%g1, %lo(.LLC4), %o0
	mov	%o5, %o1
	call	scanf, 0
	 nop
	ld	[%fp-24], %o0
	call	push, 0
	 nop
	b	.LL5
	 nop
.LL7:
	call	pop, 0
	 nop
	mov	%o0, %g1
	st	%g1, [%fp-24]
	ld	[%fp-24], %g1
	cmp	%g1, -1
	be	.LL5
	nop
	sethi	%hi(.LLC6), %g1
	or	%g1, %lo(.LLC6), %o0
	ld	[%fp-24], %o1
	call	printf, 0
	 nop
	b	.LL5
	 nop
.LL9:
	call	display, 0
	 nop
	b	.LL5
	 nop
.LL10:
	sethi	%hi(.LLC7), %g1
	or	%g1, %lo(.LLC7), %o0
	call	printf, 0
	 nop
	mov	0, %o0
	call	exit, 0
	 nop
.LL11:
	sethi	%hi(.LLC8), %g1
	or	%g1, %lo(.LLC8), %o0
	call	printf, 0
	 nop
.LL5:
	sethi	%hi(.LLC9), %g1
	or	%g1, %lo(.LLC9), %o0
	call	printf, 0
	 nop
	sethi	%hi(__iob), %g1
	or	%g1, %lo(__iob), %o5
	sethi	%hi(__iob), %g1
	or	%g1, %lo(__iob), %g1
	ld	[%g1], %g1
	add	%g1, -1, %g1
	st	%g1, [%o5]
	cmp	%g1, 0
	bge	.LL13
	nop
	sethi	%hi(__iob), %g1
	or	%g1, %lo(__iob), %o0
	call	__filbuf, 0
	 nop
	b	.LL14
	 nop
.LL13:
	sethi	%hi(__iob), %g1
	or	%g1, %lo(__iob), %o5
	sethi	%hi(__iob), %g1
	or	%g1, %lo(__iob), %g1
	ld	[%g1+4], %g1
	add	%g1, 1, %g1
	st	%g1, [%o5+4]
.LL14:
	sethi	%hi(__iob), %g1
	or	%g1, %lo(__iob), %o5
	sethi	%hi(__iob), %g1
	or	%g1, %lo(__iob), %g1
	ld	[%g1], %g1
	add	%g1, -1, %g1
	st	%g1, [%o5]
	cmp	%g1, 0
	bge	.LL15
	nop
	sethi	%hi(__iob), %g1
	or	%g1, %lo(__iob), %o0
	call	__filbuf, 0
	 nop
	b	.LL4
	 nop
.LL15:
	sethi	%hi(__iob), %g1
	or	%g1, %lo(__iob), %o5
	sethi	%hi(__iob), %g1
	or	%g1, %lo(__iob), %g1
	ld	[%g1+4], %g1
	add	%g1, 1, %g1
	st	%g1, [%o5+4]
.LL4:
	ld	[%fp-20], %g1
	cmp	%g1, 4
	be	.LL3
	nop
	b	.LL2
	 nop
.LL3:
	mov	0, %g1
	mov	%g1, %i0
	ret
	restore
	.size	main, .-main
	.section	".rodata"
	.align 8
.LLC10:
	.asciz	"\nStack overflow! Cannot push value onto stack.\n"
	.section	".text"
	.align 4
	.global push
	.type	push, #function
	.proc	020
push:
	!#PROLOGUE# 0
	save	%sp, -112, %sp
	!#PROLOGUE# 1
	st	%i0, [%fp+68]
	call	stackFull, 0
	 nop
	mov	%o0, %g1
	cmp	%g1, 0
	be	.LL18
	nop
	sethi	%hi(.LLC10), %g1
	or	%g1, %lo(.LLC10), %o0
	call	printf, 0
	 nop
	b	.LL17
	 nop
.LL18:
	sethi	%hi(stack), %g1
	or	%g1, %lo(stack), %o4
	sethi	%hi(top), %g1
	or	%g1, %lo(top), %o5
	sethi	%hi(top), %g1
	or	%g1, %lo(top), %g1
	ld	[%g1], %g1
	add	%g1, 1, %g1
	st	%g1, [%o5]
	sll	%g1, 2, %o5
	ld	[%fp+68], %g1
	st	%g1, [%o4+%o5]
.LL17:
	ret
	restore
	.size	push, .-push
	.section	".rodata"
	.align 8
.LLC11:
	.asciz	"\nStack underflow! Cannot pop an empty stack.\n"
	.section	".text"
	.align 4
	.global pop
	.type	pop, #function
	.proc	04
pop:
	!#PROLOGUE# 0
	save	%sp, -120, %sp
	!#PROLOGUE# 1
	call	stackEmpty, 0
	 nop
	mov	%o0, %g1
	cmp	%g1, 0
	be	.LL21
	nop
	sethi	%hi(.LLC11), %g1
	or	%g1, %lo(.LLC11), %o0
	call	printf, 0
	 nop
	mov	-1, %g1
	st	%g1, [%fp-20]
	b	.LL20
	 nop
.LL21:
	sethi	%hi(stack), %g1
	or	%g1, %lo(stack), %o5
	sethi	%hi(top), %g1
	or	%g1, %lo(top), %g1
	ld	[%g1], %g1
	sll	%g1, 2, %g1
	ld	[%o5+%g1], %o4
	sethi	%hi(top), %g1
	or	%g1, %lo(top), %o5
	sethi	%hi(top), %g1
	or	%g1, %lo(top), %g1
	ld	[%g1], %g1
	add	%g1, -1, %g1
	st	%g1, [%o5]
	st	%o4, [%fp-20]
.LL20:
	ld	[%fp-20], %i0
	ret
	restore
	.size	pop, .-pop
	.align 4
	.global stackFull
	.type	stackFull, #function
	.proc	04
stackFull:
	!#PROLOGUE# 0
	save	%sp, -120, %sp
	!#PROLOGUE# 1
	sethi	%hi(top), %g1
	or	%g1, %lo(top), %g1
	ld	[%g1], %g1
	cmp	%g1, 4
	bne	.LL24
	nop
	mov	1, %g1
	st	%g1, [%fp-20]
	b	.LL23
	 nop
.LL24:
	st	%g0, [%fp-20]
.LL23:
	ld	[%fp-20], %i0
	ret
	restore
	.size	stackFull, .-stackFull
	.align 4
	.global stackEmpty
	.type	stackEmpty, #function
	.proc	04
stackEmpty:
	!#PROLOGUE# 0
	save	%sp, -120, %sp
	!#PROLOGUE# 1
	sethi	%hi(top), %g1
	or	%g1, %lo(top), %g1
	ld	[%g1], %g1
	cmp	%g1, -1
	bne	.LL27
	nop
	mov	1, %g1
	st	%g1, [%fp-20]
	b	.LL26
	 nop
.LL27:
	st	%g0, [%fp-20]
.LL26:
	ld	[%fp-20], %i0
	ret
	restore
	.size	stackEmpty, .-stackEmpty
	.section	".rodata"
	.align 8
.LLC12:
	.asciz	"\nEmpty stack\n"
	.align 8
.LLC13:
	.asciz	"\nCurrent stack contents:\n"
	.align 8
.LLC14:
	.asciz	"  %d"
	.align 8
.LLC15:
	.asciz	" <-- top of stack"
	.align 8
.LLC16:
	.asciz	"\n"
	.section	".text"
	.align 4
	.global display
	.type	display, #function
	.proc	020
display:
	!#PROLOGUE# 0
	save	%sp, -120, %sp
	!#PROLOGUE# 1
	call	stackEmpty, 0
	 nop
	mov	%o0, %g1
	cmp	%g1, 0
	be	.LL30
	nop
	sethi	%hi(.LLC12), %g1
	or	%g1, %lo(.LLC12), %o0
	call	printf, 0
	 nop
	b	.LL29
	 nop
.LL30:
	sethi	%hi(.LLC13), %g1
	or	%g1, %lo(.LLC13), %o0
	call	printf, 0
	 nop
	sethi	%hi(top), %g1
	or	%g1, %lo(top), %g1
	ld	[%g1], %g1
	st	%g1, [%fp-20]
.LL32:
	ld	[%fp-20], %g1
	cmp	%g1, 0
	bl	.LL29
	nop
	sethi	%hi(stack), %g1
	or	%g1, %lo(stack), %o4
	ld	[%fp-20], %g1
	sll	%g1, 2, %o5
	sethi	%hi(.LLC14), %g1
	or	%g1, %lo(.LLC14), %o0
	ld	[%o4+%o5], %o1
	call	printf, 0
	 nop
	sethi	%hi(top), %g1
	or	%g1, %lo(top), %g1
	ld	[%g1], %g1
	ld	[%fp-20], %o5
	cmp	%o5, %g1
	bne	.LL35
	nop
	sethi	%hi(.LLC15), %g1
	or	%g1, %lo(.LLC15), %o0
	call	printf, 0
	 nop
.LL35:
	sethi	%hi(.LLC16), %g1
	or	%g1, %lo(.LLC16), %o0
	call	printf, 0
	 nop
	ld	[%fp-20], %g1
	add	%g1, -1, %g1
	st	%g1, [%fp-20]
	b	.LL32
	 nop
.LL29:
	ret
	restore
	.size	display, .-display
	.common	stack,20,4
	.ident	"GCC: (GNU) 3.4.3 (csl-sol210-3_4-branch+sol_rpath)"
