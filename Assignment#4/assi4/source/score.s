
.section .text
/*
 * r0 : the number
 * r4 - x
 * r5 - y
 */
.global drawNumber
drawNumber:
push {r6-r10,lr}
mov r8,r0

zero:
cmp r8, #0
bne one
bl clearNumber
bl drawNumber0
b exit_drawNumber

one:
cmp r8, #1
bne two
bl clearNumber
bl drawNumber1
b exit_drawNumber

two:
cmp r8, #2
bne three
bl clearNumber
bl drawNumber2
b exit_drawNumber

three:
cmp r8, #3
bne four
bl clearNumber
bl drawNumber3
b exit_drawNumber

four:
cmp r8, #4
bne five
bl clearNumber
bl drawNumber4
b exit_drawNumber

five:
cmp r8, #5
bne six
bl clearNumber
bl drawNumber5
b exit_drawNumber

six:
cmp r8, #6
bne seven
bl clearNumber
bl drawNumber6
b exit_drawNumber

seven:
cmp r8, #7
bne eight
bl clearNumber
bl drawNumber7
b exit_drawNumber

eight:
cmp r8, #8
bne nine
bl clearNumber
bl drawNumber8
b exit_drawNumber

nine:
cmp r8, #9
bne exit_drawNumber
bl clearNumber
bl drawNumber9

exit_drawNumber:
pop {r6-r10,lr}
mov pc, lr

.global drawScore
drawScore:
push {r4-r10,lr}
ldr r8,= currentGameState
ldrb r6, [r8,#252]
mov r8, #0
mov r9, #0
mov r10, #0

Number1:
cmp r6, #100
blt Number2
sub r6, #100
mov r8,#1

Number2:
cmp r6,#10
blt Number3
sub r6, #10
add r9, #1
b Number2

Number3:
mov r10,r6

mov r0,r8
ldr	  r4,	= 700
ldr	  r5,	= 200
bl drawNumber

mov r0,r9
ldr	  r4,	= 770
ldr	  r5,	= 200
bl drawNumber

mov r0,r10
ldr	  r4,	= 840
ldr	  r5,	= 200
bl drawNumber

pop {r4-r10,lr}
mov pc,lr

.global drawNumber0
drawNumber0:
push   {r6-r10,lr}

ldr	  r6,	= picNumber0
ldr	  r7,	= 64
ldr	  r8,	= 64

bl    drawPicture

pop   {r6-r10,lr}
mov   pc, lr

.global drawNumber1
drawNumber1:
push   {r6-r10,lr}

ldr	  r6,	= picNumber1
ldr	  r7,	= 64
ldr	  r8,	= 64

bl    drawPicture

pop   {r6-r10,lr}
mov   pc, lr

.global drawNumber2
drawNumber2:
push   {r6-r10,lr}

ldr	  r6,	= picNumber2
ldr	  r7,	= 64
ldr	  r8,	= 64

bl    drawPicture

pop   {r6-r10,lr}
mov   pc, lr

.global drawNumber3
drawNumber3:
push   {r6-r10,lr}
ldr	  r6,	= picNumber3
ldr	  r7,	= 64
ldr	  r8,	= 64

bl    drawPicture

pop   {r6-r10,lr}
mov   pc, lr

.global drawNumber4
drawNumber4:
push   {r6-r10,lr}

ldr	  r6,	= picNumber4
ldr	  r7,	= 64
ldr	  r8,	= 64

bl    drawPicture

pop   {r6-r10,lr}
mov   pc, lr

.global drawNumber5
drawNumber5:
push   {r6-r10,lr}

ldr	  r6,	= picNumber5
ldr	  r7,	= 64
ldr	  r8,	= 64

bl    drawPicture

pop   {r6-r10,lr}
mov   pc, lr

.global drawNumber6
drawNumber6:
push   {r6-r10,lr}

ldr	  r6,	= picNumber6
ldr	  r7,	= 64
ldr	  r8,	= 64

bl    drawPicture

pop   {r6-r10,lr}
mov   pc, lr

.global drawNumber7
drawNumber7:
push   {r6-r10,lr}

ldr	  r6,	= picNumber7
ldr	  r7,	= 64
ldr	  r8,	= 64

bl    drawPicture

pop   {r6-r10,lr}
mov   pc, lr

.global drawNumber8
drawNumber8:
push   {r6-r10,lr}

ldr	  r6,	= picNumber8
ldr	  r7,	= 64
ldr	  r8,	= 64

bl    drawPicture

pop   {r6-r10,lr}
mov   pc, lr

.global drawNumber9
drawNumber9:
push   {r6-r10,lr}

ldr	  r6,	= picNumber9
ldr	  r7,	= 64
ldr	  r8,	= 64

bl    drawPicture

pop   {r6-r10,lr}
mov   pc, lr

.global clearNumber
clearNumber:
push   {r6-r10,lr}

ldr	  r6,	= picNumberC
ldr	  r7,	= 64
ldr	  r8,	= 64

bl    drawPicture

pop   {r6-r10,lr}
mov   pc, lr
