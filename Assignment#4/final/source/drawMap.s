.section  .text
// This file will draw the game maps
.global drawFirstMap
drawFirstMap:
push  {r0-r12, lr}

ldr   r4, =0    // Starting postion for x
ldr   r5, =0    // Starting postion for y
ldr   r11, =FirstMap

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
cmp   r12, #101
beq   drawmarioNameM
cmp   r12, #102
beq   drawmarioNameA
cmp   r12, #103
beq   drawmarioNameR
cmp   r12, #104
beq   drawmarioNameI
cmp   r12, #105
beq   drawmarioNameO
cmp   r12, #13
beq   drawnumberZero
cmp   r12, #14
beq   drawnumberOne
cmp   r12, #23
beq   drawCoin
cmp   r12, #12
beq   drawX
cmp   r12, #111
beq   drawWorldW
cmp   r12, #112
beq   drawWorldO
cmp   r12, #113
beq   drawWorldR
cmp   r12, #114
beq   drawWorldL
cmp   r12, #115
beq   drawWorldD
cmp   r12, #24
beq   drawStraightLine
cmp   r12, #91
beq   drawLive1
cmp   r12, #92
beq   drawLive2
cmp   r12, #93
beq   drawLive3
cmp   r12, #94
beq   drawLive4
cmp   r12, #95
beq   drawLive5
cmp   r12, #251
beq   drawMushRoomPicture
cmp   r12, #30
beq   drawBlock2
cmp   r12, #40
beq   drawBonus2
cmp   r12, #8
beq   drawBoxHit



add   r4, #32
cmp   r4, #1024
blt   drawLoop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   drawLoop
b     exit

// Draw the 32x32 "mushRoom" cell
drawBoxHit:
ldr   r6, =BoxHit    // Load the address of "StraightLine" in "data.s"
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

// Draw the 32x32 "mushRoom" cell
drawBlock2:
ldr   r6, =Block2Picture    // Load the address of "StraightLine" in "data.s"
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

// Draw the 32x32 "StraightLine" cell
drawBonus2:
ldr   r6, =Bonus2Picture    // Load the address of "StraightLine" in "data.s"
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

// Draw the 32x32 "mushRoom" cell
drawMushRoomPicture:
ldr   r6, =mushRoomLeftPicture    // Load the address of "StraightLine" in "data.s"
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

// Draw the 32x32 "StraightLine" cell
drawStraightLine:
ldr   r6, =StraightLine    // Load the address of "StraightLine" in "data.s"
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

// Draw the 32x32 "numberOne" cell
drawnumberOne:
ldr   r6, =numberOne    // Load the address of "numberOne" in "data.s"
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

// Draw the 32x32 "Live1" cell
drawLive1:
ldr   r6, =Live1    // Load the address of "Live1" in "data.s"
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

// Draw the 32x32 "Live2" cell
drawLive2:
ldr   r6, =Live2    // Load the address of "Live2" in "data.s"
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

// Draw the 32x32 "Live3" cell
drawLive3:
ldr   r6, =Live3    // Load the address of "Live3" in "data.s"
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

// Draw the 32x32 "Live4" cell
drawLive4:
ldr   r6, =Live4    // Load the address of "Live4" in "data.s"
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

// Draw the 32x32 "Live5" cell
drawLive5:
ldr   r6, =Live5    // Load the address of "Live5" in "data.s"
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

// Draw the 32x32 "WorldW" cell
drawWorldW:
ldr   r6, =WorldW    // Load the address of "WorldW" in "data.s"
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

// Draw the 32x32 "WorldO" cell
drawWorldO:
ldr   r6, =WorldO    // Load the address of "WorldO" in "data.s"
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

// Draw the 32x32 "WorldR" cell
drawWorldR:
ldr   r6, =WorldR    // Load the address of "WorldR" in "data.s"
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

// Draw the 32x32 "WorldL" cell
drawWorldL:
ldr   r6, =WorldL    // Load the address of "WorldL" in "data.s"
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

// Draw the 32x32 "WorldD" cell
drawWorldD:
ldr   r6, =WorldD    // Load the address of "WorldD" in "data.s"
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

// Draw the 32x32 "coin" cell
drawCoin:
ldr   r6, =Coin    // Load the address of "Coin" in "data.s"
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

// Draw the 32x32 "X" cell
drawX:
ldr   r6, =Xsign    // Load the address of "Xsign" in "data.s"
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

// Draw the 32x32 "number" cell
drawnumberZero:
ldr   r6, =numberZero    // Load the address of "numberZero" in "data.s"
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

// Draw the 32x32 "mario" cell
drawmarioNameM:
ldr   r6, =marioNameM    // Load the address of "marioNameM" in "data.s"
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

// Draw the 32x32 "mario" cell
drawmarioNameA:
ldr   r6, =marioNameA    // Load the address of "marioNameA" in "data.s"
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

// Draw the 32x32 "mario" cell
drawmarioNameR:
ldr   r6, =marioNameR    // Load the address of "marioNameR" in "data.s"
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

// Draw the 32x32 "mario" cell
drawmarioNameI:
ldr   r6, =marioNameI    // Load the address of "marioNameI" in "data.s"
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

// Draw the 32x32 "mario" cell
drawmarioNameO:
ldr   r6, =marioNameO    // Load the address of "marioNameO" in "data.s"
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
pop   {r0-r12, lr}
mov   pc, lr
