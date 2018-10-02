.section .text

.global   LivesShowingOnTheScreen
LivesShowingOnTheScreen:
push    {r0, r4-r8, lr}

// Mario lose one live
ldr     r6, =lives
ldr     r7, [r6]
cmp     r7, #1
beq     lostTheGame   // If mario's live is zero, player lose the game.
sub     r7, #1
str     r7, [r6]

//  Draw the live's first digit on the screen
ldr     r6, =lives
ldr     r0, [r6]
cmp     r0, #0
bne     number1
ldr     r6, =numberZero
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number1:
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

// player lose the game, so score, coin number and live should be initalized.
lostTheGame:
ldr     r7, =MarioWin  //0 stand for lose
mov     r8, #0
str     r8, [r7]

ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
ldr     r7, =scores
mov     r8, #0
str     r8, [r7]

// score become 000000
ldr     r7, =scores
mov     r8, #0
str     r8, [r7, #4]

ldr     r7, =scores
mov     r8, #0
str     r8, [r7, #8]

ldr     r7, =scores
mov     r8, #0
str     r8, [r7, #12]

// coin number become 00
ldr     r7, =coinNumber
mov     r8, #0
str     r8, [r7]

ldr     r7, =coinNumber
mov     r8, #0
str     r8, [r7, #4]

ldr     r7, =mapNumber
mov     r8, #1
str     r8, [r7]

// live become 4
ldr     r7, =lives
mov     r8, #4
str     r8, [r7]

ldr   r4, =0    // Starting postion for x
ldr   r5, =0    // Starting postion for y
ldr   r6, =lostPicture    // Load the address of "Intro" in "data.s"
ldr   r7, =1024   // Width of the picture
ldr   r8, =768    // Height of the picture
bl    drawPicture

bl      resetMap

ldr   r0, =enterTheGameCheck
mov   r1, #1
str   r1, [r0]

bl      drawIntroduction
bl      drawIndicatorAtStart
bl      controller

// When mario eat the value pack, his live will pluse one.
.global   LivesShowingOnTheScreenAdd
LivesShowingOnTheScreenAdd:
push    {r0, r4-r8, lr}

ldr     r6, =lives
ldr     r7, [r6]
add     r7, #1
str     r7, [r6]

// Draw the updated live on the screen
ldr     r6, =lives
ldr     r0, [r6]
cmp     r0, #0
bne     number1a
ldr     r6, =numberZero
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exita
number1a:
cmp     r0, #1
bne     number2a
ldr     r6, =numberOne
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exita
number2a:
cmp     r0, #2
bne     number3a
ldr     r6, =numberTwo
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exita
number3a:
cmp     r0, #3
bne     number4a
ldr     r6, =numberThree
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exita
number4a:
cmp     r0, #4
bne     number5a
ldr     r6, =numberFour
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exita
number5a:
cmp     r0, #5
bne     number6a
ldr     r6, =numberFive
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exita
number6a:
cmp     r0, #6
bne     number7a
ldr     r6, =numberSix
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number7a:
cmp     r0, #7
bne     number8a
ldr     r6, =numberSeven
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exita
number8a:
cmp     r0, #8
bne     number9a
ldr     r6, =numberEight
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exita
number9a:
ldr     r6, =numberNine
ldr     r4, =896
ldr     r5, =32
ldr     r7, =32
ldr     r8, =32
bl      drawPicture

exita:
pop     {r0, r4-r8, lr}
bx      lr
