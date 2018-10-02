
.section .text



.global StartGame

StartGame:
  push  {r4-r8,lr}
  bl  clearScreen
  bl drawCurrentGameScreen

  bl random
  bl generate
  bl upDateGenerate
  bl cmpDrawScreen

  bl drawScore

  bl copyState
  bl copyTetrimino
  bl controller2

  pop   {r4-r8,lr}
  mov   pc, lr

.global QuitGame

QuitGame:

bl  clearScreen
bl GameEnd





.global win
win:
push  {r4-r8,lr}
ldr	  r4,	= 340	//Start X position of your picture
ldr	  r5,	= 300
ldr	  r6,	= picGameWon			//Address of the picture
ldr	  r7,	= 300			//Width of your picture
ldr	  r8,	= 160
bl    drawPicture
bl    controller3
pop   {r4-r8,lr}
mov   pc, lr

.global lose
lose:
push  {r4-r8,lr}
ldr	  r4,	= 350	//Start X position of your picture
ldr	  r5,	= 300
ldr	  r6,	= picGameOver			//Address of the picture
ldr	  r7,	= 300			//Width of your picture
ldr	  r8,	= 135
bl    drawPicture
bl    controller3
pop   {r4-r8,lr}
mov   pc, lr

.global reStart
reStart:
bl    initAllState
bl    clearScreen
bl    drawMainMenu
bl    drawPointerStartM
bl    controller
.global GameEnd
GameEnd:

stop:
      b stop
