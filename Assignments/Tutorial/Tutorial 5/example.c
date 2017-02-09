int example(int a, int b, char c)
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

}