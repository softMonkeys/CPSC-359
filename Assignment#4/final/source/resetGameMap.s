.section .text

// This subroutine will reset some status of the game
.global  resetMap
resetMap:
push    {r0-r12, lr}

// Rest the MarioWin condition, 1 - win; 0 - lose; 2 - default
ldr     r4, =MarioWin
mov     r5, #2
str     r5, [r7]

// Reset the mapNumber to map 1
ldr     r4, =mapNumber
ldr     r5, [r4]
mov     r5, #1
str     r5, [r4]

// Reset the checkMushroomDeath, 1 - alive; 0 - dead
ldr     r4, =checkMushroomDeath
ldr     r5, [r4]
mov     r5, #1
str     r5, [r4]

// Reset the checkTurtleDeath, 1 - alive; 0 - dead
ldr     r4, =checkTurtleDeath
ldr     r5, [r4]
mov     r5, #1
str     r5, [r4]

// Reset the mushroom's x position to default value
ldr     r4, =mushRoomXPosition
ldr     r5, [r4]
mov     r5, #704
str     r5, [r4]

// Reset the mushroom's y position to default value
ldr     r4, =mushRoomYPosition
ldr     r5, [r4]
mov     r5, #608
str     r5, [r4]

// Reset the turtle's x position to default value
ldr     r4, =TurtleXPosition
ldr     r5, [r4]
mov     r5, #992
str     r5, [r4]

// Reset the turtle's y position to default value
ldr     r4, =TurtleYPosition
ldr     r5, [r4]
mov     r5, #608
str     r5, [r4]

// Refresh the first map
ldr     r4, =0    // Starting postion for x
ldr     r5, =0    // Starting postion for y
ldr     r0, =FirstMap
ldr     r1, =FirstMapCopy
Loop:
ldrb    r2, [r1], #1
strb    r2, [r0], #1
add   r4, #32
cmp   r4, #1024
blt   Loop
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   Loop

// Refresh the second map
ldr     r4, =0    // Starting postion for x
ldr     r5, =0    // Starting postion for y
ldr     r0, =SecondMap
ldr     r1, =SecondMapCopy
Loop0:
ldrb    r2, [r1], #1
strb    r2, [r0], #1
add   r4, #32
cmp   r4, #1024
blt   Loop0
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   Loop0

// Refresh the third map
ldr     r4, =0    // Starting postion for x
ldr     r5, =0    // Starting postion for y
ldr     r0, =ThirdMap
ldr     r1, =ThirdMapCopy
Loop1:
ldrb    r2, [r1], #1
strb    r2, [r0], #1
add   r4, #32
cmp   r4, #1024
blt   Loop1
mov   r4, #0
add   r5, #32
cmp   r5, #768
blt   Loop1

// The end
pop     {r0-r12, lr}
bx      lr
