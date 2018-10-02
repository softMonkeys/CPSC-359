// This file will draw the game maps
.global drawFirstMap
drawFirstMap:
push  {lr}

ldr   r4, =0    // Starting postion for x
ldr   r5, =0    // Starting postion for y
ldr   r11, =FirstMap
ldr   r9, =endFirstMap

drawLoop:

ldrb  r12, [r11], #1

cmp   r12, #1
beq   drawFloor
cmp   r12, #2
beq   drawSky
cmp   r12, #31
beq   drawplant31
cmp   r12, #32
beq   drawplant32
cmp   r12, #33
beq   drawplant33
cmp   r12, #41
beq   drawTube41
cmp   r12, #42
beq   drawTube42
cmp   r12, #43
beq   drawTube43
cmp   r12, #44
beq   drawTube44
cmp   r12, #45
beq   drawTube45
cmp   r12, #46
beq   drawTube46
cmp   r12, #5
beq   drawBlock
cmp   r12, #6
beq   drawBox
cmp   r12, #71
beq   drawCloud71
cmp   r12, #72
beq   drawCloud72
cmp   r12, #73
beq   drawCloud73
cmp   r12, #74
beq   drawCloud74

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop
b     exit

// Draw the 32x32 "Block" cell
drawBlock:
ldr   r6, =Block    // Load the address of "Block" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Box" cell
drawBox:
ldr   r6, =Box    // Load the address of "Box" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Cloud71" cell
drawCloud71:
ldr   r6, =Cloud71    // Load the address of "Cloud71" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Cloud72" cell
drawCloud72:
ldr   r6, =Cloud72    // Load the address of "Cloud72" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Cloud73" cell
drawCloud73:
ldr   r6, =Cloud73    // Load the address of "Cloud73" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Cloud74" cell
drawCloud74:
ldr   r6, =Cloud74    // Load the address of "Cloud74" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Tube41" cell
drawTube41:
ldr   r6, =Tube41    // Load the address of "Tube41" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Tube42" cell
drawTube42:
ldr   r6, =Tube42    // Load the address of "Tube42" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Tube43" cell
drawTube43:
ldr   r6, =Tube43    // Load the address of "Tube43" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Tube44" cell
drawTube44:
ldr   r6, =Tube44    // Load the address of "Tube44" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Tube45" cell
drawTube45:
ldr   r6, =Tube45    // Load the address of "Tube45" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Tube46" cell
drawTube46:
ldr   r6, =Tube46    // Load the address of "Tube46" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Plant33" cell
drawplant33:
ldr   r6, =Plant33    // Load the address of "Plant33" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Plant32" cell
drawplant32:
ldr   r6, =Plant32    // Load the address of "Plant32" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Plant31" cell
drawplant31:
ldr   r6, =Plant31    // Load the address of "Plant31" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Sky" cell
drawSky:
ldr   r6, =Sky    // Load the address of "Sky" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

// Draw the 32x32 "Floor" cell
drawFloor:
ldr   r6, =Floor    // Load the address of "Floor" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop

exit:
pop   {lr}
mov   pc, lr
