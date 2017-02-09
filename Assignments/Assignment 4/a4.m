!Assignment 4
!David Ng
!30009245

define(FALSE, 0)									!False macro
define(TRUE, 1)										!True macro

include(macro_defs.m)								!macro defs						

begin_struct(point)									!point structure
field(x,4)											!x
field(y,4)											!y
end_struct(point)									!end of structure
						
begin_struct(dimension)								!dimension structure
field(width, 4)										!width
field(height, 4)									!height
end_struct(dimension)								!end of structure
										
begin_struct(box)									!box structure
field(origin, align_of_point, size_of_point)		!origin
field(size, align_of_dimension, size_of_dimension)	!size
field(area, 4)										!area							
end_struct(box)										!end of structure
									
local_var											!local variables
var(b, align_of_box, size_of_box)					!box b

fmt:												!fmt label

	.asciz "Initial box values:\n"					!asciz

fmt1:												!fmt1 label	

	.asciz "Box %s origin = (%d, %d)  width = %d  height = %d  area = %d\n"	!asciz

fmt2:												!fmt2 label

	.asciz "first"									!asciz

fmt4:												!fmt4 label

	.asciz "second"									!asciz

fmt6:												!fmt6 label

	.asciz "\nChanged box values:\n"				!asciz
	.align 4										!align

	.global	newBox									!global newBox
newBox:												!newBox label

	save %sp, (-92 + last_sym) & -8, %sp 			!save instruction

	ld [%i7 + 8], %o1								!load
	cmp %o1, size_of_box							!compare 
	bne return										!branch not equal to
	st %g0, [%fp + b + box_origin + point_x]		!store box x

	st %g0, [%fp + b + box_origin + point_y]		!store box y

	mov 1, %o0										!move 1 to %o0
	st %o0, [%fp + b + box_size + dimension_width]	!store box width

	mov 1, %o0										!move 1 to %o0
	st %o0, [%fp + b + box_size + dimension_height]	!store box height
	
	ld [%fp + b + box_size + dimension_width], %o0	!load width
	
	call .mul										!multiply
	ld [%fp + b + box_size + dimension_height], %o1	!load height

	st %o0, [%fp + b + box_area]					!store area

	ld [%fp + struct_s], %o0						!load 

	ld [%fp + b + box_origin + point_x], %l0		!load x
	st %l0, [%o0 + box_origin + point_x]			!store

	ld [%fp + b + box_origin + point_y], %l0		!load y
	st %l0, [%o0 + box_origin + point_y]			!store

	ld [%fp + b + box_size + dimension_width], %l0	!load width
	st %l0, [%o0 + box_size + dimension_width]		!store

	ld [%fp + b + box_size + dimension_height], %l0	!load height
	st %l0, [%o0 + box_size + dimension_height]		!store

	ld [%fp + b + box_area], %l0					!load area
	st %l0, [%o0 + box_area]						!store

return:												!return label

	jmpl %i7 + 12, %g0								!%i7 + 8 not work, so do not use ret
	restore											!restore

	.global move									!global move
move:												!move label

	save %sp, -92 & -8, %sp 						!save instruction
		
	ld [%i0 + box_origin + point_x], %i5			!load x
	add %i5, %i1, %i4								!add by deltaX
	st %i4, [%i0 + box_origin + point_x]			!store

	ld [%i0 + box_origin + point_y], %i5			!load y
	add %i5, %i2, %i4								!add by deltaY
	st %i4, [%i0 + box_origin + point_y]			!store

	ret 											!ret
	restore 										!restore

	.global expand									!global expand
expand:												!expand label

	save %sp, -92 & -8, %sp 						!save instruction

	ld [%i0 + box_size + dimension_width], %o0		!load width
	
	call .mul 										!multiply
	mov %i1, %o1									!move factor

	st %o0, [%i0 + box_size + dimension_width]		!store
	mov %o0, %l0									!move result to %l0

	ld [%i0 + box_size + dimension_height], %o0		!load height
	
	call .mul 										!mutiply
	mov %i1, %o1									!move factor

	st %o0, [%i0 + box_size + dimension_height]		!store 

	call .mul 										!multiply
	mov %l0, %o1									!with %l0

	st %o0, [%i0 + box_area]						!store area

	ret 											!ret
	restore											!restore

	.global printBox								!global printBox
