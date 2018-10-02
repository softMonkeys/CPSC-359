

.section .text

.global drawMainMenu

drawMainMenu:
push  {r4-r8,lr}
ldr	  r4,	= 300	//Start X position of your picture
ldr	  r5,	= 250
ldr	  r6,	= Tetris			//Address of the picture
ldr	  r7,	= 400			//Width of your picture
ldr	  r8,	= 60

bl    drawPicture

ldr	  r4,	= 360	//Start X position of your picture
ldr	  r5,	= 340
ldr	  r6,	= Creator			//Address of the picture
ldr	  r7,	= 250			//Width of your picture
ldr	  r8,	= 30

bl    drawPicture

ldr	  r4,	= 330	//Start X position of your picture
ldr	  r5,	= 385
ldr	  r6,	= Name			//Address of the picture
ldr	  r7,	= 310			//Width of your picture
ldr	  r8,	= 30

bl    drawPicture

ldr	  r4,	= 410	//Start X position of your picture
ldr	  r5,	= 485
ldr	  r6,	= Start			//Address of the picture
ldr	  r7,	= 150			//Width of your picture
ldr	  r8,	= 30

bl    drawPicture

ldr	  r4,	= 425	//Start X position of your picture
ldr	  r5,	= 550
ldr	  r6,	= Quit			//Address of the picture
ldr	  r7,	= 120			//Width of your picture
ldr	  r8,	= 30

bl    drawPicture

pop   {r4-r8,lr}
mov   pc, lr

.global drawPointerStartM
drawPointerStartM:
push   {r4-r8,lr}

ldr	  r4,	= 360	//Start X position of your picture
ldr	  r5,	= 485
ldr	  r6,	= Pointer			//Address of the picture
ldr	  r7,	= 35			//Width of your picture
ldr	  r8,	= 35

bl    drawPicture

pop   {r4-r8,lr}
mov   pc, lr

.global clearPointerStartM
clearPointerStartM:
push   {r4-r8,lr}

ldr	  r4,	= 360	//Start X position of your picture
ldr	  r5,	= 485
ldr	  r6,	= PointerClear			//Address of the picture
ldr	  r7,	= 35			//Width of your picture
ldr	  r8,	= 35

bl    drawPicture

pop   {r4-r8,lr}
mov   pc, lr

.global drawPointerQuitM
drawPointerQuitM:
push   {r4-r8,lr}

ldr	  r4,	= 360	//Start X position of your picture
ldr	  r5,	= 550
ldr	  r6,	= Pointer			//Address of the picture
ldr	  r7,	= 35			//Width of your picture
ldr	  r8,	= 35

bl    drawPicture

pop   {r4-r8,lr}
mov   pc, lr

.global clearPointerQuitM
clearPointerQuitM:
push   {r4-r8,lr}

ldr	  r4,	= 360	//Start X position of your picture
ldr	  r5,	= 550
ldr	  r6,	= PointerClear			//Address of the picture
ldr	  r7,	= 35			//Width of your picture
ldr	  r8,	= 35

bl    drawPicture

pop   {r4-r8,lr}
mov   pc, lr

.global drawBlackCell
drawBlackCell:
push   {r6-r8,lr}

ldr	  r6,	= blackCell
ldr	  r7,	= 32
ldr	  r8,	= 32

bl    drawPicture

pop   {r6-r8,lr}
mov   pc, lr

.global drawYellowCell
drawYellowCell:
push   {r6-r8,lr}

ldr	  r6,	= yellowCell
ldr	  r7,	= 32
ldr	  r8,	= 32

bl    drawPicture

pop   {r6-r8,lr}
mov   pc, lr

.global drawWhiteCell
drawWhiteCell:
push   {r6-r8,lr}

ldr	  r6,	= whiteCell
ldr	  r7,	= 32
ldr	  r8,	= 32

bl    drawPicture

pop   {r6-r8,lr}
mov   pc, lr

.global drawBlueCell
drawBlueCell:
push   {r6-r8,lr}

ldr	  r6,	= blueCell
ldr	  r7,	= 32
ldr	  r8,	= 32

bl    drawPicture

pop   {r6-r8,lr}
mov   pc, lr

.global drawGreenCell
drawGreenCell:
push   {r6-r8,lr}

