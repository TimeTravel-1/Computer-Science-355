/*this program implements the following c code:

	int a, b;
	char c1;
	int c, d;	
	//these go on the stack

	register int x, y, z;
	
	x = 17;
	y = -5;

	for(z = 1; z < x + y; z++) {
		for(a = z; a >= z * y; a -= 10)
		{
			d = a + z;
			c1 = d *b;
			c = a + y / z;
		}
	}
*/


	define(local_var, `define(last_sym, 0)')
	define(var, `define(`last_sym',
		eval(last_sym - $2))$1 = last_sym')

	define(begin_main, `.global main
		.align 4
	main:	save %sp, eval((-92 last_sym) & -8), %sp')

	define(end_main, `mov 1, %g1
		ta 0')

	local_var
	var(a_s, 4)
	var(b_s, 4)
	var(c1_s, 4)
	var(c_s, 4)
	var(d_s, 4)

	define(x_r, 10)					!x_r 10
	define(y_r, 11)					!y_r 11
	define(z_r, 12)					!z_r 12

	begin_main

	mov 17, %x_r					!x = 17
	mov -5, %y_r					!y = -5

	b outer_test					!branch to outer loop test
	mov 1, %z_r					!use delay slot for init statement

outer:
	b inner_test					!similarly for inner loop
	st %z_r, [%fp + a_s]				!a = z
	
inner:
	ld [%fp + a_s], %o0
	add %o0, %z_r, %o0
	st %o0, [%fp + d_s]
	
	ld [%fp + d_s], %o0
	call .mul
	ld [%fp + b_s], %o1
	stb %o0, [%fp + c1_s]

	mov %y_r, %o0
	call .div
	mov %z_r, %o1
	ld [%fp + a_s], %o1
	add %o0, %o1, %o0
	st %o0, [%fp + c_s]

inner_inc:						!inner for increment statement
	ld [%fp + a_s], %o0
	sub %o0, 10, %o0
	st %o0, [%fp + a_s]
	
inner_test:
	mov %z_r, %o0
	call .mul
	mov %y_r, %o1
	ld [%fp + a_s], %o1
	cmp %o1, %o0
	bge inner
	nop

outer_inc:						!outer for increment statement
	add %z_r, 1, %z_r

outer_test:						!outer for test
	add %x_r, %y_r, %o0
	cmp %z_r, %o0
	bl outer
	nop

	end_main


