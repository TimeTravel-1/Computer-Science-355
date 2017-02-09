include(macro_defs.m)

local_var
var(x_s, 4)
var(y_s, 4)

begin_fn(main)

	mov 5, %l0
	mov 7, %l1

	st %l0, [%fp + 4]
	st %l1, [%fp + 4]

	add %fp, 4, %o0
	add %fp, 4, %o1

	call swap
	nop

	ld[%fp + 4], %l0
	ld[%fp + 4], %l1

	ret
	restore

	mov 1, %g1
	ta 0

	.global swap
swap:

	ld [%o0], %o2
	ld [%o1], %o3

	st %o2, [%o1]
	st %o3, [%o0]
	
	retl
	nop