
.section .text


/*
 * copy the currentGameState to the preGameState
 */
.global copyState

copyState:
push {r4-r10,lr}
offset .req r4

ldr r5, =currentGameState
ldr r6, =preGameState
mov offset, #0

copyStateLoop:

	ldrb r2, [r5,offset]
  strb r2, [r6,offset]

  add offset, #1
	cmp	offset, #255
	blt	copyStateLoop

.unreq offset
pop {r4-r10,lr}
mov pc, lr

/*
 *upDate the gameState
 */
.global upDate
upDate:
push {r4-r10,lr}
x .req r4
y .req r5
kind .req r6
offset .req r3

ldr r7, =currentTetrimino
ldrb kind, [r7,#8]

ldr r8, =currentGameState

mov offset, #0
mov r9, #0
upDateLoop:
ldrb x, [r7,r9]
mov r0, x
add r9, #1
ldrb y, [r7,r9]
mov r1, y
add r9, #1
bl calOffset
strb kind, [r8,offset]
cmp r9, #8
blt upDateLoop

.unreq x
.unreq y
.unreq kind
.unreq offset
pop {r4-r10,lr}
mov pc, lr


/*
 *check if the move is valid or not
 */
.global valid
valid:
push {r4-r10,lr}
x .req r4
y .req r5
kind .req r6
offset .req r3


ldr r7, =preTetrimino
mov kind, #0
ldr r8, =currentGameState

mov offset, #0
mov r9, #0
upDateLoop_c:
ldrb x, [r7,r9]
mov r0, x
add r9, #1
ldrb y, [r7,r9]
mov r1, y
add r9, #1
bl calOffset
ldrb r10, [r8,offset]
cmp r10, #8
beq skip_v
strb kind, [r8,offset]
skip_v:
cmp r9, #8
blt upDateLoop_c

//-----------------------
ldr r7, =currentTetrimino
ldrb kind, [r7,#8]

ldr r8, =currentGameState

mov offset, #0
mov r9, #0
validLoop:
ldrb x, [r7,r9]
mov r0, x
add r9, #1
ldrb y, [r7,r9]
mov r1, y
add r9, #1
bl calOffset
ldrb r10, [r8,offset]
cmp r10, #0
bne false
cmp r9, #8
blt validLoop
b true

false:
mov r1, #0
b exit_valid

true:
mov r1, #1

exit_valid:
.unreq x
.unreq y
.unreq kind
.unreq offset
pop {r4-r10,lr}
mov pc, lr

.global intoScreen
intoScreen:
push {r4-r10,lr}
x .req r4
y .req r5
kind .req r6
offset .req r3

ldr r7, =preTetrimino
ldrb kind, [r7,#8]

ldr r8, =currentGameState

mov offset, #0
mov r9, #0
intoScreenLoop:
ldrb x, [r7,r9]
mov r0, x
add r9, #1
ldrb y, [r7,r9]
mov r1, y
add r9, #1
bl calOffset
strb kind, [r8,offset]
cmp r9, #8
blt intoScreenLoop

.unreq x
.unreq y
.unreq kind
.unreq offset
pop {r4-r10,lr}
mov pc, lr

/*
 * upDte the gameState after generate a new Tetrimiino
 */
.global upDateGenerate
upDateGenerate:
push {r4-r10,lr}
x .req r4
y .req r5
kind .req r6
offset .req r3

ldr r7, =currentTetrimino
ldrb kind, [r7,#8]

ldr r8, =currentGameState

mov offset, #0
mov r9, #0
upDateGenerateLoop:
ldrb x, [r7,r9]
mov r0, x
add r9, #1
ldrb y, [r7,r9]
mov r1, y
add r9, #1
bl calOffset
ldrb r10,  [r8,offset]
cmp r10, #8
beq skip
strb kind, [r8,offset]
skip:
cmp r9, #8
blt upDateGenerateLoop

.unreq x
.unreq y
.unreq offset
pop {r4-r10,lr}
mov pc, lr

/*
 *check if the game is lose or not, if lose, set the lose flag
 */
.global checkLose
checkLose:
push {r4-r10,lr}
index .req r0
offset .req r1
ldr r8, =currentGameState
mov offset, #13

checkLoseLoop:
ldrb r4, [r8,offset]
cmp r4, #0
add offset,#1
bgt setLoseFlag
cmp offset, #22
blt  checkLoseLoop
b exit_checkLose

setLoseFlag:
mov r9,#1
strb r9, [r8,#254]

exit_checkLose:

.unreq offset
pop {r4-r10,lr}
mov pc, lr


/*
 *check if the game is win or not, if lose, set the win flag
 */
.global checkWin
checkWin:
push {r4-r10,lr}

ldr r8, =currentGameState

ldrb r4, [r8,#252]
cmp r4, #150
bge setWinFlag
b exit_checkWin

setWinFlag:
mov r9,#1
strb r9, [r8,#253]

exit_checkWin:

pop {r4-r10,lr}
mov pc, lr

/*
 *check the state is win or not
 */
 .global checkState
checkState:
push {r4-r10,lr}
ldr r8, =currentGameState
ldrb r4, [r8,#254]
cmp r4,#1
bleq lose

ldrb r4, [r8,#253]
cmp r4,#1
bleq win

exit_checkState:

pop {r4-r10,lr}
mov pc, lr

/*
 * check the row is full or not
 * parameter: y(r0) the row number
 * return r1 (#0 or #1)
 */
.global checkRowFull
checkRowFull:
push {r4-r10,lr}
y .req r0
offset .req r5
ldr r8, =currentGameState
mov r6, #12
mov offset, y
mul offset, r6
add offset, #1

mov r7,#0

checkRowFullLoop:
ldrb r9, [r8,offset]
add r7,#1
add offset,#1
cmp r9, #0
beq false_checkRowFull
cmp r7, #10
blt checkRowFullLoop

true_checkRowFull:
mov r1, #1
b exit_checkRowFull

false_checkRowFull:
mov r1, #0

exit_checkRowFull:

.unreq y
.unreq offset
pop {r4-r10,lr}
mov pc, lr

/*
 * check the row is empty or not
 * parameter: y(r0) the row number
 * return r1 (#0 or #1)
 */
.global checkRowEmpty
checkRowEmpty:
push {r4-r10,lr}
y .req r0
offset .req r5
ldr r8, =currentGameState
mov r6, #12
mov offset, y
mul offset, r6
add offset, #1

mov r7,#0

checkRowEmptyLoop:
ldrb r9, [r8,offset]
add r7,#1
add offset,#1
cmp r9, #0
bne false_checkRowEmpty
cmp r7, #10
blt checkRowEmptyLoop

true_checkRowEmpty:
mov r1, #1
b exit_checkRowEmpty

false_checkRowEmpty:
mov r1, #0

exit_checkRowEmpty:

.unreq y
.unreq offset
pop {r4-r10,lr}
mov pc, lr



/*
 * parameter: y(r0) the row number
 */
.global clearRow
clearRow:
push {r4-r10,lr}
y .req r0
offset .req r5
ldr r8, =currentGameState
mov r6, #12
mov offset, y
mul offset, r6
add offset, #1

mov r7,#0
mov r9,#0

clearRowLoop:
strb r9, [r8,offset]
add r7,#1
add offset,#1
cmp r7, #10
blt clearRowLoop

.unreq y
.unreq offset
pop {r4-r10,lr}
mov pc, lr

/*
 *
 */
.global clearFullRows
clearFullRows:
push {r4-r10,lr}
y .req r0
count .req r4
mov y, #1
mov count, #0

clearFullRowsLoop:
bl checkRowFull
cmp r1, #0
beq nextRow_clearFullRows
bl clearRow
add count, #1

nextRow_clearFullRows:
add y,#1
cmp y,#20
blt clearFullRowsLoop

cmp count, #0
beq exit_clearFullRows

mov r6, count
sub r6, #1
mov r5, #5
mul r6, r5
mov r5, #10
mul count, r5
add count, r6

ldr r6, =currentGameState
ldrb r7, [r6,#252]
add r7,count
strb r7, [r6,#252]

exit_clearFullRows:
.unreq count
.unreq y
pop {r4-r10,lr}
mov pc, lr


/*
 *
 */
.global readRow
readRow:
push {r4-r10,lr}
y .req r0
offset .req r5
ldr r8, =currentGameState
ldr r10, =rowState
mov r6, #12
mov offset, y
mul offset, r6
add offset, #1

mov r7,#0

readRowLoop:
ldrb r9, [r8,offset]
strb r9, [r10,r7]
add r7,#1
add offset,#1
cmp r7, #10
blt readRowLoop

.unreq y
.unreq offset
pop {r4-r10,lr}
mov pc, lr

/*
 *
 */
.global WriteRow
WriteRow:
push {r4-r10,lr}
y .req r0
offset .req r5
ldr r8, =currentGameState
ldr r10, =rowState
mov r6, #12
mov offset, y
mul offset, r6
add offset, #1

mov r7,#0

WriteRowLoop:
ldrb r9, [r10,r7]
strb r9, [r8,offset]
add r7,#1
add offset,#1
cmp r7, #10
blt WriteRowLoop

.unreq y
.unreq offset
pop {r4-r10,lr}
mov pc, lr

.global dropRow
dropRow:
push {r4-r10,lr}
y .req r0
pointer1 .req r4
pointer2 .req r5
mov pointer1, #19

while_dropRow_1:
	cmp pointer1, #1
	ble end_while_dropRow_1

  while_dropRow_2:
		mov y, pointer1
		bl checkRowEmpty
		cmp r1, #1
		beq end_while_dropRow_2

		sub pointer1, #1

		b while_dropRow_2
	end_while_dropRow_2:

	mov pointer2, pointer1
	sub pointer2, #1

	while_dropRow_3:
		cmp pointer2, #0
		ble end_while_dropRow_3
		mov y, pointer2
		bl checkRowEmpty
		cmp r1, #0
		beq end_while_dropRow_3

		sub pointer2, #1

		b while_dropRow_3
	end_while_dropRow_3:

	cmp pointer2, #0
	beq next_dropRow
	mov y, pointer2
	bl checkRowEmpty
	cmp r1, #0
	bne next_dropRow

	mov y, pointer2
	bl readRow
	mov y, pointer1
	bl WriteRow
	mov y, pointer2
	bl clearRow

	next_dropRow:

	sub pointer1, #1


	b while_dropRow_1
end_while_dropRow_1:

exit_dropRow:

.unreq y
.unreq pointer1
.unreq pointer2
pop {r4-r10,lr}
mov pc, lr

.global addScore
addScore:
push {r4-r10,lr}
ldr r4, =currentGameState
ldrb r5, [r4,#252]
add r5, #1
strb r5, [r4,#252]

pop {r4-r10,lr}
mov pc, lr

.global initAllState
initAllState:

push {r4-r10,lr}
offset .req r4

ldr r5, =IcurrentGameState
ldr r6, =currentGameState
mov offset, #0

initAllStateLoop:

	ldrb r2, [r5,offset]
  strb r2, [r6,offset]

  add offset, #1
	cmp	offset, #255
	blt	initAllStateLoop

//----------------------------------
	ldr r5, =IpreGameState
	ldr r6, =preGameState
	mov offset, #0

	initAllStateLoop2:

		ldrb r2, [r5,offset]
	  strb r2, [r6,offset]

	  add offset, #1
		cmp	offset, #255
		blt	initAllStateLoop2


//----------------------------------
ldr r5, =IcurrentTetrimino
ldr r6, =currentTetrimino
mov offset, #0

initAllStateLoop3:

	ldrb r2, [r5,offset]
	strb r2, [r6,offset]

	add offset, #1
	cmp	offset, #10
	blt	initAllStateLoop3

//----------------------------------
ldr r5, =IpreTetrimino
ldr r6, =preTetrimino
mov offset, #0

initAllStateLoop4:

	ldrb r2, [r5,offset]
	strb r2, [r6,offset]

	add offset, #1
	cmp	offset, #10
	blt	initAllStateLoop4
//----------------------------------
ldr r5, =IrowState
ldr r6, =rowState
mov offset, #0

initAllStateLoop5:

	ldrb r2, [r5,offset]
	strb r2, [r6,offset]

	add offset, #1
	cmp	offset, #10
	blt	initAllStateLoop5


.unreq offset
pop {r4-r10,lr}
mov pc, lr
