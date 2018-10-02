.section  .text

.global   drawMario
drawMario:

push    {r6-r8, lr}

ldr     r4, =0    // Starting postion for x
ldr     r5, =608    // Starting postion for y
ldr     r6, =MarioRigntStand   // Load the address of "MarioRigntStand" in "data.s"
ldr     r7, =32  // Width of the picture
ldr     r8, =32   // Height of the picture

bl      drawPicture

pop     {r6-r8, lr}
bx      lr

.global   marioJump
marioJump:

push    {lr}
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
add     r8, #1
udiv    r8, r5, r10
udiv    r9, r4, r10
mul     r12, r8, r10
mov     r0, #1
mul     r12, r0
mul     r0, r9, r0
add     r12, r0   //get the offset in front of mario from the FirstMap
ldrb    r11, [r7, r12]    //load the cell color in top of mario
mov     r12, #0
mov     r0, #1
mul     r0, r9, r0
sub     r8, #1
mul     r12, r8, r10
mov     r10, #1
mul     r12, r10
add     r12, r0   //get the offset which mario stand
ldrb    r10, [r7, r12]  //load the cell color which mario stand

cmp     r11, #6
//beq     marioHitBox
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

marioHitBlock:

mov     r3, #32
sub     r1, #1
mul     r1, r1, r3
mov     r0, r5
add     r0, r0, r1

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
ldr     r6, =MarioRigntStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture

bl      controller1

pop     {lr}
bx      lr







.global   marioWalkBackward
marioWalkBackward:

push    {lr}
ldr     r7, =FirstMap
mov     r8, #0    //r8 is row index for FirstMap
mov     r9, #0    //r9 is column index for FirstMap
mov     r10, #32    //r10 is the width and height for a cell
mov     r12, #0   //r12 is the offset of the FirstMap
mov     r0, #1    //r0 is offset for byte
mov     r1, #0    //r1 is a temp value
udiv    r8, r5, r10
udiv    r9, r4, r10
sub     r9, #1
mul     r12, r8, r10
mul     r12, r0
mul     r1, r9, r0
add     r12, r1   //get the offset in front of mario from the FirstMap
ldrb    r11, [r7, r12]    //load the cell color in back of mario
add     r9, #1
mov     r12, #0
mul     r1, r9, r0
mul     r12, r8, r10
mul     r12, r0
add     r12, r1   //get the offset which mario stand
ldrb    r10, [r7, r12]  //load the cell color which mario stand


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
beq     exit1
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

exit1:
bl      controller1
pop     {lr}
bx      lr


.global   marioWalkForward
marioWalkForward:

push    {lr}
ldr     r7, =FirstMap
mov     r8, #0    //r8 is row index for FirstMap
mov     r9, #0    //r9 is column index for FirstMap
mov     r10, #32    //r10 is the width and height for a cell
mov     r12, #0   //r12 is the offset of the FirstMap
mov     r0, #1    //r0 is offset for byte
mov     r1, #0    //r1 is a temp value
udiv    r8, r5, r10
udiv    r9, r4, r10
add     r9, #1
mul     r12, r8, r10
mul     r12, r0
mul     r1, r9, r0
add     r12, r1   //get the offset in front of mario from the FirstMap
ldrb    r11, [r7, r12]    //load the cell color in front of mario
sub     r9, #1
mov     r12, #0
mul     r1, r9, r0
mul     r12, r8, r10
mul     r12, r0
add     r12, r1   //get the offset which mario stand
ldrb    r10, [r7, r12]  //load the cell color which mario stand


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
beq     exit2
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
add     r4, #2    // the mario will move at 2 pixel/time in order to generate smooth movement

ldr     r6, =MarioRigntStand
ldr     r7, =32
ldr     r8, =32

bl      drawPicture
b       movingAnimationRight

exit2:
bl      controller1
pop     {lr}
bx      lr
