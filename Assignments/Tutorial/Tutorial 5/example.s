cube:	save %sp, -92 & -8, %sp
		smul %i0, %i0, %l0
		smul %i0, %l0, %i0

		ret
		restore

example:

	(int a, int b, char c)
{


	int x, y;
	short ary [128];

	register int i, j;

	x = a + b;
	i = c + 64;
	ary[i] = c + a;
	y = x * a;
	j = x + 1;

	return x + y;

	save %sp, -92 & -8, %sp

	add %i0, %i1, %l2
	st %l1, [%fp - 4]

	add %i2, 64, %l0
	add %i2, %i0, %o4

	sll %l0, 2, %o3
	add %fp, %o3, %o3
	st %o4, [%o3 - 136]

	ld [%fp - 4], %l4
	mov %l4, %o0
	mov %i0, %o1
	call .mul
	nop

	st %o0, [%fp - 8]

	add %l4, 1, %l1







}