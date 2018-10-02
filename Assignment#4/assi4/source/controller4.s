
.section .text

.global controller4
controller4:
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
        ldr	  r4,	= 410	//Start X position of your picture
        ldr	  r5,	= 330
        ldr	  r6,	= picReStartC			//Address of the picture
        ldr	  r7,	= 210			//Width of your picture
        ldr	  r8,	= 30

        bl    drawPicture

        ldr	  r4,	= 425	//Start X position of your picture
        ldr	  r5,	= 395
        ldr	  r6,	= picQuitC			//Address of the picture
        ldr	  r7,	= 120			//Width of your picture
        ldr	  r8,	= 30

        bl    drawPicture
        bl    clearPointerStartP
        bl    clearPointerQuitP

        b       exit

buttonUp:
        mov     r7, r9
        lsr     r7, #4
        and     r7, #1
        cmp     r7, #0
        bne     buttonDown
        push    {lr}
        bl      clearPointerQuitP
        bl      drawPointerStartP
        mov     r10, #0
        pop     {lr}

buttonDown:
        mov     r7, r9
        lsr     r7, #5
        and     r7, #1
        cmp     r7, #0
        bne     buttonLeft
        push    {lr}
        bl      clearPointerStartP
        bl      drawPointerQuitP
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

start:
        bl      initAllState
        bl      StartGame
        b       exit
quit:
        bl      reStart

exit:

pop     {r0-r10,lr}
mov     pc, lr
