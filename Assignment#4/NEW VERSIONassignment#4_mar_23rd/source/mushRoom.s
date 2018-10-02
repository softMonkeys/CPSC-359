.section    .text
.global     drawMushRoom
drawMushRoom:

push  {r0-r12, lr}

ldr     r0, =checkMushroomDeath
ldr     r0, [r0]
cmp     r0, #0
beq     exit



ldr     r7, =FirstMap
ldr     r8, =mushRoomXPosition
ldr     r4, [r8]
ldr     r9, =mushRoomYPosition
ldr     r5, [r9]
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

mov     r2, r12


ldr     r0, =checkMushroomTurn
ldr     r0, [r0]
cmp     r0, #0
bne     mushRoomTurnAround

cmp     r11, #46
beq     mushRoomTurnAround
//cmp     r11, #32
//beq     marioMoveToTheNextCellPlant32
//cmp     r11, #33
//beq     marioMoveToTheNextCellPlant33
//cmp     r11, #46
//beq     exit

mov     r0, #2
ldr     r8, =FirstMap
strb    r0, [r8, r12]
sub     r12, #1
mov     r0, #251
strb    r0, [r8, r12]


ldr     r6, =mushRoomXPosition
ldr     r12, [r6]
mov     r0, r12
sub     r0, #32

//str     r0, [r6]
mushMovingLeft:
cmp     r0, r12
beq     exit
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture2
sub     r12, #2    // the mario will move at 2 pixel/time in order to generate smooth movement
ldr     r6, =mushRoomXPosition
str     r12, [r6]

ldr     r6, =mushRoomLeftPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture2
b       mushMovingLeft



mushRoomTurnAround:

ldr     r7, =FirstMap
ldr     r8, =mushRoomXPosition
ldr     r4, [r8]
ldr     r9, =mushRoomYPosition
ldr     r5, [r9]
cmp     r4, #992
beq     drawMushRoom1
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

stop:
sub     r12, #1                               // FIXXXXXXXXXXXXXXXXXXXXXXXX
mov     r0, #2
ldr     r8, =FirstMap
strb    r0, [r8, r12]

add     r12, #1
mov     r0, #252
strb    r0, [r8, r12]



ldr     r1, =checkMushroomTurn
ldr     r0, [r1]
mov     r0, #1
str     r0, [r1]


ldr     r6, =mushRoomXPosition
ldr     r12, [r6]
mov     r0, r12
add     r0, #32


mushMovingRight:
cmp     r0, r12
beq     exit
ldr     r6, =Sky
ldr     r7, =32
ldr     r8, =32
bl      drawPicture2
add     r12, #2    // the mario will move at 2 pixel/time in order to generate smooth movement
ldr     r6, =mushRoomXPosition
str     r12, [r6]

ldr     r6, =mushRoomRightPicture
ldr     r7, =32
ldr     r8, =32

bl      drawPicture2
b       mushMovingRight


exit:
pop     {r0-r12, lr}
bx      lr

drawMushRoom1:
ldr     r1, =checkMushroomTurn
ldr     r0, [r1]
mov     r0, #0
str     r0, [r1]
b       exit
