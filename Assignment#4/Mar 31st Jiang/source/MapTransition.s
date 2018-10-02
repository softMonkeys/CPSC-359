.section    .text
.global     GoToTheSecondMap
GoToTheSecondMap:
push    {r4-r8, lr}
bl      drawSecondMap
ldr     r7, =mapNumber
mov     r8, #2
str     r8, [r7]
//////////////////////
bl      drawCoinNumberOnTheScreen
bl      drawScoreOnTheScreen
bl      drawLiveOnTheScreen
bl      drawMario
bl      controller1

pop     {r4-r8, lr}
mov     pc, lr


.global     GoToTheThirdMap
GoToTheThirdMap:
push    {r4-r8, lr}
bl      drawThirdMap
ldr     r7, =mapNumber
mov     r8, #3
str     r8, [r7]
//////////////////////
bl      drawCoinNumberOnTheScreen
bl      drawScoreOnTheScreen
bl      drawLiveOnTheScreen
bl      drawMario
bl      controller1

pop     {r4-r8, lr}
mov     pc, lr
