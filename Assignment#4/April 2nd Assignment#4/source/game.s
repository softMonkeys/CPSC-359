.section    .text

// This subroutine will start the game and draw mario in the game map
.global     StartGame
StartGame:
  push  {r4-r8, lr}
  bl    drawFirstMap    // branch to drawFirstMap to draw the first map
  bl    drawCoinNumberOnTheScreen   // display the coin on the screen
  bl    drawScoreOnTheScreen    // display the score on the screen
  bl    drawLiveOnTheScreen   // display the live(s) on the screen
  bl    drawMario   // draw mario character

  // Update the enterTheGameCheck to status of game started
  ldr   r0, =enterTheGameCheck
  mov   r1, #0
  str   r1, [r0]

  // Update the callInterruptCheck to status of InterruptFuction has already been called
  ldr   r0, =callInterruptCheck
  ldr   r1, [r0]
  cmp   r1, #0
  bne   DontCallInterrupt
  bl    InterruptFuction    // call InterruptFuction to start counting the clock
  // Update to called
  ldr   r0, =callInterruptCheck
  mov   r1, #1
  str   r1, [r0]
DontCallInterrupt:    // next time when calling StartGame, InterruptFuction won't be called
  bl    controller1   // call game map controller subroutine
  pop   {r4-r8, lr}
  mov   pc, lr

// This subroutine will make the game end
.global   quitGame
quitGame:
push  {r0-r8, lr}
  // Draw the black screen
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
