.section  .text

.global   drawMario
drawMario:

push    {r6-r8, lr}

ldr     r4, =608    // Starting postion for x
ldr     r5, =608    // Starting postion for y
ldr     r6, =MarioRightStand   // Load the address of "MarioRightStand" in "data.s"
ldr     r7, =32  // Width of the picture
ldr     r8, =32   // Height of the picture

bl      drawPicture

pop     {r6-r8, lr}
bx      lr

.global   marioJump
marioJump:

push    {lr}

ldr     r1, =checkLeftOrRight
ldr     r1, [r1]
cmp     r1, #1
beq     marioJump2


mov     r1, #0
start:
add     r1, #1
cmp     r1, #8
beq     marioFallRight


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

ldr     r6, =marioJumpRightPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationJumpRight

marioFallRight:
mov     r0, r5
add     r0, #224
fall:
cmp     r0, r5
beq     exit
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpRightPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       fall

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

ldr     r6, =marioJumpRightPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       fall1

exit:
ldr     r6, =MarioRightStand
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

ldr     r6, =marioJumpRightPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       fall2

exit3:
ldr     r6, =MarioRightStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture

bl      controller1
pop     {lr}
bx      lr











////////////////////////////////////
marioJump2:
mov     r1, #0
start2:
add     r1, #1
cmp     r1, #8
beq     marioFallLeft


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
beq     marioHitBox2
cmp     r11, #5
beq     marioHitBlock2

mov     r0, r5
sub     r0, #32
movingAnimationJumpLeft:
cmp     r0, r5
beq     start2
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
sub     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationJumpLeft

marioFallLeft:
mov     r0, r5
add     r0, #224
fall3:
cmp     r0, r5
beq     exit6
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       fall3

exit6:
ldr     r6, =MarioLeftStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
bl      controller1


pop     {lr}
bx      lr

marioHitBox2:

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

fall4:
cmp     r0, r5
beq     exit4
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       fall4

exit4:
ldr     r6, =MarioLeftStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
bl      controller1

pop     {lr}
bx      lr

marioHitBlock2:

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

fall5:
cmp     r0, r5
beq     exit5
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       fall5

exit5:
ldr     r6, =MarioLeftStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
bl      controller1


pop     {lr}
bx      lr


































.global   marioWalkBackward
marioWalkBackward:

push    {lr}
//////////////////////////
// This section of code is to memorize mario's face diraction
ldr     r7, =checkLeftOrRight
mov     r8, #1
str     r8, [r7]
//////////////////////////
cmp     r4, #0
ble     exit1     // if mario's is on the left end of the map, he won't move

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

cmp     r10, #251
beq     marioDie1
cmp     r10, #252
beq     marioDie1

cmp     r11, #31
//beq     marioMoveToTheNextCellPlant31
cmp     r11, #32
//beq     marioMoveToTheNextCellPlant32
cmp     r11, #33
//beq     marioMoveToTheNextCellPlant33
cmp     r11, #46
beq     exit1


mov     r0, r4
sub     r0, #32
movingAnimationLeft:
cmp     r0, r4
beq     standMarioUnderneathDetection1
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
sub     r4, #2    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =MarioLeftStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationLeft

standMarioUnderneathDetection1:
cmp     r5, #736
beq     RestartTheGame1
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
beq     marioFallDownToTheHell1
b       exit1

marioFallDownToTheHell1:
mov     r0, r5
add     r0, #32

marioKeepFalling1:
cmp     r0, r5
beq     standMarioUnderneathDetection1
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #2    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =MarioLeftStand
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       marioKeepFalling1

RestartTheGame1:
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
bl      resetMap
bl      drawIntroduction
bl      drawIndicatorAtStart
bl      controller

exit1:
bl      controller1

pop     {lr}
bx      lr

marioDie1:
mov     r0, r5
sub     r0, #64
movingAnimationDIe1:
cmp     r0, r5
beq     waitSec
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
sub     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioDiePicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationDIe1

waitSec:
ldr     r0, =0XF4240
bl      Wait
bl      RestartTheGame





.global   marioWalkForward
marioWalkForward:

push    {lr}
//////////////////////////
// This section of code is to memorize mario's face diraction
ldr     r7, =checkLeftOrRight
mov     r8, #0
str     r8, [r7]
//////////////////////////
ldr     r7, =FirstMap
mov     r8, #0    //r8 is row index for FirstMap
mov     r9, #0    //r9 is column index for FirstMap
mov     r10, #32    //r10 is the width and height for a cell
mov     r12, #0   //r12 is the offset of the FirstMap
mov     r0, #1    //r0 is offset for byte
mov     r1, #0    //r1 is a temp value
udiv    r8, r5, r10
udiv    r9, r4, r10
add     r9, #2
mul     r12, r8, r10
mul     r12, r0
mul     r1, r9, r0
add     r12, r1   //get the offset in front of mario from the FirstMap
sub     r12, #1
ldrb    r11, [r7, r12]    //load the cell color in front of mario
sub     r9, #1
mov     r12, #0
mul     r1, r9, r0
mul     r12, r8, r10
mul     r12, r0
add     r12, r1   //get the offset which mario stand
sub     r10, #1
ldrb    r10, [r7, r12]  //load the cell color which mario stand


cmp     r10, #251
beq     marioDie
cmp     r10, #252
beq     marioDie


cmp     r11, #31
//beq     marioMoveToTheNextCellPlant31
cmp     r11, #32
//beq     marioMoveToTheNextCellPlant32
cmp     r11, #33
//beq     marioMoveToTheNextCellPlant33
cmp     r11, #45
beq     exit2

mov     r0, r4
add     r0, #32
movingAnimationRight:
cmp     r0, r4
beq     standMarioUnderneathDetection
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r4, #2    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =MarioRightStand
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
b       exit2

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

ldr     r6, =MarioRightStand
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

exit2:
bl      controller1
pop     {lr}
bx      lr

.global marioDie
marioDie:
mov     r0, r5
sub     r0, #64
movingAnimationDIe:
cmp     r0, r5
beq     waitSec1
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
sub     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioDiePicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationDIe


waitSec1:
ldr     r0, =0XF4240
bl      Wait
bl      RestartTheGame
