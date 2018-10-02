// This subroutine will make mario jump and move left when user pressed B and left
.global   marioJumpAndMoveBackward
marioJumpAndMoveBackward:
push    {lr}
mov     r1, #0
start:
add     r1, #1
cmp     r1, #8
beq     marioMoveToLeft
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap
cmp     r8, #2
beq     LoadSecondMap
cmp     r8, #3
beq     LoadThirdMap
bl      quitGame
LoadFirstMap:
ldr     r7, =FirstMap
b       continueNext
LoadSecondMap:
ldr     r7, =SecondMap
b       continueNext
LoadThirdMap:
ldr     r7, =ThirdMap
continueNext:
mov     r8, #0    //r8 is row index for FirstMap
mov     r9, #0    //r9 is column index for FirstMap
mov     r10, #32    //r10 is the width and height for a cell
mov     r12, #0   //r12 is the offset of the FirstMap
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

// r11 is the offest on top of the mario, if the offset on top of the mario is not sky, he will react to different situations
cmp     r11, #8
beq     marioHitBoxAlready
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

// Mario animation to the left
marioMoveToLeft:
ldr     r0, =flyStop
sub     r1, r4, #96
str     r1, [r0]


continueFly:
cmp     r4, #0
bne     nextStep
ldr     r7, =mapNumber
ldr     r8, [r7]
sub     r8, #1
cmp     r8, #1
beq     GoToTheFirstMap
cmp     r8, #2
beq     GoToTheSecondMap1
cmp     r8, #0
beq     standMarioUnderneathDetection

nextStep:
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap0
cmp     r8, #2
beq     LoadSecondMap0
cmp     r8, #3
beq     LoadThirdMap0
bl      quitGame
LoadFirstMap0:
ldr     r7, =FirstMap
b       continueNext0
LoadSecondMap0:
ldr     r7, =SecondMap
b       continueNext0
LoadThirdMap0:
ldr     r7, =ThirdMap

continueNext0:
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
cmp     r11, #74
beq      standMarioUnderneathDetection
cmp     r4, #0
beq     standMarioUnderneathDetection
mov     r0, r4
sub     r0, #32
ldr     r1, =flyStop
ldr     r1, [r1]
cmp     r4, r1
beq     standMarioUnderneathDetection

// mario animation to the right
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
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap1
cmp     r8, #2
beq     LoadSecondMap1
cmp     r8, #3
beq     LoadThirdMap1
bl      quitGame
LoadFirstMap1:
ldr     r7, =FirstMap
b       continueNext1
LoadSecondMap1:
ldr     r7, =SecondMap
b       continueNext1
LoadThirdMap1:
ldr     r7, =ThirdMap

continueNext1:
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
cmp     r11, #27
beq     marioJumpOnTurtle
cmp     r11, #28
beq     marioJumpOnTurtle
cmp     r11, #251
beq     marioJumpOnMushroom
cmp     r11, #252
beq     marioJumpOnMushroom
cmp     r11, #40
bne     marioNoBonusCase
bl      marioBonusRandL

mov     r0, r5
add     r0, #32

marioKeepFalling2:
cmp     r0, r5
beq     exit3
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #2    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       marioKeepFalling2

marioNoBonusCase:
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
// Exit when mario landed on the ground
RestartTheGame:
bl      LivesShowingOnTheScreen
ldr     r7, =mapNumber
mov     r8, #1
str     r8, [r7]
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
bl      resetMap
bl      drawIntroduction
bl      drawIndicatorAtStart
bl      controller
// Case when mario hit a box
marioHitBox:
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap2
cmp     r8, #2
beq     LoadSecondMap2
cmp     r8, #3
beq     LoadThirdMap2
bl      quitGame
LoadFirstMap2:
ldr     r7, =FirstMap
b       continueNext2
LoadSecondMap2:
ldr     r7, =SecondMap
b       continueNext2
LoadThirdMap2:
ldr     r7, =ThirdMap

continueNext2:
mov     r3, #8
strb    r3, [r7, r2]

///////////////////////////////////////
sub     r5, #32
ldr     r6, =BoxHit
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
sub     r5, #32
ldr     r6, =drawCoin2
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
ldr     r6, =coinDisappearX
ldr     r7, [r6]
mov     r7, r4
str     r7, [r6]
ldr     r6, =coinDisappearY
ldr     r7, [r6]
mov     r7, r5
str     r7, [r6]

