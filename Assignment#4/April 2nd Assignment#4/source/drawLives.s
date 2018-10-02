.section .text

// Draw lives on the screen
.global   drawLiveOnTheScreen
drawLiveOnTheScreen:
push    {r0, r4-r8, lr}

ldr     r6, =lives
ldr     r0, [r6]    // get the first bit of lives
cmp     r0, #0
bne     number1
ldr     r6, =numberZero
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number1:    // draw the first digit of lives
cmp     r0, #1
bne     number2
ldr     r6, =numberOne
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number2:
cmp     r0, #2
bne     number3
ldr     r6, =numberTwo
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number3:
cmp     r0, #3
bne     number4
ldr     r6, =numberThree
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number4:
cmp     r0, #4
bne     number5
ldr     r6, =numberFour
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number5:
cmp     r0, #5
bne     number6
ldr     r6, =numberFive
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number6:
cmp     r0, #6
bne     number7
ldr     r6, =numberSix
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number7:
cmp     r0, #7
bne     number8
ldr     r6, =numberSeven
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number8:
cmp     r0, #8
bne     number9
ldr     r6, =numberEight
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number9:
ldr     r6, =numberNine
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture

exit:
pop     {r0, r4-r8, lr}
bx      lr
