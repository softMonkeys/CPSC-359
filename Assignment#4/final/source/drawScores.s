.section .text

// Mario will get 100 scores when he get the coin and kill the monster each time.
.global   drawScoreOnTheScreen
drawScoreOnTheScreen:
push    {r0, r4-r8, lr}
ldr     r6, =scores
ldr     r0, [r6, #12]   // get the forth bit of the scores
cmp     r0, #0
bne     number1
ldr     r6, =numberZero
ldr     r4, =160
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       secondBit
number1:    // Draw the first digit of score
cmp     r0, #1
bne     number2
ldr     r6, =numberOne
ldr     r4, =160
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       secondBit
number2:
cmp     r0, #2
bne     number3
ldr     r6, =numberTwo
ldr     r4, =160
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       secondBit
number3:
cmp     r0, #3
bne     number4
ldr     r6, =numberThree
ldr     r4, =160
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       secondBit
number4:
cmp     r0, #4
bne     number5
ldr     r6, =numberFour
ldr     r4, =160
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       secondBit
number5:
cmp     r0, #5
bne     number6
ldr     r6, =numberFive
ldr     r4, =160
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       secondBit
number6:
cmp     r0, #6
bne     number7
ldr     r6, =numberSix
ldr     r4, =160
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       secondBit
number7:
cmp     r0, #7
bne     number8
ldr     r6, =numberSeven
ldr     r4, =160
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       secondBit
number8:
cmp     r0, #8
bne     number9
ldr     r6, =numberEight
ldr     r4, =160
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       secondBit
number9:
ldr     r6, =numberNine
ldr     r4, =160
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture


secondBit:
ldr     r6, =scores
ldr     r0, [r6, #8]    // get the third bit of the scores
cmp     r0, #0
bne     number11
ldr     r6, =numberZero
ldr     r4, =128
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       thirdBit
number11:   // Draw the second digit of score
cmp     r0, #1
bne     number22
ldr     r6, =numberOne
ldr     r4, =128
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       thirdBit
number22:
cmp     r0, #2
bne     number33
ldr     r6, =numberTwo
ldr     r4, =128
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       thirdBit
number33:
cmp     r0, #3
bne     number44
ldr     r6, =numberThree
ldr     r4, =128
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       thirdBit
number44:
cmp     r0, #4
bne     number55
ldr     r6, =numberFour
ldr     r4, =128
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       thirdBit
number55:
cmp     r0, #5
bne     number66
ldr     r6, =numberFive
ldr     r4, =128
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       thirdBit
number66:
cmp     r0, #6
bne     number77
ldr     r6, =numberSix
ldr     r4, =128
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       thirdBit
number77:
cmp     r0, #7
bne     number88
ldr     r6, =numberSeven
ldr     r4, =128
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       thirdBit
number88:
cmp     r0, #8
bne     number99
ldr     r6, =numberEight
ldr     r4, =128
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       thirdBit
number99:
ldr     r6, =numberNine
ldr     r4, =128
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture


thirdBit:
ldr     r6, =scores
ldr     r0, [r6, #4]    // get the second bit of scores
cmp     r0, #0
bne     number111
ldr     r6, =numberZero
ldr     r4, =96
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       fouthBit
number111:    // Draw the third digit of score
cmp     r0, #1
bne     number222
ldr     r6, =numberOne
ldr     r4, =96
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       fouthBit
number222:
cmp     r0, #2
bne     number333
ldr     r6, =numberTwo
ldr     r4, =96
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       fouthBit
number333:
cmp     r0, #3
bne     number444
ldr     r6, =numberThree
ldr     r4, =96
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       fouthBit
number444:
cmp     r0, #4
bne     number555
ldr     r6, =numberFour
ldr     r4, =96
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       fouthBit
number555:
cmp     r0, #5
bne     number666
ldr     r6, =numberFive
ldr     r4, =96
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       fouthBit
number666:
cmp     r0, #6
bne     number777
ldr     r6, =numberSix
ldr     r4, =96
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       fouthBit
number777:
cmp     r0, #7
bne     number888
ldr     r6, =numberSeven
ldr     r4, =96
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       fouthBit
number888:
cmp     r0, #8
bne     number999
ldr     r6, =numberEight
ldr     r4, =96
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       fouthBit
number999:
ldr     r6, =numberNine
ldr     r4, =96
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture


fouthBit:
ldr     r6, =scores
ldr     r0, [r6]    // get the fist bit of the scores
cmp     r0, #0
bne     number1111
ldr     r6, =numberZero
ldr     r4, =64
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number1111:   // Draw the forth digit of score
cmp     r0, #1
bne     number2222
ldr     r6, =numberOne
ldr     r4, =64
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number2222:
cmp     r0, #2
bne     number3333
ldr     r6, =numberTwo
ldr     r4, =64
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number3333:
cmp     r0, #3
bne     number4444
ldr     r6, =numberThree
ldr     r4, =64
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number4444:
cmp     r0, #4
bne     number5555
ldr     r6, =numberFour
ldr     r4, =64
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number5555:
cmp     r0, #5
bne     number6666
ldr     r6, =numberFive
ldr     r4, =64
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number6666:
cmp     r0, #6
bne     number7777
ldr     r6, =numberSix
ldr     r4, =64
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number7777:
cmp     r0, #7
bne     number8888
ldr     r6, =numberSeven
ldr     r4, =64
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number8888:
cmp     r0, #8
bne     number9999
ldr     r6, =numberEight
ldr     r4, =64
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture
b       exit
number9999:
ldr     r6, =numberNine
ldr     r4, =64
ldr     r5, =64
ldr     r7, =32
ldr     r8, =32
bl      drawPicture


exit:
pop     {r0, r4-r8, lr}
bx      lr