add     r5, #64
bl      coinNumberShowingOnTheScreen
bl      scoreShowingOnTheScreen
//////////////////////////////
// Cae when mario hit block already
marioHitBoxAlready:
mov     r3, #32
sub     r1, #1
mul     r1, r1, r3
mov     r0, r5
add     r0, r0, r1
// Mario fall animation
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

// Exit when mario landed on the ground
exit:
ldr     r6, =MarioLeftStand
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture3
bl      controller1
pop     {lr}
bx      lr

// Case when mario hit a block
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
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap3
cmp     r8, #2
beq     LoadSecondMap3
cmp     r8, #3
beq     LoadThirdMap3
bl      quitGame
LoadFirstMap3:
ldr     r7, =FirstMap
b       continueNext3
LoadSecondMap3:
ldr     r7, =SecondMap
b       continueNext3
LoadThirdMap3:
ldr     r7, =ThirdMap

continueNext3:
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
// Exit when mario landed on the ground
exit3:
ldr     r7, =marioXPosition
str     r4, [r7]
ldr     r8, =marioYPosition
str     r5, [r8]
ldr     r6, =MarioLeftStand
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture4
bl      controller1

// Mario jump on turtle
marioJumpOnTurtle:
bl      scoreShowingOnTheScreen
add     r12, #32    // add 32 to r12
mov     r0, #2
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap4
cmp     r8, #2
beq     LoadSecondMap4
cmp     r8, #3
beq     LoadThirdMap4
bl      quitGame
LoadFirstMap4:
ldr     r1, =FirstMap
b       continueNext4
LoadSecondMap4:
ldr     r1, =SecondMap
b       continueNext4
LoadThirdMap4:
ldr     r1, =ThirdMap

continueNext4:
strb    r0, [r1, r12]
ldr     r1, =checkTurtleDeath
ldr     r0, [r1]
mov     r0, #0
str     r0, [r1]
add     r5, #32
ldr     r6, =turtleDiePicture
ldr     r7, =32
ldr     r8, =32
bl      drawPicture4
mov     r1, #0
start12:
add     r1, #1
cmp     r1, #2
beq     marioFallRight4
mov     r0, r5
sub     r0, #96
movingAnimationJumpRight12:
cmp     r0, r5
beq     start12
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
sub     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationJumpRight12

// Mario fall animation
marioFallRight4:
mov     r0, r5
add     r0, #96
fall7:
cmp     r0, r5
beq     turtleDieRight
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #2    // the mario will move at 2 pixel/time in order to generate smooth movement
ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       fall7

// Draw the turtle's shell moving to the right
turtleDieRight:
ldr     r6, =MarioLeftStand
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
ldr     r7, =TurtleXPosition
ldr     r6, [r7]
add     r6, #32
str     r6, [r7]
checkTurtleDieRight:
ldr     r7, =TurtleXPosition
ldr     r6, [r7]
cmp     r6, #992
beq     exit3
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture4
ldr     r6, =TurtleXPosition
ldr     r7, [r6]
add     r7, #2    // the mario will move at 2 pixel/time in order to generate smooth movement
str     r7, [r6]
ldr     r6, =turtleDiePicture
ldr     r7, =32
ldr     r8, =32
bl      drawPicture4
b       checkTurtleDieRight

// Care when mario jump on a mushroom
marioJumpOnMushroom:
bl      scoreShowingOnTheScreen
add     r12, #32
mov     r0, #2
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap5
cmp     r8, #2
beq     LoadSecondMap5
cmp     r8, #3
beq     LoadThirdMap5
bl      quitGame
LoadFirstMap5:
ldr     r1, =FirstMap
b       continueNext5
LoadSecondMap5:
ldr     r1, =SecondMap
b       continueNext5
LoadThirdMap5:
ldr     r1, =ThirdMap

continueNext5:
strb    r0, [r1, r12]
ldr     r1, =checkMushroomDeath
ldr     r0, [r1]
mov     r0, #0
str     r0, [r1]
add     r5, #32
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
mov     r1, #0
start1:
add     r1, #1
cmp     r1, #2
beq     marioFallRight
mov     r0, r5
sub     r0, #96
movingAnimationJumpRight1:
cmp     r0, r5
beq     start1
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
sub     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement
ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       movingAnimationJumpRight1
marioFallRight:
mov     r0, r5
add     r0, #96
fall:
cmp     r0, r5
beq     exit3
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #2    // the mario will move at 2 pixel/time in order to generate smooth movement
ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       fall
pop     {lr}
bx      lr
