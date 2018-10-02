.section  .text

// This subroutine will draw mario in his x and y position
.global   drawMario
drawMario:
  push    {r6-r8, lr}
  ldr     r4, =0    // Starting postion for x
  ldr     r5, =608    // Starting postion for y
  ldr     r7, =marioXPosition
  str     r4, [r7]
  ldr     r8, =marioYPosition
  str     r5, [r8]
  ldr     r6, =MarioRightStand   // Load the address of "MarioRightStand" in "data.s"
  ldr     r7, =32  // Width of the picture
  ldr     r8, =32   // Height of the picture
  bl      drawPicture
  pop     {r6-r8, lr}
  bx      lr

  // This subroutine will draw mario in his x and y position when he gose back from previous map to the current map
.global   drawMario1
drawMario1:
  push    {r6-r8, lr}
  ldr     r4, =992    // Starting postion for x
  ldr     r5, =608    // Starting postion for y
  ldr     r7, =marioXPosition
  str     r4, [r7]
  ldr     r8, =marioYPosition
  str     r5, [r8]
  ldr     r6, =MarioLeftStand   // Load the address of "MarioRightStand" in "data.s"
  ldr     r7, =32  // Width of the picture
  ldr     r8, =32   // Height of the picture
  bl      drawPicture
  pop     {r6-r8, lr}
  bx      lr

// This subroutine will let mario jump
.global   marioJump
marioJump:
push    {lr}
// Check mario need to turn, if yes, branch to marioJump2
ldr     r1, =checkLeftOrRight
ldr     r1, [r1]
cmp     r1, #1
beq     marioJump2

// The mario starts to jump
mov     r1, #0
start:
add     r1, #1
cmp     r1, #8    // he will jump 32 pixel X 8 cells
beq     marioFallRight    // if mario reach the 32 pixel X 8 cells, he fall down

// Load the map number to check where is mario located
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

// Calculate the offset
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
///////////////
mov     r2, r12   // move the offset to a temperate register r2
///////////////
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

// if on top of mario is sky, mario starts to jump
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

// Mario starts to fall
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

// This is the condition when mario hit a box
marioHitBox:
// Load the map number to determine which map is mario located
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

// Store the offest of a hitten box for the next mario jump
continueNext0:
mov     r3, #8
strb    r3, [r7, r2]
// Show the coin
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
marioHitBoxAlready:
mov     r3, #32
sub     r1, #1
mul     r1, r1, r3
mov     r0, r5
add     r0, r0, r1

// This fall1 is for mario hiited an object on his way of jumping
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

// Exit when mario landed on the ground
exit:
ldr     r6, =MarioRightStand
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

// Mario hit a block already
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

// Load the map number to determine which map is mario located
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
mov     r3, #2
strb    r3, [r7, r2]
add     r5, #32
//////////////////////////////
// Mario fall
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
// Exit when mario landed on the ground
exit3:
ldr     r6, =MarioRightStand
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
bl      controller1
pop     {lr}
bx      lr

// This subroutine
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
bne     nextStep0
ldr     r7, =mapNumber
ldr     r8, [r7]
sub     r8, #1
cmp     r8, #1
beq     GoToTheFirstMap
cmp     r8, #2
beq     GoToTheSecondMap1
cmp     r8, #0
beq     exit1

// Load the map number
nextStep0:
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
ldr     r7, =FirstMap
b       continueNext5
LoadSecondMap5:
ldr     r7, =SecondMap
b       continueNext5
LoadThirdMap5:
ldr     r7, =ThirdMap
continueNext5:
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
ldrb    r11, [r7, r12]    //load the cell color in back of mario
add     r9, #1
mov     r12, #0
mul     r1, r9, r0
mul     r12, r8, r10
mul     r12, r0
add     r12, r1   //get the offset which mario stand
sub     r12, #1
ldrb    r10, [r7, r12]  //load the cell color which mario stand
cmp     r11, #251
beq     marioDie1
cmp     r11, #252
beq     marioDie1
cmp     r11, #27
beq     marioDie1
cmp     r11, #28
beq     marioDie1
cmp     r11, #40
bleq    marioBonus
cmp     r11, #46
beq     exit1
cmp     r11, #5
beq     exit2
cmp     r11, #30
beq     exit2
cmp     r11, #6
beq     exit2
cmp     r11, #8
beq     exit2

// Draw mario moving towards left
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

