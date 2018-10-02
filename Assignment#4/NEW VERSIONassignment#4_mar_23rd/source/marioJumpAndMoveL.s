
.global   marioJumpAndMoveBackward
marioJumpAndMoveBackward:

push    {lr}


push    {lr}

mov     r1, #0
start:
add     r1, #1
cmp     r1, #8
beq     marioMoveToLeft


ldr     r7, =FirstMap
mov     r8, #0    //r8 is row index for FirstMap
mov     r9, #0    //r9 is column index for FirstMap
mov     r10, #32    //r10 is the width and height for a cell
mov     r12, #0   //r12 is the offset of the FirstMap
//mov     r0, #1    //r0 is offset for byte
//mov     r1, #0    //r1 is a temp value
udiv    r8, r5, r10
udiv    r9, r4, r10
add     r9, #1
sub     r8, #1
mul     r12, r8, r10
mov     r0, #1
mul     r12, r0
mul     r0, r9, r0
add     r12, r0   //get the offset in front of mario from the FirstMap
sub     r12, #1
////////////////////////
mov     r2, r12
/////////////////////////////
ldrb    r11, [r7, r12]    //load the cell color in top of mario
mov     r0, #1
mul     r0, r9, r0
add     r8, #1
mul     r12, r8, r10
mov     r10, #1
mul     r12, r10
add     r12, r0   //get the offset which mario stand
sub     r12, #1
ldrb    r10, [r7, r12]  //load the cell color which mario stand

cmp     r11, #6
beq     marioHitBox
cmp     r11, #5
beq     marioHitBlock

mov     r0, r5
sub     r0, #32
movingAnimationJumpRight:
cmp     r0, r5
beq     start
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
sub     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationJumpRight

marioMoveToLeft:

ldr     r0, =flyStop
sub     r1, r4, #96
str     r1, [r0]


continueFly:
ldr     r7, =FirstMap
mov     r8, #0    //r8 is row index for FirstMap
mov     r9, #0    //r9 is column index for FirstMap
mov     r10, #32    //r10 is the width and height for a cell
mov     r12, #0   //r12 is the offset of the FirstMap
mov     r0, #1    //r0 is offset for byte
mov     r1, #0    //r1 is a temp value
udiv    r8, r5, r10
udiv    r9, r4, r10
mul     r12, r8, r10
mul     r12, r0
mul     r1, r9, r0
add     r12, r1   //get the offset in front of mario from the FirstMap
sub     r12, #1
ldrb    r11, [r7, r12]    //load the cell color in front of mario
add     r9, #1
mov     r12, #0
mul     r1, r9, r0
mul     r12, r8, r10
mul     r12, r0
add     r12, r1   //get the offset which mario stand
sub     r12, #1
ldrb    r10, [r7, r12]  //load the cell color which mario stand


cmp     r11, #31
//beq     marioMoveToTheNextCellPlant31
cmp     r11, #32
//beq     marioMoveToTheNextCellPlant32
cmp     r11, #33
//beq     marioMoveToTheNextCellPlant33
cmp     r11, #46



cmp     r4, #0
beq     standMarioUnderneathDetection
mov     r0, r4
sub     r0, #32
ldr     r1, =flyStop
ldr     r1, [r1]
cmp     r4, r1
beq     standMarioUnderneathDetection

movingAnimationRight:
cmp     r0, r4
beq     continueFly

ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
sub     r4, #2    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationRight

standMarioUnderneathDetection:
cmp     r5, #736
beq     RestartTheGame
ldr     r7, =FirstMap
mov     r8, #0    //r8 is row index for FirstMap
mov     r9, #0    //r9 is column index for FirstMap
mov     r10, #32    //r10 is the width and height for a cell
mov     r12, #0   //r12 is the offset of the FirstMap
mov     r0, #1    //r0 is offset for byte
mov     r1, #0    //r1 is a temp value
udiv    r8, r5, r10
udiv    r9, r4, r10
add     r8, #1
add     r9, #1
mul     r12, r8, r10
mul     r12, r0
mul     r1, r9, r0
add     r12, r1   //get the offset in front of mario from the FirstMap
sub     r12, #1
ldrb    r11, [r7, r12]    //load the cell color which is underneath of mario
mov     r12, #0
sub     r8, #1
mul     r1, r9, r0
mul     r12, r8, r10
mul     r12, r0
add     r12, r1   //get the offset which mario stand
sub     r12, #1
ldrb    r10, [r7, r12]  //load the cell color which mario stand
cmp     r11, #2
beq     marioFallDownToTheHell
b       exit3

marioFallDownToTheHell:
mov     r0, r5
add     r0, #32

marioKeepFalling:
cmp     r0, r5
beq     standMarioUnderneathDetection
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #2    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       marioKeepFalling

RestartTheGame:
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
bl      resetMap
bl      drawIntroduction
bl      drawIndicatorAtStart
bl      controller







marioHitBox:

mov     r3, #32
sub     r1, #1
mul     r1, r1, r3
mov     r0, r5
add     r0, r0, r1

///////////////////////////////////////
sub     r5, #32
ldr     r6, =BoxHit
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #32
//////////////////////////////

fall1:
cmp     r0, r5
beq     exit
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       fall1

exit:
ldr     r6, =MarioLeftStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture

bl      controller1

pop     {lr}
bx      lr

marioHitBlock:

mov     r3, #32
sub     r1, #1
mul     r1, r1, r3
mov     r0, r5
add     r0, r0, r1

///////////////////////////////////////
sub     r5, #32
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture



ldr     r7, =FirstMap
mov     r3, #2
strb    r3, [r7, r2]
add     r5, #32
//////////////////////////////

fall2:
cmp     r0, r5
beq     exit3
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       fall2

exit3:
ldr     r6, =MarioLeftStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
bl      controller1







pop     {lr}
bx      lr
