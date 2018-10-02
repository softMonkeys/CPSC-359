
.section .text

.global controller2
controller2:
push    {r0-r10,lr}
        //call Init_GPIO to initialize GPIO
        bl      Init_GPIO

        //r5 is the copy of r9 numberlist, which prevent the program keeping printing the same button
        mov     r10, #0
        mov     r5, #0
        ldr     r5, =0xffff



//the loop to get the pressed button(s) and print the corresponding message

countTime:
ldr r0, =0x3F003004
ldr r6, [r0]
ldr r4, =0x493E0
add r6, r4

Loop2:
push {r6}
        //call the Read_SNES to get the numberlist and store it in r9
        bl      Read_SNES
        cmp     r5, r9
        beq     next2
        mov     r5, r9

//print out the corresponding button(s)
buttonB2:
        mov     r7, r9
        and     r7, #1
        cmp     r7, #0
        bne     buttonY2



buttonY2:
        mov     r7, r9
        lsr     r7, #1
        and     r7, #1
        cmp     r7, #0
        bne     buttonSelect2

buttonSelect2:
        mov     r7, r9
        lsr     r7, #2
        and     r7, #1
        cmp     r7, #0
        bne     buttonStart2

buttonStart2:
        mov     r7, r9
        lsr     r7, #3
        and     r7, #1
        cmp     r7, #0
        bne     buttonUp2
        b       Pause

buttonUp2:
        mov     r7, r9
        lsr     r7, #4
        and     r7, #1
        cmp     r7, #0
        bne     buttonDown2
        b      rotateUp_C2

buttonDown2:
        mov     r7, r9
        lsr     r7, #5
        and     r7, #1
        cmp     r7, #0
        bne     buttonLeft2
        b       rotateDown_C2

buttonLeft2:
        mov     r7, r9
        lsr     r7, #6
        and     r7, #1
        cmp     r7, #0
        bne     buttonRight2
        b       moveLeft_C2

buttonRight2:
        mov     r7, r9
        lsr     r7, #7
        and     r7, #1
        cmp     r7, #0
        bne     buttonA2
        b       moveRight_C2

buttonA2:
        mov     r7, r9
        lsr     r7, #8
        and     r7, #1
        cmp     r7, #0
        bne     buttonX2

buttonX2:
        mov     r7, r9
        lsr     r7, #9
        and     r7, #1
        cmp     r7, #0
        bne     buttonULeft2

buttonULeft2:
        mov     r7, r9
        lsr     r7, #10
        and     r7, #1
        cmp     r7, #0
        bne     buttonURight2

buttonURight2:
        mov     r7, r9
        lsr     r7, #11
        and     r7, #1
        cmp     r7, #0
        bne     next2

next2:
pop {r6}
checkTime:
        ldr r0, =0x3F003004
        ldr r2,[r0]
        cmp r6, r2

        bhi Loop2
        bl moveDown_C2


//------------------------------------------


.global moveLeft_C2
moveLeft_C2:
bl moveLeft

bl valid
cmp r1, #0
bne goLeft
bl moveRight
b Loop2

goLeft:
bl upDate
bl cmpDrawScreen
bl copyState
bl copyTetrimino
b Loop2

.global moveRight_C2
moveRight_C2:
bl moveRight

bl valid
cmp r1, #0
bne goRight
bl moveLeft
b Loop2

goRight:
bl upDate
bl cmpDrawScreen
bl copyState
bl copyTetrimino
b Loop2

.global moveDown_C2
moveDown_C2:
bl moveDown
bl valid
cmp r1, #0
bne goDown
bl intoScreen

bl addScore

bl drawScore

bl clearFullRows

bl drawScore

bl cmpDrawScreen

bl copyState
bl copyTetrimino



bl checkLose
bl checkWin
bl checkState

bl dropRow
bl cmpDrawScreen
bl copyState
bl copyTetrimino

bl random
bl generate
bl upDateGenerate
bl cmpDrawScreen
bl copyState
bl copyTetrimino

b countTime

goDown:
bl upDate
bl cmpDrawScreen



bl copyState
bl copyTetrimino

b countTime

.global rotateUp_C2
rotateUp_C2:
bl rotateUp

bl valid
cmp r1, #0
bne goRotateUp
bl rotateDown
b Loop2

goRotateUp:
bl upDate
bl cmpDrawScreen
bl copyState
bl copyTetrimino
b Loop2

.global rotateDown_C2
rotateDown_C2:
bl rotateDown

bl valid
cmp r1, #0
bne goRotateDown
bl rotateUp
b Loop2

goRotateDown:
bl upDate
bl cmpDrawScreen
bl copyState
bl copyTetrimino
b Loop2

Pause:
bl pause
bl cmpDrawScreen
b  Loop2

pop     {r0-r10,lr}
mov     pc, lr
