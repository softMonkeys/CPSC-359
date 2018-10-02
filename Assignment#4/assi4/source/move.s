
.section .text

/*
 * move tetrimino to the left
 */
.global moveLeft
moveLeft:
push {r4-r10,lr}
x .req r0
y .req r1
kind .req r2

ldr r4, =currentTetrimino

mov r9, #0
moveLeftLoop:
ldrb x, [r4,r9]
sub x, #1
strb x, [r4,r9]
add r9, #2

cmp r9, #8
blt moveLeftLoop

.unreq x
.unreq y
.unreq kind
pop {r4-r10,lr}
mov pc, lr

/*
 * move tetrimino to the right
 */
.global moveRight
moveRight:
push {r4-r10,lr}
x .req r0
y .req r1
kind .req r2

ldr r4, =currentTetrimino

mov r9, #0
moveRightLoop:
ldrb x, [r4,r9]
add x, #1
strb x, [r4,r9]
add r9, #2

cmp r9, #8
blt moveRightLoop

.unreq x
.unreq y
.unreq kind
pop {r4-r10,lr}
mov pc, lr

/*
 * move tetrimino down
 */
.global moveDown
moveDown:
push {r4-r10,lr}
x .req r0
y .req r1
kind .req r2

ldr r4, =currentTetrimino

mov r9, #1
moveDownLoop:
ldrb y, [r4,r9]
add  y, #1
strb y, [r4,r9]
add r9, #2

cmp r9, #8
blt moveDownLoop

.unreq x
.unreq y
.unreq kind
pop {r4-r10,lr}
mov pc, lr

/*
 * rotate tetrimino up
 */
.global rotateUp
rotateUp:
push {r4-r10,lr}
x .req r0
y .req r1
kind .req r2
ldr r4, =currentTetrimino

ldrb kind, [r4,#8]
type1_up:
cmp kind, #1
bne type2_up
bl type1_rotateUp
b next_rotateUp

type2_up:
cmp kind, #2
bne type3_up
bl type2_rotateUp
b next_rotateUp

type3_up:
cmp kind, #3
bne type4_up
bl type3_rotateUp
b next_rotateUp

type4_up:
cmp kind, #4
bne type5_up
bl type4_rotateUp
b next_rotateUp

type5_up:
cmp kind, #5
bne type6_up
b next_rotateUp

type6_up:
cmp kind, #6
bne type7_up
bl type6_rotateUp
b next_rotateUp

type7_up:
cmp kind, #7
bne next_rotateUp
bl type7_rotateUp
b next_rotateUp

next_rotateUp:
.unreq x
.unreq y
.unreq kind
pop {r4-r10,lr}
mov pc, lr

.global rotateDown
rotateDown:
push {r4-r10,lr}
x .req r0
y .req r1
kind .req r2
ldr r4, =currentTetrimino

ldrb kind, [r4,#8]
type1_down:
cmp kind, #1
bne type2_down
bl type1_rotateDown
b next_rotateDown

type2_down:
cmp kind, #2
bne type3_down
bl type2_rotateDown
b next_rotateDown

type3_down:
cmp kind, #3
bne type4_down
bl type3_rotateDown
b next_rotateDown

type4_down:
cmp kind, #4
bne type5_down
bl type4_rotateDown
b next_rotateDown

type5_down:
cmp kind, #5
bne type6_down
b next_rotateDown

type6_down:
cmp kind, #6
bne type7_down
bl type6_rotateDown
b next_rotateDown

type7_down:
cmp kind, #7
bne next_rotateDown
bl type7_rotateDown
b next_rotateDown

next_rotateDown:
.unreq x
.unreq y
.unreq kind
pop {r4-r10,lr}
mov pc, lr
