	.file	"main.c"
	.section	".rodata"
	.align 8
.LLC2:
	.asciz	"result is %f\n"
	.align 8
.LLC0:
	.long	1075183616
	.long	0
	.align 8
.LLC1:
	.long	1072955392
	.long	0
	.section	".text"
	.align 4
	.global main
	.type	main, #function
	.proc	04
main:
	!#PROLOGUE# 0
	save	%sp, -120, %sp
	!#PROLOGUE# 1
	sethi	%hi(.LLC0), %g1
	or	%g1, %lo(.LLC0), %g1
	ld	[%g1], %f10
	ld	[%g1+4], %f11
	sethi	%hi(.LLC1), %g1
	or	%g1, %lo(.LLC1), %g1
	ld	[%g1], %f8
	ld	[%g1+4], %f9
	std	%f10, [%fp-16]
	ldd	[%fp-16], %o0
	std	%f8, [%fp-16]
	ldd	[%fp-16], %o2
	call	subtract, 0
	 nop
	fmovs	%f0, %f8
	fmovs	%f1, %f9
	std	%f8, [%fp-24]
	sethi	%hi(.LLC2), %g1
	or	%g1, %lo(.LLC2), %o0
	ld	[%fp-24], %o1
	ld	[%fp-20], %o2
	call	printf, 0
	 nop
	mov	0, %g1
	mov	%g1, %i0
	ret
	restore