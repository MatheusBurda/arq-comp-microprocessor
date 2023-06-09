        ldi r1, 1
        ldi r2, 1
        ldi r3, 32
loop:   st r2, r2
        add r2, r1
        cp r3, r2
        brne loop # -3
        
        add r3,r1
        ldi r2, 1

        cp r2, r3
        breq print

next:   add r2,r1
        ld r5,(r2)
        cp r5, r0
        breq next
        mov r6, r2
        add r6, r6

loop2:  cp r6, r3
        brge next
        st (r6), r0
        add r6, r1
        jmp loop2

        ldi r2, 1
        ldi r3, 32

print:  cp r3, r2
        breq end

        add r2, r1
        ld r4, (r3)
        cp r4, r0
        breq print
        mov r7, r4
        jmp print
end:    nop