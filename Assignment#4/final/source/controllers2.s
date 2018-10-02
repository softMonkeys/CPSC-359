.section .text

// This subroutine is for the pulse controller
.global controller2
controller2:
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
        mov     r1, r0
        mov     r5, r0
        ldr     r0, =0xFFFE
        cmp     r5, r0
        bne     buttonLeft
buttonLeft:
        ldr     r0, =0xFFBF
        cmp     r5, r0
        bne     buttonRight
buttonRight:
        ldr     r0, =0xFF7F
        cmp     r5, r0
        bne     button_B_and_Right
button_B_and_Right:
        ldr     r0, =0xFF7E
        cmp     r5, r0
        bne     button_B_and_Left
button_B_and_Left:
        ldr     r0, =0XFFBE
        cmp     r5, r0
        bne     buttonStart
buttonStart:
        ldr     r0, =0XFFF7
        cmp     r5, r0
        bne     bottonY
        pop     {r0-r10,lr}
        // If user pressed start again, erease the pulse menu
        ldr     r0, =pulseCheck   // undate the pulseCheck to let InterruptFuction stop
        mov     r1, #0
        str     r1, [r0]
        bl      ClearPulseMenu
        bl      controller1   // go back to game controller
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
        push    {lr}
        bl      clearIndicatorAtQuit1   // clear the indicator
        bl      drawIndicatorAtReStart    // draw the indicator
        mov     r10, #0
        pop     {lr}
bottonDown:
        ldr     r0, =0XFFDF
        cmp     r5, r0
        bne     bottonA
        push    {lr}
        bl      clearIndicatorAtReStart   // clear the indicator
        bl      drawIndicatorAtQuit1    // draw the indicator
        mov     r10, #1
        pop     {lr}
bottonA:
        ldr     r0, =0XFEFF
        cmp     r5, r0
        bne     bottonX
        cmp     r10, #0
        bne     quit
        // Update the game status to not in game
        ldr     r0, =enterTheGameCheck
        mov     r1, #1
        str     r1, [r0]
        bl      resetMap    // reset the map
        bl      StartGame   // branch to start the game
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
        bne     Loop
        b       Loop
quit:
      // Update the game status to not in game
      ldr   r0, =enterTheGameCheck
      mov   r1, #1
      str   r1, [r0]
      bl    drawIntroduction    // draw the introduction page
      bl    drawIndicatorAtStart    // draw the indicator
      bl    controller    // branch to introduction controller
exit:
      pop     {r0-r10,lr}
      mov     pc, lr
