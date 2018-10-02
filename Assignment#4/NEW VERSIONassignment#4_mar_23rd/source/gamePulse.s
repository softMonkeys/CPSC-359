.section  .text
.global   drawPulse
drawPulse:
push  {r4-r8, lr}
// Draw the introduction screen
ldr   r4, =412    // Starting postion for x
ldr   r5, =300    // Starting postion for y
ldr   r6, =pulsePicture    // Load the address of "Intro" in "data.s"
ldr   r7, =200   // Width of the picture
ldr   r8, =162    // Height of the picture

bl    drawPicture

pop   {r4-r8, lr}
bx    lr

.global   ClearPulseMenu
ClearPulseMenu:
push  {r4-r8, lr}
// Draw the introduction screen
ldr   r4, =412    // Starting postion for x
ldr   r5, =300    // Starting postion for y
ldr   r6, =skyToClearMenu    // Load the address of "Intro" in "data.s"
ldr   r7, =200   // Width of the picture
ldr   r8, =162    // Height of the picture

bl    drawPicture

pop   {r4-r8, lr}
bx    lr

.global   drawIndicatorAtReStart
drawIndicatorAtReStart:
push  {r4-r8, lr}
// Draw the indicator
ldr   r4, =420    // Starting postion for x
ldr   r5, =335    // Starting postion for y
ldr   r6, =pulseMenuIndicator    // Load the address of "Intro" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

pop   {r4-r8, lr}
bx    lr

.global   clearIndicatorAtReStart
clearIndicatorAtReStart:
push  {r4-r8, lr}
// Draw the indicator
ldr   r4, =420    // Starting postion for x
ldr   r5, =335    // Starting postion for y
ldr   r6, =ClearPulseMenuIndicator    // Load the address of "Intro" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

pop   {r4-r8, lr}
bx    lr

.global   drawIndicatorAtQuit1
drawIndicatorAtQuit1:
push  {r4-r8, lr}
// Draw the indicator
ldr   r4, =420    // Starting postion for x
ldr   r5, =370    // Starting postion for y
ldr   r6, =pulseMenuIndicator    // Load the address of "Intro" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

pop   {r4-r8, lr}
bx    lr

.global   clearIndicatorAtQuit1
clearIndicatorAtQuit1:
push  {r4-r8, lr}
// Draw the indicator
ldr   r4, =420    // Starting postion for x
ldr   r5, =370   // Starting postion for y
ldr   r6, =ClearPulseMenuIndicator    // Load the address of "Intro" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

pop   {r4-r8, lr}
bx    lr
