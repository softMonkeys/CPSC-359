.section    .text
.global     StartGame

StartGame:
  push  {r4-r8, lr}
  bl    drawFirstMap
  bl    drawMario
  bl    controller1



  pop   {r4-r8, lr}
  mov   pc, lr

.global   quitGame

quitGame:
push  {r0-r8, lr}
// Draw the introduction screen
ldr   r4, =0    // Starting postion for x
ldr   r5, =0    // Starting postion for y
mov   r6, #0    //black color
ldr   r7, =1024   // Width of the picture
ldr   r8, =768    // Height of the picture

Looping:
	mov	r0,	r4			//Setting x
	mov	r1,	r5			//Setting y
	mov	r2,	r6			//setting pixel color
	push {lr}
	bl	DrawPixel
	pop {lr}
	add	r4,	#1			//increment x by 1
	cmp	r4,	r7			//compare with width
	blt	Looping
	mov	r4,	#0			//reset x
	add	r5,	#1			//increment Y by 1
	cmp	r5,	r8			//compare with height
	blt	Looping


quitLoop:
b     quitLoop

pop   {r0-r8, lr}
bx    lr
