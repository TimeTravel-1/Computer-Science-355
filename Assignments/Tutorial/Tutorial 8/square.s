/*
 This code finds the square root of 21.33
*/

	.section ".data"
	.align 8
x_m:	.double 0r21.33
y_m:	.double 0r0.0

	.section ".text"
	.align 4
	.global main
main:	save %sp, -96, %sp

	set x_m, %l0			!get a pointer to x
	ldd [%l0], %f0			!load x into %f0 and %f1

	fsqrtd %f0, %f2			!sqrt(x)
	set y_m, %l1			!get a pointer to y
	std %f2, [%l1]			!store result into y

	ret
	restore



