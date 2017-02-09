/*
#define PERMS 0666
#define BUFSIZ 8192

main()
{
	int ff ft;
	int n;
	char buf[BUFSIZ];

	if((ff = open("peck.txt", 0, 0)) < 0)
		exit(0);

	
}
*/

	include(macro_defs.m)
	
	define(OPEN, 5)			!trap definitions
	define(CREAT, 8)
	define(READ, 3)
	define(WRITE, 4)

	define(O_RDONLY, 0)		! defined in <fcntl.h>

str1:	.asciz	"squid.txt"
str2:	.asciz	"peck.txt"

	.align 4

	define(ff_r, l0)
	define(ft_r, l1)
	define(n_r, l2)
	
	define(BUFSIZ, 16)

	local_var
	var(buf, BUFSIZ, 1)

	begin_fn(main)

	set str1, %o0
	clr %o1				!open file to read
	clr %o2				!mode
	mov OPEN, %g1			!open file for reading
	ta 0
	bcc open_ok
	mov %o0, %ff_r			!read file descriptor
	mov 1, %g1			!error, exit
	ta 0
open_ok:
	set str2, %o0
	mov 0666, %o1			!file access permissions
	mov CREAT, %g1			!create file
	ta 0
	bcc creat_ok
	mov %o0, %ft_r			!write file descriptor
	mov 1, %g1			!error, exit
	ta 0				
creat_ok:
	ba write_ok			!test write
	mov %ff_r, %o0			!read file desciptor
read_ok:
	add %fp, buf, %o1		!buff pointer
	mov %n_r, %o2			!number of bytes to read
	mov WRITE, %g1			!write
	ta 0
	cmp %o0, %n_r			!check # of bytes written
	be write_ok
	mov %ff_r, %o0			!read file descriptor
	mov 1, %g1			!error, exit
	ta 0
write_ok:
	add %fp, buf, %o1		!pointer to buff
	mov BUFSIZ, %o2			!max chars to read
	mov READ, %g1			!read
	ta 0
	addcc %o0, 0, %n_r		!check if any chars read
	bg read_ok
	mov %ft_r, %o0			!read file descriptor
	
	be all_done
	mov 1, %g1			!error, exit
	ta 0
all_done:
	end_fn(main)