ldr	  r6,	= greenCell
ldr	  r7,	= 32
ldr	  r8,	= 32

bl    drawPicture

pop   {r6-r8,lr}
mov   pc, lr

.global drawPinkCell
drawPinkCell:
push   {r6-r8,lr}

ldr	  r6,	= pinkCell
ldr	  r7,	= 32
ldr	  r8,	= 32

bl    drawPicture

pop   {r6-r8,lr}
mov   pc, lr

.global drawOrangeCell
drawOrangeCell:
push   {r6-r8,lr}

ldr	  r6,	= orangeCell
ldr	  r7,	= 32
ldr	  r8,	= 32

bl    drawPicture

pop   {r6-r8,lr}
mov   pc, lr

.global drawPurpleCell
drawPurpleCell:
push   {r6-r8,lr}

ldr	  r6,	= purpleCell
ldr	  r7,	= 32
ldr	  r8,	= 32

bl    drawPicture

pop   {r6-r8,lr}
mov   pc, lr

.global drawRedCell
drawRedCell:
push   {r6-r8,lr}

ldr	  r6,	= redCell
ldr	  r7,	= 32
ldr	  r8,	= 32

bl    drawPicture

pop   {r6-r8,lr}
mov   pc, lr

.global cmpDrawScreen
cmpDrawScreen:
push {r4-r10,lr}
offset .req r6
ldr  r7, =684
ldr  r8, =752


/*drawPicture
 * r4 - x
 * r5 - y
 * r6 - Address of the picture
 * r7 - Width of your picture
 * r8 - Height of your picture
 */
 mov r6, #0
 mov r4, #300
 mov r5, #80
cmpDrawScreenLoop:
ldr  r2, =currentGameState
ldr  r0, =preGameState
ldrb r1, [r2,offset]
ldrb r3, [r0,offset]
cmp  r1, r3
beq  next_c

black_c:
cmp r1, #0
bne yellow_c
bl drawBlackCell
b next_c

yellow_c:
cmp r1, #1
bne blue_c
bl drawYellowCell
b next_c

blue_c:
cmp r1, #2
bne green_c
bl drawBlueCell
b next_c

green_c:
cmp r1, #3
bne pink_c
bl drawGreenCell
b next_c

pink_c:
cmp r1, #4
bne orange_c
bl drawPinkCell
b next_c

orange_c:
cmp r1, #5
bne purple_c
bl drawOrangeCell
b next_c

purple_c:
cmp r1, #6
bne red_c
bl drawPurpleCell
b next_c

red_c:
cmp r1, #7
bne white_c
bl drawRedCell
b next_c

white_c:
cmp r1, #8
bne next_c
bl drawWhiteCell

next_c:

add offset, #1
add	r4,	#32			//increment x position
cmp	r4,	r7			//compare with image with
blt cmpDrawScreenLoop
mov	r4,	#300			//reset x
add	r5,	#32			//increment Y
cmp	r5,	r8			//compare y with image height
blt cmpDrawScreenLoop

.unreq offset
pop    {r4-r10,lr}
mov	pc,	lr			//return



.global drawCurrentGameScreen
drawCurrentGameScreen:
push {r4-r10,lr}
offset .req r6
ldr  r7, =684
ldr  r8, =752


/*drawPicture
 * r4 - x
 * r5 - y
 * r6 - Address of the picture
 * r7 - Width of your picture
 * r8 - Height of your picture
 */
 mov r6, #0
 mov r4, #300
 mov r5, #80
drawScreenLoop:
ldr  r0, =currentGameState
ldrb r1, [r0,offset]

black:
cmp r1, #0
bne yellow
bl drawBlackCell
b next

yellow:
cmp r1, #1
bne white
bl drawYellowCell
b next

white:
cmp r1, #8
bne next
bl drawWhiteCell

next:

add offset, #1
add	r4,	#32			//increment x position
cmp	r4,	r7			//compare with image with
blt	drawScreenLoop
mov	r4,	#300			//reset x
add	r5,	#32			//increment Y
cmp	r5,	r8			//compare y with image height
blt	drawScreenLoop

.unreq offset
pop    {r4-r10,lr}
mov	pc,	lr			//return
