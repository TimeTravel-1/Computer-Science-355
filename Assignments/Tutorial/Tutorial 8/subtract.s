	.align 4
	.global subtract
subtract:
	save %sp, (-92-8) & -8, %sp	!make room for temp double.
	!Need to take from %i registers to RAM, then to f registers .

	std %i0, [%fp - 8]	!move i0/i1 into f2/f3
	ldd [%fp - 8], %f2

	std %i2, [%fp - 8]	!move i2/i3 to f4/f5
	ldd [%fp - 8], %f4

	fsubd %f2, %f4, %f0	!arg1 - arg2
	
	ret
	restore
