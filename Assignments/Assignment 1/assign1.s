!Assignment 1
!David Ng
!30009245

fmt:                          !fmt label

      .asciz "The value of x is: %d\tThe value of y is: %d\tThe current minimum is: %d\n"  !asciz format

min:                          !min label
        
      .asciz "The minimum over the range is: %d\n"    !asciz format
      .align  4               !align
      .global main            !global pseudo op

main:                         !main label

      save %sp, -96, %sp      !save instruction
      mov -2, %l0             !x = -2
      mov 4095, %l2           !set x to arbitrary large number
            
test:                         !test label

      cmp %l0, 11             !compare x to step through range from -2 to 11
      bg done                 !branch greater than to done
      nop                     !nop
      
      mov %l0, %o0            !x to %o0 register
      mov 10, %o1             !10 to %o1 register
      call .mul               ! multiply to get 10x
      nop                     !nop

      add 39, %o0, %l1        !y = 10x + 39
      
      mov %l0, %o0            !x to %o0 register
      mov %l0, %o1            !x to %o1 register
      call .mul               !x^2
      nop                     !nop

      mov %o0, %l3            !x^2
      
      mov -18, %o1            !-18 to %o1 register
      call .mul               !-18x^2
      nop                     !nop

      add %l1, %o0, %l1       !y = -18x^2+10x+39
        
      mov %l0, %o0            !x to %o0 register
      mov %l3, %o1            !x^2 to %o1 register
      call .mul               !x^3
      nop                     !nops
    
      mov 2, %o1              !2 to %o1 register
      call .mul               !2x^3
      nop                     !nop

      add %l1, %o0, %l1       !y = 2x^3-18x^2+10x+39

      cmp %l1, %l2            !compare y with current minimum
      bge printdata           !branch greater than or equal
      nop                     !nop

      mov %l1, %l2            !change value of minimum to value of y

printdata:                    !printdata label
                  
      set fmt, %o0            !set to display to screen
      mov %l0, %o1            !retrieve x value
      mov %l1, %o2            !retrieve y value
      mov %l2, %o3            !retrieve current minimum
      call printf             !print out values
      nop                     !nop

      inc %l0                 !increase x by 1
      ba test                 !branch always to test
      nop                     !nop  

done:                         !done label
            
      mov %l2, %l0            !move minimum value to register %l0 according to instructions of assignment
      set min, %o0            !set to display to screen
      mov %l2, %o1            !move minimum to %o1 register
      call printf             !print out values
      nop                     !nop

      mov  1, %g1             !exit request
      ta   0                  !trap to system

