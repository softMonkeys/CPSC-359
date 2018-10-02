
.section .text

//generate the randomNumber
.global randomNumber
randomNumber:
push {r4-r10,lr}
t .req r4
ldr r8, =x
ldr r0, [r8]
ldr r8, =y
ldr r1, [r8]
ldr r8, =z
ldr r2, [r8]
ldr r8, =w
ldr r3, [r8]

mov t, r0
eor t,t,t, lsl #11
eor t,t,t, lsr #8
mov r0, r1
mov r1,r2
mov r2,r3
eor r3,r3,r3, lsr #19
eor r3,t

ldr r8, =x
str r0, [r8]
ldr r8, =y
str r1, [r8]
ldr r8, =z
str r2, [r8]
ldr r8, =w
str r3, [r8]
mov r0, r3

.unreq t
pop {r4-r10,lr}
mov pc, lr
.section .data
x:
.int 5496

y:
.int 213

z:
.int 661

w:
.int 788920
