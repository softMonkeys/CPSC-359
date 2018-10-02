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
        //ldr     r0, =0x0000C350
        ldr     r0, =0X2710
        bl      Wait    // To wait 0.05s in the starting of each loop to avoid running out of memory
        //call the Read_SNES to get the numberlist and store it in r9
        bl      Read_SNES


        mov     r1, r0

        mov     r5, r0

        ldr     r0, =0xFFFE

        cmp     r5, r0
        bne     buttonLeft
        pop     {r0-r10,lr}
        bl      marioJump



buttonLeft:
        ldr     r0, =0xFFBF

        cmp     r5, r0
        bne     buttonRight
        pop     {r0-r10,lr}
        bl      marioWalkBackward

buttonRight:
        ldr     r0, =0xFF7F

        cmp     r5, r0
        bne     button_B_and_Right
        pop     {r0-r10,lr}
        bl      marioWalkForward






button_B_and_Right:
        ldr     r0, =0xFF7E

        cmp     r5, r0
        bne     button_B_and_Left
        pop     {r0-r10,lr}
        bl      marioJumpAndMoveForward

button_B_and_Left:
        ldr     r0, =0XFFBE

        cmp     r5, r0
        bne     buttonStart
        pop     {r0-r10,lr}
        bl      marioJumpAndMoveBackward

buttonStart:
        ldr     r0, =0XFFF7

        cmp     r5, r0
        bne     bottonY
        pop     {r0-r10,lr}
        b       pulse
pulse:  bl      drawPulse
        bl      drawIndicatorAtReStart
        bl      controller2

bottonY:
        ldr     r0, =0XFFFD

        cmp     r5, r0
        bne     bottonSelect

bottonSelect:
        ldr     r0, =0XFFFB

        cmp     r5, r0
        bne     bottonUp

bottonUp:
        ldr     r0, =0XFFEF

        cmp     r5, r0
        bne     bottonDown

bottonDown:
        ldr     r0, =0XFFDF


        cmp     r5, r0
        bne     bottonA

bottonA:
        ldr     r0, =0XFEFF

        cmp     r5, r0
        bne     bottonX

bottonX:
        ldr     r0, =0XFDFF

        cmp     r5, r0
        bne     bottonL

bottonL:
        ldr     r0, =0XFBFF

        cmp     r5, r0
        bne     bottonR

bottonR:
        ldr     r0, =0XF7FF

        cmp     r5, r0
        bne     mushRoomMove

mushRoomMove:
        mov     r0, #2000
        bl      Wait    // To wait 0.05s in the starting of each loop to avoid running out of memory
        bl      drawTurtle
        b       Loop





/*
*checkMushroom:
*        ldr     r0, =0XFFFF
*        ldr     r1, =save
*        ldr     r5, [r1]
*        cmp     r5, r0
*        beq     Loop
*
*        pop     {r0-r10,lr}
*        bl      drawMushRoom
*/


exit:

pop     {r0-r10,lr}
mov     pc, lr
