.section .text
.global  resetMap
resetMap:
push    {r0-r12, lr}
ldr     r4, =checkMushroomDeath
ldr     r5, [r4]
mov     r5, #1
str     r5, [r4]



ldr     r4, =mushRoomXPosition
ldr     r5, [r4]
mov     r5, #704
str     r5, [r4]
ldr     r4, =mushRoomYPosition
ldr     r5, [r4]
mov     r5, #608
str     r5, [r4]


ldr     r4, =0    // Starting postion for x
ldr     r5, =0    // Starting postion for y

ldr     r0, =FirstMap
ldr     r1, =FirstMapCopy

Loop:
ldrb    r2, [r1], #1
strb    r2, [r0], #1




add   r4, #32
cmp   r4, #992
blt   Loop
mov   r4, #0
add   r5, #32
cmp   r5, #736
blt   Loop







pop     {r0-r12, lr}
bx      lr