printBox:											!printBox label

	save %sp, (-92 + -4) & -8, %sp					!save instruction

	ld [%fp + struct_s], %l0						!load 

	set	fmt1, %o0									!set fmt1
	mov	%i0, %o1									!move %i0
	ld [%l0 + box_origin + point_x], %o2			!load x
	ld [%l0 + box_origin + point_y], %o3			!load y
	ld [%l0 + box_size + dimension_width], %o4		!load width
	ld [%l0 + box_size + dimension_height], %o5		!load height
	
	ld [%l0 + box_area], %i5						!load area
	
	call printf 									!print
	st %i5, [%sp + arg_d(7)]						!store

	ret												!ret
	restore											!restore
	
	.global equal									!global equal
equal:												!equal label

	save %sp, -92 & -8, %sp 						!save instruction

	mov %i0, %l0									!move %i0 to %l0

	ld [%l0 + box_origin + point_x], %l1			!x of box 1
	ld [%i1 + box_origin + point_x], %l2			!x of box 2

	cmp %l1,%l2										!compare
	bne result										!branch not equal to
	mov FALSE, %i0									!set to False

	ld [%l0 + box_origin + point_y], %l1			!y of b1
	
	cmp %l1, %l2									!compare
	bne result										!branch not equal to
	ld [%i1 + box_origin + point_y], %l2			!y of b2

	ld [%l0 + box_size + dimension_width], %l1		!width of b1

	cmp %l1, %l2									!compare
	bne result										!branch not equal to
	ld [%i1 + box_size + dimension_width], %l2		!width of b2

	ld [%l0 + box_size + dimension_height], %l1		!height of b1

	cmp %l1, %l2									!compare
	bne result										!branch not equal to
	ld [%i1 + box_size + dimension_height], %l2		!height of b2

	mov TRUE, %i0									!set to True

result:												!result label

	ret 											!ret
	restore											!restore

local_var											!local variables
var(first, align_of_box, size_of_box)				!first
var(second, align_of_box, size_of_box)				!second

	.global main 									!global pseudo op
main:												!main label

	save %sp, (-92 + last_sym), %sp					!save instruction
	
	add	%fp, first, %o0								!add %fp with first

	call newBox										!call newBox
	st %o0, [%sp + struct_s]						!store %o0
	.word size_of_box								!word directive

	add	%fp, second, %o0							!add %fp with second

	call newBox										!call newBox
	st %o0, [%sp + struct_s]						!store %o0
	.word size_of_box								!word directive

	set	fmt, %o0									!set fmt
	call printf										!print
	add	%fp, first, %l0								!add %fp with first

	set	fmt2, %o0									!set fmt2
	mov %l0, %o1									!move %l0 to %o1

	call printBox									!call printBox
	st %l0, [%sp + struct_s]						!store %l0
	
	add	%fp, second, %l1							!add %fp to second
	set	fmt4, %o0									!set fmt4
	mov %l1, %o1									!move %l1 to %o1
	
	call printBox									!call printBox
	st %l1, [%sp + struct_s]						!store %l1

	mov %l0, %o0									!move %l0 to %o0
	
	call equal										!call equal
	mov %l1, %o1									!mov %l1 to %o1

	cmp %o0, 0										!compare %o0 with 0
	bne resume										!branch not equal to 
	mov %l0, %o0									!move %l0 to %o0
							
	mov	-5, %o1										!move -5 to %o1
								
	call move										!call move
	mov	7, %o2										!move 7 to %o2
	
	mov %l1, %o0									!move %l1 to %o0
						
	call expand										!call expand
	mov	3, %o1										!move 3 to %o1

resume:												!resume label

	set	fmt6, %o0									!set fmt6
	call printf										!print
	add	%fp, first, %l0								!add %fp with first

	set	fmt2, %o0									!set fmt2
	mov %l0, %o1									!move %l0 to %o1

	call printBox									!call printBox
	st	%o1, [%sp + struct_s]						!store %o1 

	add %fp, second, %l1							!add %fp with second
	set	fmt4, %o0									!set fmt4
	mov %l1, %o1									!move %l1 to %o1
	
	call printBox									!call printBox
	st	%o1, [%sp + struct_s]						!store %o1
								
	mov	1, %g1										!exit request
	ta	0											!trap to system
			