// Coding section
.section  .text

.global   drawIntroduction
drawIntroduction:
push  {r4-r8, lr}
// Draw the introduction screen
ldr   r4, =0    // Starting postion for x
ldr   r5, =0    // Starting postion for y
ldr   r6, =Intro    // Load the address of "Intro" in "data.s"
ldr   r7, =1024   // Width of the picture
ldr   r8, =768    // Height of the picture

bl    drawPicture

pop   {r4-r8, lr}
bx    lr

.global   drawIndicatorAtStart
drawIndicatorAtStart:
push  {r4-r8, lr}
// Draw the indicator
ldr   r4, =410    // Starting postion for x
ldr   r5, =495    // Starting postion for y
ldr   r6, =Indicator    // Load the address of "Intro" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

pop   {r4-r8, lr}
bx    lr

.global   clearIndicatorAtStart
clearIndicatorAtStart:
push  {r4-r8, lr}
// Draw the indicator
ldr   r4, =410    // Starting postion for x
ldr   r5, =495    // Starting postion for y
ldr   r6, =Sky    // Load the address of "Intro" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

pop   {r4-r8, lr}
bx    lr

.global   drawIndicatorAtQuit
drawIndicatorAtQuit:
push  {r4-r8, lr}
// Draw the indicator
ldr   r4, =410    // Starting postion for x
ldr   r5, =560    // Starting postion for y
ldr   r6, =Indicator    // Load the address of "Intro" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

pop   {r4-r8, lr}
bx    lr

.global   clearIndicatorAtQuit
clearIndicatorAtQuit:
push  {r4-r8, lr}
// Draw the indicator
ldr   r4, =410    // Starting postion for x
ldr   r5, =560   // Starting postion for y
ldr   r6, =Sky    // Load the address of "Intro" in "data.s"
ldr   r7, =32   // Width of the picture
ldr   r8, =32    // Height of the picture

bl    drawPicture

pop   {r4-r8, lr}
bx    lr
