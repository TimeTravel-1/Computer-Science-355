!Assignment 1
!David Ng
!30009245

define(x_r, l0)               !define x_r to be l0
define(y_r, l1)               !define y_r to be l1
define(min_r, l2)             !define min_r to be l2

fmt:                          !fmt label
      .asciz "The value of x is: %d\tThe value of y is: %d\tThe current minimum is: %d\n"   !asciz format

min:                          !min label
        
      .asciz "The minimum over the range is: %d\n"    !asciz format
      .align  4               !align
      .global main            !global pseudo op

main:                         !main label

      save %sp, -96, %sp      !save instruction
      mov -2, %x_r            !move -2 to x_r
      mov 4095, %min_r        !set min_r to arbitrary large value
            
test:                         !test label

      cmp %x_r, 11            !compare x to decide when to exit loop
      bg,a done               !branch greater than to done, use annulled branch to optimize
      mov %min_r, %x_r        !first instruction from done brought here, move minimum value to register %l0 according to instructions of assignment
      
      mov %x_r, %o0           !move x into %o0 register
                              !below
      call .mul               !multiply
      mov 10, %o1             !moved from above for optimization to get 10x

      add 39, %o0, %y_r       !y = 10x + 39
      
      mov %x_r, %o0           !move x to %o0 register
                              !below
      call .mul               !multiply
      mov %x_r, %o1           !moved from above for optimization to get x^2
      
      mov %o0, %l3            !store x^2 in %l3 register           
                              !below
      call .mul               !multiply
      mov -18, %o1            !moved from above for optimization to get -18x^2

      add %y_r, %o0, %y_r     !y = -18x^2+10x+39
        
      mov %l3, %o0            !move x^2 to %o0 register
                              !below
      call .mul               !multiply
      mov %x_r, %o1           !moved from above for optimization to get x^3
    
                              !below
      call .mul               !multiply
      mov 2, %o1              !moved from above for optimization to get 2x^3

      add %y_r, %o0, %y_r     !y = 2x^3-18x^2+10x+39

      cmp %y_r, %min_r        !compare y with current minimum
      bge,a printdata         !branch greater than or equal, annulled branch for optimization
      mov %x_r, %o1           !moves x to %o1 register

      mov %y_r, %min_r        !sets the value of current minimum to value of y
      mov %x_r, %o1           !ensures that x is moved to %o1 register
      
printdata:                    !printdata label
      
      set fmt, %o0            !set to display to screen
      mov %y_r, %o2           !move y to %o2 register
                              !below                  
      call printf             !print out values
      mov %min_r, %o3         !moved from above for optimization, move minimum value to %o3 register
      
      ba test                 !branch always to test
      inc %x_r                !increment x by 1

done:                         !done label

      set min, %o0            !set to display to screen
                              !below
      call printf             !print out value
      mov %min_r, %o1         !moved from above for optimization, moves minimum to %o1 register

      mov  1, %g1             !exit request
      ta   0                  !trap to system

