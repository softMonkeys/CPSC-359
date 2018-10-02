.section .text

.global controller1
controller1:
push    {r0-r10,lr}
        //call Init_GPIO to initialize GPIO
        bl      Init_GPIO

        //r5 is the copy of r9 numberlist, which prevent the program keeping printing the same button
        mov     r10, #0
        mov     r5, #0
        ldr     r5, =0xffff

//the loop to get the pressed button(s) and print the corresponding message
Loop:
        ldr     r0, =0x0000C350
        bl      Wait    // To wait 0.05s in the starting of each loop to avoid running out of memory
        //call the Read_SNES to get the numberlist and store it in r9
        bl      Read_SNES
        cmp     r5, r0
        beq     next
        mov     r5, r0
        mov     r9, r0

//print out the corresponding button(s)
buttonB:
        mov     r7, r9
        and     r7, #1
        cmp     r7, #0
        bne     buttonY
        pop     {r0-r10,lr}
        b       marioJump



buttonY:
        mov     r7, r9
        lsr     r7, #1
        and     r7, #1
        cmp     r7, #0
        bne     buttonSelect
        b       next


buttonSelect:
        mov     r7, r9
        lsr     r7, #2
        and     r7, #1
        cmp     r7, #0
        bne     buttonStart
        b       next


buttonStart:
        mov     r7, r9
        lsr     r7, #3
        and     r7, #1
        cmp     r7, #0
        bne     buttonUp
        b       next


buttonUp:
        mov     r7, r9
        lsr     r7, #4
        and     r7, #1
        cmp     r7, #0
        bne     buttonDown
        push    {lr}
        //bl      clearIndicatorAtQuit
        //bl      drawIndicatorAtStart
        //mov     r10, #0
        pop     {lr}
        b       next

buttonDown:
        mov     r7, r9
        lsr     r7, #5
        and     r7, #1
        cmp     r7, #0
        bne     buttonLeft
        push    {lr}
        //bl      clearIndicatorAtStart
        //bl      drawIndicatorAtQuit
        //mov     r10, #1
        pop     {lr}
        b       next

buttonLeft:
        mov     r7, r9
        lsr     r7, #6
        and     r7, #1
        cmp     r7, #0
        bne     buttonRight
        pop     {r0-r10,lr}
        ldr     r0, =0x0000C350
        bl      Wait    // To wait 0.05s to avoid cheating
        b       marioWalkBackward


buttonRight:
        mov     r7, r9
        lsr     r7, #7
        and     r7, #1
        cmp     r7, #0
        bne     buttonA
        pop     {r0-r10,lr}
        ldr     r0, =0x0000C350
        bl      Wait    // To wait 0.05s to avoid cheating
        bl      marioWalkForward


buttonA:
        mov     r7, r9
        lsr     r7, #8
        and     r7, #1
        cmp     r7, #0
        bne     buttonX
        b       next

buttonX:
        mov     r7, r9
        lsr     r7, #9
        and     r7, #1
        cmp     r7, #0
        bne     buttonULeft
        b       next


buttonULeft:
        mov     r7, r9
        lsr     r7, #10
        and     r7, #1
        cmp     r7, #0
        bne     buttonURight
        b       next


buttonURight:
        mov     r7, r9
        lsr     r7, #11
        and     r7, #1
        cmp     r7, #0
        bne     next

next:
        b       Loop


exit:

pop     {r0-r10,lr}
mov     pc, lr
