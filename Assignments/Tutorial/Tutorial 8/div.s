/*
	This program divides 2 numbers and checks if the result is correct
*/

.section ".data"
        .align 8
x_m:    .double 0r10.00
y_m:    .double 0r2.00
z_m:    .double 0r0.00
k_m:    .double 0r5.00

.section ".text"
        .align 4
.global main
main:
        save    %sp, -96, %sp

        set     x_m, %l0
        ldd     [%l0], %f0
        set     y_m, %l0
        ldd     [%l0], %f2
        fdivd   %f0, %f2, %f2

        set     k_m, %l0
        ldd     [%l0], %f4

        fcmpd   %f2, %f4
        nop
        fbe     correct
        nop
        fbne    end
        nop

correct:
        set     z_m, %o0
        std     %f4, [%o0]

end:
        mov     1, %g1
        ta      0