// Detects what is under the mario
standMarioUnderneathDetection1:
ldr     r7, =marioXPosition
str     r4, [r7]
ldr     r8, =marioYPosition
str     r5, [r8]

cmp     r5, #736
beq     RestartTheGame1
// Load the map number
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap6
cmp     r8, #2
beq     LoadSecondMap6
cmp     r8, #3
beq     LoadThirdMap6
bl      quitGame
LoadFirstMap6:
ldr     r7, =FirstMap
b       continueNext6
LoadSecondMap6:
ldr     r7, =SecondMap
b       continueNext6
LoadThirdMap6:
ldr     r7, =ThirdMap

// Calculate the offset
continueNext6:
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
cmp     r11, #251
beq     marioJumpOnMushroom1
cmp     r11, #252
beq     marioJumpOnMushroom1
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
bl      LivesShowingOnTheScreen
// Load the map number
ldr     r7, =mapNumber
mov     r8, #1
str     r8, [r7]
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
bl      resetMap
ldr     r0, =enterTheGameCheck
mov     r1, #1
str     r1, [r0]
bl      drawIntroduction
bl      drawIndicatorAtStart
bl      controller

// Exit when mario landed on the ground
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

marioJumpOnMushroom1:
bl      scoreShowingOnTheScreen
add     r12, #32
mov     r0, #2
// Load the map number
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap7
cmp     r8, #2
beq     LoadSecondMap7
cmp     r8, #3
beq     LoadThirdMap7
bl      quitGame
LoadFirstMap7:
ldr     r1, =FirstMap
b       continueNext7
LoadSecondMap7:
ldr     r1, =SecondMap
b       continueNext7
LoadThirdMap7:
ldr     r1, =ThirdMap

continueNext7:
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
start11:
add     r1, #1
cmp     r1, #2
beq     marioFallRight1
mov     r0, r5
sub     r0, #96
movingAnimationJumpRight11:
cmp     r0, r5
beq     start11
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
sub     r5, #4    // the mario will move at 2 pixel/time in order to generate smooth movement
ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationJumpRight11

marioFallRight1:
mov     r0, r5
add     r0, #96
fall11:
cmp     r0, r5
beq     exit11
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #2    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       fall11

// Exit when mario landed on the ground
exit11:
ldr     r6, =MarioLeftStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture

bl      controller1

pop     {lr}
bx      lr





.global   marioWalkForward
marioWalkForward:

push    {lr}
//////////////////////////
// This section of code is to memorize mario's face diraction
ldr     r7, =checkLeftOrRight
mov     r8, #0
str     r8, [r7]

cmp     r4, #992
bne     nextStep
// Load the map number
ldr     r7, =mapNumber
ldr     r8, [r7]
add     r8, #1
cmp     r8, #2
beq     GoToTheSecondMap
cmp     r8, #3
beq     GoToTheThirdMap
cmp     r8, #4
beq     Stop

//////////////////////////
// Load the map number
nextStep:
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap8
cmp     r8, #2
beq     LoadSecondMap8
cmp     r8, #3
beq     LoadThirdMap8
bl      quitGame
LoadFirstMap8:
ldr     r7, =FirstMap
b       continueNext8
LoadSecondMap8:
ldr     r7, =SecondMap
b       continueNext8
LoadThirdMap8:
ldr     r7, =ThirdMap

continueNext8:
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
sub     r12, #1
ldrb    r10, [r7, r12]  //load the cell color which mario stand

cmp     r11, #251
beq     marioDie
cmp     r11, #252
beq     marioDie
cmp     r11, #27
beq     marioDie
cmp     r11, #28
beq     marioDie
cmp     r11, #40
bleq    marioBonus


cmp     r11, #67
beq     MarioWinTheGame
cmp     r11, #45
beq     exit2
cmp     r11, #5
beq     exit2
cmp     r11, #30
beq     exit2
cmp     r11, #6
beq     exit2
cmp     r11, #8
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
ldr     r7, =marioXPosition
str     r4, [r7]
ldr     r8, =marioYPosition
str     r5, [r8]

cmp     r5, #736
beq     RestartTheGame
// Load the map number
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap9
cmp     r8, #2
beq     LoadSecondMap9
cmp     r8, #3
beq     LoadThirdMap9
bl      quitGame
LoadFirstMap9:
ldr     r7, =FirstMap
b       continueNext9
LoadSecondMap9:
ldr     r7, =SecondMap
b       continueNext9
LoadThirdMap9:
ldr     r7, =ThirdMap

