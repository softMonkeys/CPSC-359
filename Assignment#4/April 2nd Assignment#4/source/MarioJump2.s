////////////////////////////////////
.global marioJump2
marioJump2:
  // The mario starts to jump
  mov     r1, #0
  start2:
  add     r1, #1
  cmp     r1, #8    // he will jump 32 pixel X 8 cells
  beq     marioFallLeft    // if mario reach the 32 pixel X 8 cells, he fall down
  // Load the map number to check where is mario located
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
  // Calculate the offset
  continueNext2:
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
  beq     marioHitBoxAlready2
  cmp     r11, #6
  beq     marioHitBox2
  cmp     r11, #5
  beq     marioHitBlock2

  // if on top of mario is sky, mario starts to jump
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

  // Mario starts to fall
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

  // This is the condition when mario hit a box
  marioHitBox2:
  // Load the map number to determine which map is mario located
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

  marioHitBoxAlready2:

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
  mov     r3, #8
  strb    r3, [r7, r2]

  mov     r3, #32
  sub     r1, #1
  mul     r1, r1, r3
  mov     r0, r5
  add     r0, r0, r1

  // This fall1 is for mario hiited an object on his way of jumping
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

  // Exit when mario landed on the ground
  exit4:
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

  // Mario hit a block already
  marioHitBlock2:
  mov     r3, #32
  sub     r1, #1
  mul     r1, r1, r3
  mov     r0, r5
  add     r0, r0, r1
  sub     r5, #32
  ldr     r6, =Sky
  ldr     r7, =32
  ldr     r8, =32
  bl      drawPicture

  // Load the map number to determine which map is mario located
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
  ldr     r7, =FirstMap
  b       continueNext4
  LoadSecondMap4:
  ldr     r7, =SecondMap
  b       continueNext4
  LoadThirdMap4:
  ldr     r7, =ThirdMap
  continueNext4:
  mov     r3, #2
  strb    r3, [r7, r2]
  add     r5, #32
  //////////////////////////////
  // Mario fall
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
  // Exit when mario landed on the ground
  exit5:
  ldr     r6, =MarioLeftStand
  ldr     r7, =32
  ldr     r8, =32
  bl      drawPicture
  bl      controller1
  pop     {lr}
  bx      lr
