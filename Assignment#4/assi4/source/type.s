
.section .text

.global type1_1
type1_1:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

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

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type1_2
type1_2:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

sub x, #1
strb x, [r4,#2]
strb y, [r4,#3]

add x, #1
add y, #1
strb x, [r4,#4]
strb y, [r4,#5]

sub y, #2
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type1_3
type1_3:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

sub x, #1
strb x, [r4,#2]
strb y, [r4,#3]

add x, #2
strb x, [r4,#4]
strb y, [r4,#5]

sub x, #1
add y, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type1_4
type1_4:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

add x, #1
strb x, [r4,#2]
strb y, [r4,#3]

sub x, #1
add y, #1
strb x, [r4,#4]
strb y, [r4,#5]

sub y, #2
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type2_1
type2_1:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

sub y, #1
strb x, [r4,#2]
strb y, [r4,#3]

add y, #2
strb x, [r4,#4]
strb y, [r4,#5]

add y, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type2_2
type2_2:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

sub x, #1
strb x, [r4,#2]
strb y, [r4,#3]

add x, #2
strb x, [r4,#4]
strb y, [r4,#5]

add x, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type2_3
type2_3:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

sub y, #1
strb x, [r4,#2]
strb y, [r4,#3]

add y, #2
strb x, [r4,#4]
strb y, [r4,#5]

add y, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type2_4
type2_4:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

sub x, #1
strb x, [r4,#2]
strb y, [r4,#3]

add x, #2
strb x, [r4,#4]
strb y, [r4,#5]

add x, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type3_1
type3_1:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

add x, #1
strb x, [r4,#2]
strb y, [r4,#3]

sub x, #2
strb x, [r4,#4]
strb y, [r4,#5]

sub y, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type3_2
type3_2:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

sub y, #1
strb x, [r4,#2]
strb y, [r4,#3]

add y, #2
strb x, [r4,#4]
strb y, [r4,#5]

sub x, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type3_3
type3_3:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

sub x, #1
strb x, [r4,#2]
strb y, [r4,#3]

add x, #2
strb x, [r4,#4]
strb y, [r4,#5]

add y, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type3_4
type3_4:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

add y, #1
strb x, [r4,#2]
strb y, [r4,#3]

sub y, #2
strb x, [r4,#4]
strb y, [r4,#5]

add x, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type4_1
type4_1:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

sub x, #1
strb x, [r4,#2]
strb y, [r4,#3]

add x, #2
strb x, [r4,#4]
strb y, [r4,#5]

sub y, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type4_2
type4_2:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

add y, #1
strb x, [r4,#2]
strb y, [r4,#3]

sub y, #2
strb x, [r4,#4]
strb y, [r4,#5]

sub x, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type4_3
type4_3:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

add x, #1
strb x, [r4,#2]
strb y, [r4,#3]

sub x, #2
strb x, [r4,#4]
strb y, [r4,#5]

add y, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type4_4
type4_4:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

sub y, #1
strb x, [r4,#2]
strb y, [r4,#3]

add y, #2
strb x, [r4,#4]
strb y, [r4,#5]

add x, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type6_1
type6_1:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

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

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type6_2
type6_2:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

add y, #1
strb x, [r4,#2]
strb y, [r4,#3]

sub x,#1
sub y, #1
strb x, [r4,#4]
strb y, [r4,#5]

sub y, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type7_1
type7_1:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

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

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr

.global type7_2
type7_2:
push {r4-r10,lr}
x .req r0
y .req r1

ldr r4, =currentTetrimino
ldrb x, [r4]
ldrb y, [r4,#1]

sub y, #1
strb x, [r4,#2]
strb y, [r4,#3]

sub x,#1
add y, #1
strb x, [r4,#4]
strb y, [r4,#5]

add y, #1
strb x, [r4,#6]
strb y, [r4,#7]

.unreq x
.unreq y
pop {r4-r10,lr}
mov pc, lr