continueNext9:
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
bl      LivesShowingOnTheScreen
// Load the map number
ldr     r7, =mapNumber
mov     r8, #1
str     r8, [r7]
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
bl      resetMap
ldr   r0, =enterTheGameCheck
mov   r1, #1
str   r1, [r0]

bl      drawIntroduction
bl      drawIndicatorAtStart
bl      controller

// Exit when mario landed on the ground
exit2:
ldr     r7, =marioXPosition
str     r4, [r7]
ldr     r8, =marioYPosition
str     r5, [r8]
ldr     r6, =MarioRightStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture4
bl      controller1
pop     {lr}
bx      lr

marioJumpOnTurtle:
bl      scoreShowingOnTheScreen
add     r12, #32
mov     r0, #2
// Load the map number
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap41
cmp     r8, #2
beq     LoadSecondMap41
cmp     r8, #3
beq     LoadThirdMap41
bl      quitGame
LoadFirstMap41:
ldr     r1, =FirstMap
b       continueNext41
LoadSecondMap41:
ldr     r1, =SecondMap
b       continueNext41
LoadThirdMap41:
ldr     r1, =ThirdMap

continueNext41:
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
beq     marioFallRight2


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

ldr     r6, =marioJumpRightPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationJumpRight12

marioFallRight2:
mov     r0, r5
add     r0, #96
fall7:
cmp     r0, r5
beq     turtleDieRight1
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #2    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpRightPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       fall7

turtleDieRight1:
ldr     r6, =MarioRightStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
ldr     r7, =TurtleXPosition
ldr     r6, [r7]
add     r6, #32
str     r6, [r7]
checkTurtleDieRight1:
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
b       checkTurtleDieRight1


marioJumpOnMushroom:
bl      scoreShowingOnTheScreen
add     r12, #32
mov     r0, #2
// Load the map number
ldr     r7, =mapNumber
ldr     r8, [r7]
cmp     r8, #1
beq     LoadFirstMap10
cmp     r8, #2
beq     LoadSecondMap10
cmp     r8, #3
beq     LoadThirdMap10
bl      quitGame
LoadFirstMap10:
ldr     r1, =FirstMap
b       continueNext10
LoadSecondMap10:
ldr     r1, =SecondMap
b       continueNext10
LoadThirdMap10:
ldr     r1, =ThirdMap

continueNext10:
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
beq     marioFallRight12


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

ldr     r6, =marioJumpRightPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationJumpRight1

marioFallRight12:
mov     r0, r5
add     r0, #96
fall12:
cmp     r0, r5
beq     exit12
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r5, #2    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =marioJumpRightPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       fall12

// Exit when mario landed on the ground
exit12:
ldr     r6, =MarioRightStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture

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

Stop:
ldr     r6, =MarioRightStand
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
bl      controller1

pop     {lr}
bx      lr

// When mario win, reset all the game status
MarioWinTheGame:
ldr     r7, =MarioWin  //1 stand for win
mov     r8, #1
str     r8, [r7]

ldr     r7, =lives
mov     r8, #4
str     r8, [r7]

ldr     r7, =scores
mov     r8, #0
str     r8, [r7]

ldr     r7, =scores
mov     r8, #0
str     r8, [r7, #4]

ldr     r7, =scores
mov     r8, #0
str     r8, [r7, #8]

ldr     r7, =scores
mov     r8, #0
str     r8, [r7, #12]

ldr     r7, =coinNumber
mov     r8, #0
str     r8, [r7]

ldr     r7, =coinNumber
mov     r8, #0
str     r8, [r7, #4]

ldr   r4, =0    // Starting postion for x
ldr   r5, =0    // Starting postion for y
ldr   r6, =winPicture    // Load the address of "Intro" in "data.s"
ldr   r7, =1024   // Width of the picture
ldr   r8, =768    // Height of the picture

bl    drawPicture

bl      RestartTheGameWhenWin
RestartTheGameWhenWin:
// Load the map number
ldr     r7, =mapNumber
mov     r8, #1
str     r8, [r7]
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
bl      resetMap
ldr   r0, =enterTheGameCheck
mov   r1, #1
str   r1, [r0]
bl      drawIntroduction
bl      drawIndicatorAtStart
bl      controller
