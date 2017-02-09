	.file	"array.c"
	.section	".rodata"
	.align 8
.LLC0:
	.asciz	"%d\n"
	.section	".text"
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
	!#PROLOGUE# 0
	save	%sp, -152, %sp
	!#PROLOGUE# 1
	mov	1, %g1
	st	%g1, [%fp-40]
	mov	45, %g1
	st	%g1, [%fp-36]
	mov	-16, %g1
	st	%g1, [%fp-32]
	mov	23, %g1
	st	%g1, [%fp-28]
	mov	48, %g1
	st	%g1, [%fp-24]
	mov	5, %g1
	st	%g1, [%fp-44]
	ld	[%fp-40], %g1
	st	%g1, [%fp-52]
	mov	1, %o5
	st	%o5, [%fp-48]
.LL2:
	ld	[%fp-44], %g1
	ld	[%fp-48], %o5
	cmp	%o5, %g1
	bge	.LL3
	nop
	ld	[%fp-48], %g1
	sll	%g1, 2, %o5
	add	%fp, -16, %g1
	add	%o5, %g1, %g1
	ld	[%g1-24], %g1
	ld	[%fp-52], %o5
	cmp	%g1, %o5
	ble	.LL4
	nop
	ld	[%fp-48], %g1
	sll	%g1, 2, %o5
	add	%fp, -16, %g1
	add	%o5, %g1, %g1
	ld	[%g1-24], %g1
	st	%g1, [%fp-52]
.LL4:
	ld	[%fp-48], %g1
	add	%g1, 1, %g1
	st	%g1, [%fp-48]
	b	.LL2
	 nop
.LL3:
	sethi	%hi(.LLC0), %g1
	or	%g1, %lo(.LLC0), %o0
	ld	[%fp-52], %o1
	call	printf, 0
	 nop
	mov	%g1, %i0
	ret
	restore
	.size	main, .-main
	.ident	"GCC: (GNU) 3.4.3 (csl-sol210-3_4-branch+sol_rpath)"
