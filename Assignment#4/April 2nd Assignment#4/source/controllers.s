.section .text

.global controller
controller:
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

// After Read_SNES, we need decompose the 16 bits value to check which button is pressed
buttonB:
        mov     r7, r9
        and     r7, #1
        cmp     r7, #0    // take the 1st bit
        bne     buttonY
        b       next
buttonY:
        mov     r7, r9
        lsr     r7, #1
        and     r7, #1
        cmp     r7, #0    // take the 2nd bit
        bne     buttonSelect
        b       next
buttonSelect:
        mov     r7, r9
        lsr     r7, #2
        and     r7, #1
        cmp     r7, #0    // take the 3rd bit
        bne     buttonStart
        b       next
buttonStart:
        mov     r7, r9
        lsr     r7, #3
        and     r7, #1
        cmp     r7, #0    // take the 4th bit
        bne     buttonUp
        b       next
buttonUp:
        mov     r7, r9
        lsr     r7, #4
        and     r7, #1
        cmp     r7, #0    // take the 5th bit
        bne     buttonDown
        push    {lr}
        bl      clearIndicatorAtQuit    // clear the previous indicator image
        bl      drawIndicatorAtStart    // draw the new indicator image
        mov     r10, #0
        pop     {lr}
        b       next
buttonDown:
        mov     r7, r9
        lsr     r7, #5
        and     r7, #1
        cmp     r7, #0    // take the 5th bit
        bne     buttonLeft
        push    {lr}
        bl      clearIndicatorAtStart    // clear the previous indicator image
        bl      drawIndicatorAtQuit    // draw the new indicator image
        mov     r10, #1
        pop     {lr}
        b       next
buttonLeft:
        mov     r7, r9
        lsr     r7, #6
        and     r7, #1
        cmp     r7, #0    // take the 6th bit
        bne     buttonRight
        b       next
buttonRight:
        mov     r7, r9
        lsr     r7, #7
        and     r7, #1
        cmp     r7, #0    // take the 7th bit
        bne     buttonA
        b       next
buttonA:
        mov     r7, r9
        lsr     r7, #8
        and     r7, #1
        cmp     r7, #0    // take the 6th bit
        bne     buttonX
        cmp     r10, #0
        bne     quit
        b       start
buttonX:
        mov     r7, r9
        lsr     r7, #9
        and     r7, #1
        cmp     r7, #0    // take the 7th bit
        bne     buttonULeft
        b       next
buttonULeft:
        mov     r7, r9
        lsr     r7, #10
        and     r7, #1
        cmp     r7, #0    // take the 8th bit
        bne     buttonURight
        b       next
buttonURight:
        mov     r7, r9
        lsr     r7, #11
        and     r7, #1
        cmp     r7, #0    // take the 9th bit
        bne     next
next:
        b       Loop

//Initialize------------------------start
.global Init_GPIO
Init_GPIO:
setLatch:
        ldr     r0, =0x3f200000
        ldr     r1, [r0]
        mov     r2, #7
        lsl     r2, #27
        bic     r1, r2
        mov     r3, #1
        lsl     r3, #27
        orr     r1, r3
        str     r1, [r0]

.global setClock
setClock:
        ldr     r0, =0x3f200004
        ldr     r1, [r0]
        mov     r2, #7
        lsl     r2, #3
        bic     r1, r2
        mov     r3, #1
        lsl     r3, #3
        orr     r1, r3
        str     r1, [r0]

.global setData
setData:
        ldr     r0, =0x3f200004
        ldr     r1, [r0]
        mov     r2, #7
        bic     r1, r2
        mov     r3, #0
        orr     r1, r3
        str     r1, [r0]
        mov     pc, lr
//Initialize------------------------end

//WriteClock------------------------start
//parameter r1 :the value to write
.global WriteClock
WriteClock:
        mov r0, #11
        ldr r2, =0x3f200000
        mov r3, #1
        lsl r3, r0
        teq r1, #0
        streq r3, [r2, #40]
        strne r3, [r2, #28]
        mov     pc, lr
//WriteClock------------------------end

//WriteLatch------------------------start
//parameter r1 :the value to write
.global WriteLatch
WriteLatch:
        mov r0, #9
        ldr r2, =0x3f200000
        mov r3, #1
        lsl r3, r0
        teq r1, #0
        streq r3, [r2, #40]
        strne r3, [r2, #28]
        mov     pc, lr
//WriteLatch------------------------end

//ReadData------------------------start
//return r4 :the data readed from snes
.global ReadData
ReadData:
        mov r0, #10
        ldr r2, =0x3f200000
        ldr r1, [r2, #52]
        mov r3, #1
        lsl r3, r0
        and r1, r3
        teq r1, #0
        moveq r4, #0
        movne r4, #1
        mov     pc, lr
//ReadData------------------------end

//Wait------------------------start
//parameter r3 :the time to wait
.global Wait
// Waits for a time interval, passed as a parameter
Wait:   mov r3, r0    // move the time into r3
        ldr r0, =0x3F003004   // address of CLO
        ldr r1, [r0]    // read CLO
        add r1, r3
        waitLoop:
        ldr r2, [r0]
        cmp r1, r2    // stop when CLO = r1
        bhi waitLoop
        bx  lr

//Wait------------------------end

//Read_SNES------------------------start
//return r9: the 16-bit long number list
.global Read_SNES
Read_SNES:
        push    {lr}
        mov     r9, #0
        mov     r1, #1
        bl      WriteClock
        bl      WriteLatch
        mov     r0, #12
        bl      Wait
        mov     r1, #0
        bl      WriteLatch
        mov     r8, #0// index
pulseLoop:
        mov     r0, #6
        bl      Wait
        mov     r1, #0
        bl      WriteClock
        mov     r0, #6
        bl      Wait
        bl      ReadData
        lsl     r4, r8
        orr     r9, r4
        mov     r1, #1
        bl      WriteClock
        add     r8, #1
        cmp     r8, #16
        blt     pulseLoop
        mov     r0, r9
        pop     {lr}
        mov     pc, lr

//Read_SNES------------------------end
start:
        bl      StartGame   // branch to StartGame
        b       exit
quit:
        bl      quitGame    // quit the game
exit:
pop     {r0-r10,lr}
mov     pc, lr
