.section    .text
.global     GoToTheFirstMap

// Mario go to the first map from the second map
GoToTheFirstMap:
push    {r4-r8, lr}
ldr		r0, =mapTransitionCheck
mov   r1, #1
str		r1, [r0]
bl      drawFirstMap
ldr     r7, =mapNumber
mov     r8, #1    // Number 1 stand for the first map
str     r8, [r7]
//////////////////////
bl      drawCoinNumberOnTheScreen
bl      drawScoreOnTheScreen
bl      drawLiveOnTheScreen

bl      drawMario1

ldr		r0, =mapTransitionCheck
mov   r1, #0
str		r1, [r0]

bl      controller1

pop     {r4-r8, lr}
mov     pc, lr

// Mario go to the second from the first map
.global     GoToTheSecondMap
GoToTheSecondMap:
push    {r4-r8, lr}
ldr		r0, =mapTransitionCheck
mov   r1, #1
str		r1, [r0]
bl      drawSecondMap
ldr     r7, =mapNumber
mov     r8, #2    // Number 2 stand for the second map
str     r8, [r7]
//////////////////////////
bl      drawCoinNumberOnTheScreen
bl      drawScoreOnTheScreen
bl      drawLiveOnTheScreen
bl      drawMario

ldr		r0, =mapTransitionCheck
mov   r1, #0
str		r1, [r0]

bl      controller1

pop     {r4-r8, lr}
mov     pc, lr


// Mario go to the second map from the third map
.global     GoToTheSecondMap1
GoToTheSecondMap1:
push    {r4-r8, lr}

ldr		r0, =mapTransitionCheck
mov   r1, #1
str		r1, [r0]

bl      drawSecondMap
ldr     r7, =mapNumber
mov     r8, #2    //Number 2 stand for the second map
str     r8, [r7]
//////////////////////
bl      drawCoinNumberOnTheScreen
bl      drawScoreOnTheScreen
bl      drawLiveOnTheScreen
bl      drawMario1

ldr		r0, =mapTransitionCheck
mov   r1, #0
str		r1, [r0]

bl      controller1

pop     {r4-r8, lr}
mov     pc, lr

// Mario go to the third map from the second map
.global     GoToTheThirdMap
GoToTheThirdMap:
push    {r4-r8, lr}

ldr		r0, =mapTransitionCheck
mov   r1, #1
str		r1, [r0]

bl      drawThirdMap
ldr     r7, =mapNumber
mov     r8, #3    // Number 3 stand for the third map
str     r8, [r7]
//////////////////////
bl      drawCoinNumberOnTheScreen
bl      drawScoreOnTheScreen
bl      drawLiveOnTheScreen
bl      drawMario

ldr		r0, =mapTransitionCheck
mov   r1, #0
str		r1, [r0]

bl      controller1

pop     {r4-r8, lr}
mov     pc, lr
