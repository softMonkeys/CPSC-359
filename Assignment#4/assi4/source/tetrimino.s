
.section .text


/*
 * randomly generate the information of a tetrimino
 * return the postion(x,y) of the tetrimino and the kind of tetrimino
 */
.global random
random:
push {r4-r10,lr}
x .req r0
y .req r1
kind .req r2
bl randomNumber
ldr r4, =0xfffffff8
bic r0, r4
mov r5, r0
cmp r5, #2
blt add2
b setX
add2:
add r5,#2

setX:
mov r6, r5


bl randomNumber
ldr r4, =0xfffffff8
bic r0, r4
mov r5, r0
cmp r5, #1
blt add1
b setKind
add1:
add r5,#1
setKind:
mov kind, r5
mov x,r6
mov y,#1

.unreq x
.unreq y
.unreq kind
pop {r4-r10,lr}
mov pc, lr

/*
 *
 */
.global generate
generate:
push {r4-r10,lr}
x .req r0
y .req r1
kind .req r2
style .req r3

ldr r4, =currentTetrimino

type1_generate:
cmp kind, #1
bne type2_generate
strb x, [r4,#0]
strb y, [r4,#1]

add x, #1
strb x, [r4,#2]
strb y, [r4,#3]

sub x, #2
strb x, [r4,#4]
strb y, [r4,#5]

add x, #1
sub y, #1
strb x, [r4,#6]
strb y, [r4,#7]
strb kind, [r4,#8]
mov r3, #1
strb r3, [r4,#9]
b next_generate

type2_generate:
cmp kind, #2
bne type3_generate
strb x, [r4,#0]
strb y, [r4,#1]

sub y, #1
strb x, [r4,#2]
strb y, [r4,#3]

add y, #2
strb x, [r4,#4]
strb y, [r4,#5]

add y, #1
strb x, [r4,#6]
strb y, [r4,#7]
strb kind, [r4,#8]
mov r3, #1
strb r3, [r4,#9]
b next_generate

type3_generate:
cmp kind, #3
bne type4_generate
strb x, [r4,#0]
strb y, [r4,#1]

add x, #1
strb x, [r4,#2]
strb y, [r4,#3]

sub x, #2
strb x, [r4,#4]
strb y, [r4,#5]

sub y, #1
strb x, [r4,#6]
strb y, [r4,#7]
strb kind, [r4,#8]
mov r3, #1
strb r3, [r4,#9]
b next_generate

type4_generate:
cmp kind, #4
bne type5_generate
strb x, [r4,#0]
strb y, [r4,#1]

sub x, #1
strb x, [r4,#2]
strb y, [r4,#3]

add x, #2
strb x, [r4,#4]
strb y, [r4,#5]

sub y, #1
strb x, [r4,#6]
strb y, [r4,#7]
strb kind, [r4,#8]
mov r3, #1
strb r3, [r4,#9]
b next_generate

type5_generate:
cmp kind, #5
bne type6_generate
strb x, [r4,#0]
strb y, [r4,#1]

sub x, #1
strb x, [r4,#2]
strb y, [r4,#3]

sub y, #1
strb x, [r4,#4]
strb y, [r4,#5]

add x, #1
strb x, [r4,#6]
strb y, [r4,#7]
strb kind, [r4,#8]
mov r3, #1
strb r3, [r4,#9]
b next_generate

type6_generate:
cmp kind, #6
bne type7_generate
strb x, [r4,#0]
strb y, [r4,#1]

sub x, #1
strb x, [r4,#2]
strb y, [r4,#3]

add x,#1
sub y, #1
strb x, [r4,#4]
strb y, [r4,#5]

add x, #1
strb x, [r4,#6]
strb y, [r4,#7]
strb kind, [r4,#8]
mov r3, #1
strb r3, [r4,#9]
b next_generate

type7_generate:
cmp kind, #7
bne next_generate
strb x, [r4,#0]
strb y, [r4,#1]

add x, #1
strb x, [r4,#2]
strb y, [r4,#3]

sub x,#1
sub y, #1
strb x, [r4,#4]
strb y, [r4,#5]

sub x, #1
strb x, [r4,#6]
strb y, [r4,#7]
strb kind, [r4,#8]
mov r3, #1
strb r3, [r4,#9]
b next_generate

next_generate:

.unreq x
.unreq y
.unreq kind
.unreq style
pop {r4-r10,lr}
mov pc, lr

/*
 * calculate the offset for given x,y
 * parameter: x(r0),y(r1)
 * return: offset(r3)
 */
.global calOffset
calOffset:
push {r4-r10,lr}
x .req r0
y .req r1
offset .req r3
mov offset, y
mov r4, #12
mul offset, r4
add offset, x

.unreq x
.unreq y
.unreq offset
pop {r4-r10,lr}
mov pc, lr

.global copyTetrimino
copyTetrimino:
push {r4-r10,lr}
offset .req r4

ldr r5, =currentTetrimino
ldr r6, =preTetrimino
mov offset, #0

copyTetriminoLoop:

	ldrb r2, [r5,offset]
  strb r2, [r6,offset]

  add offset, #1
	cmp	offset, #10
	blt	copyTetriminoLoop

.unreq offset
pop {r4-r10,lr}
mov pc, lr
