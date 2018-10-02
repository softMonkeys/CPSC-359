
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
        //call the Read_SNES to get the numberlist and store it in r9
        bl      Read_SNES
        cmp     r5, r9
        beq     next
        mov     r5, r9

//print out the corresponding button(s)
buttonB:
        mov     r7, r9
        and     r7, #1
        cmp     r7, #0
        bne     buttonY



buttonY:
        mov     r7, r9
        lsr     r7, #1
        and     r7, #1
        cmp     r7, #0
        bne     buttonSelect

buttonSelect:
        mov     r7, r9
        lsr     r7, #2
        and     r7, #1
        cmp     r7, #0
        bne     buttonStart

buttonStart:
        mov     r7, r9
        lsr     r7, #3
        and     r7, #1
        cmp     r7, #0
        bne     buttonUp

buttonUp:
        mov     r7, r9
        lsr     r7, #4
        and     r7, #1
        cmp     r7, #0
        bne     buttonDown
        push    {lr}
        bl      clearPointerQuitM
        bl      drawPointerStartM
        mov     r10, #0
        pop     {lr}

buttonDown:
        mov     r7, r9
        lsr     r7, #5
        and     r7, #1
        cmp     r7, #0
        bne     buttonLeft
        push    {lr}
        bl      clearPointerStartM
        bl      drawPointerQuitM
        mov     r10, #1
        pop     {lr}

buttonLeft:
        mov     r7, r9
        lsr     r7, #6
        and     r7, #1
        cmp     r7, #0
        bne     buttonRight

buttonRight:
        mov     r7, r9
        lsr     r7, #7
        and     r7, #1
        cmp     r7, #0
        bne     buttonA

buttonA:
        mov     r7, r9
        lsr     r7, #8
        and     r7, #1
        cmp     r7, #0
        bne     buttonX
        tst     r10, #1
        bne     quit
        b       start
buttonX:
        mov     r7, r9
        lsr     r7, #9
        and     r7, #1
        cmp     r7, #0
        bne     buttonULeft

buttonULeft:
        mov     r7, r9
        lsr     r7, #10
        and     r7, #1
        cmp     r7, #0
        bne     buttonURight

buttonURight:
        mov     r7, r9
        lsr     r7, #11
        and     r7, #1
        cmp     r7, #0
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
Wait:
        ldr r0, =0x3F003004
        ldr r1, [r0]
        add r1, r3
waitLoop:
        ldr r2,[r0]
        cmp r1, r2
        bhi waitLoop
exitWait:
        mov     pc, lr

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
        mov     r3, #12
        bl      Wait
        mov     r1, #0
        bl      WriteLatch
        mov     r8, #0// index
pulseLoop:
        mov     r3, #6
        bl      Wait
        mov     r1, #0
        bl      WriteClock
        mov     r3, #6
        bl      Wait
        bl      ReadData
        lsl     r4, r8
        orr     r9, r4
        mov     r1, #1
        bl      WriteClock
        add     r8, #1
        cmp     r8, #16
        blt     pulseLoop
ExitRead_SNES:
        pop     {lr}
        mov     pc, lr

//Read_SNES------------------------end
start:
        bl      StartGame
        b       exit
quit:
        bl      QuitGame

exit:

pop     {r0-r10,lr}
mov     pc, lr
