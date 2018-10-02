
.section .text

.global pause
pause:
push {r4-r10,lr}

ldr	  r4,	= 410	//Start X position of your picture
ldr	  r5,	= 330
ldr	  r6,	= picReStart			//Address of the picture
ldr	  r7,	= 210			//Width of your picture
ldr	  r8,	= 30

bl    drawPicture

ldr	  r4,	= 425	//Start X position of your picture
ldr	  r5,	= 395
ldr	  r6,	= Quit			//Address of the picture
ldr	  r7,	= 120			//Width of your picture
ldr	  r8,	= 30

bl    drawPicture

bl    drawPointerStartP

bl    controller4

pop {r4-r10,lr}
mov pc,lr

.global drawPointerStartP
drawPointerStartP:
push   {r4-r8,lr}

ldr	  r4,	= 360	//Start X position of your picture
ldr	  r5,	= 330
ldr	  r6,	= Pointer			//Address of the picture
ldr	  r7,	= 35			//Width of your picture
ldr	  r8,	= 35

bl    drawPicture

pop   {r4-r8,lr}
mov   pc, lr

.global clearPointerStartP
clearPointerStartP:
push   {r4-r8,lr}

ldr	  r4,	= 360	//Start X position of your picture
ldr	  r5,	= 330
ldr	  r6,	= PointerClear			//Address of the picture
ldr	  r7,	= 35			//Width of your picture
ldr	  r8,	= 35

bl    drawPicture

pop   {r4-r8,lr}
mov   pc, lr

.global drawPointerQuitP
drawPointerQuitP:
push   {r4-r8,lr}

ldr	  r4,	= 360	//Start X position of your picture
ldr	  r5,	= 395
ldr	  r6,	= Pointer			//Address of the picture
ldr	  r7,	= 35			//Width of your picture
ldr	  r8,	= 35

bl    drawPicture

pop   {r4-r8,lr}
mov   pc, lr

.global clearPointerQuitP
clearPointerQuitP:
push   {r4-r8,lr}

ldr	  r4,	= 360	//Start X position of your picture
ldr	  r5,	= 395
ldr	  r6,	= PointerClear			//Address of the picture
ldr	  r7,	= 35			//Width of your picture
ldr	  r8,	= 35

bl    drawPicture

pop   {r4-r8,lr}
mov   pc, lr
