// Coding section
.section  .text

// This subtrountine will draw the introduction page for user
.global   drawIntroduction
drawIntroduction:
  push  {r4-r8, lr}

  // update the game status to game has not started
  ldr   r0, =enterTheGameCheck
  mov   r1, #1
  str   r1, [r0]

  // Draw the introduction screen
  ldr   r4, =0    // Starting postion for x
  ldr   r5, =0    // Starting postion for y
  ldr   r6, =Intro    // Load the address of "Intro" in "data.s"
  ldr   r7, =1024   // Width of the picture
  ldr   r8, =768    // Height of the picture
  bl    drawPicture   // call drawPicture subtrountine
  pop   {r4-r8, lr}
  bx    lr

// This subtrountine will draw an indicator besides the "start"
.global   drawIndicatorAtStart
drawIndicatorAtStart:
  push  {r4-r8, lr}
  // Draw the indicator
  ldr   r4, =410    // Starting postion for x
  ldr   r5, =495    // Starting postion for y
  ldr   r6, =Indicator    // Load the address of "Intro" in "data.s"
  ldr   r7, =32   // Width of the picture
  ldr   r8, =32    // Height of the picture
  bl    drawPicture   // call drawPicture subtrountine
  pop   {r4-r8, lr}
  bx    lr

// This subtrountine will erease the previous indicator image
.global   clearIndicatorAtStart
clearIndicatorAtStart:
  push  {r4-r8, lr}
  // Draw the indicator
  ldr   r4, =410    // Starting postion for x
  ldr   r5, =495    // Starting postion for y
  ldr   r6, =Sky    // Load the address of "Intro" in "data.s"
  ldr   r7, =32   // Width of the picture
  ldr   r8, =32    // Height of the picture
  bl    drawPicture   // call drawPicture subtrountine
  pop   {r4-r8, lr}
  bx    lr

// This subtrountine will draw an indicator besides the "quit"
.global   drawIndicatorAtQuit
drawIndicatorAtQuit:
  push  {r4-r8, lr}
  // Draw the indicator
  ldr   r4, =410    // Starting postion for x
  ldr   r5, =560    // Starting postion for y
  ldr   r6, =Indicator    // Load the address of "Intro" in "data.s"
  ldr   r7, =32   // Width of the picture
  ldr   r8, =32    // Height of the picture
  bl    drawPicture   // call drawPicture subtrountine
  pop   {r4-r8, lr}
  bx    lr

// This subtrountine will erease the previous indicator image
.global   clearIndicatorAtQuit
clearIndicatorAtQuit:
push  {r4-r8, lr}
  // Draw the indicator
  ldr   r4, =410    // Starting postion for x
  ldr   r5, =560   // Starting postion for y
  ldr   r6, =Sky    // Load the address of "Intro" in "data.s"
  ldr   r7, =32   // Width of the picture
  ldr   r8, =32    // Height of the picture
  bl    drawPicture   // call drawPicture subtrountine
  pop   {r4-r8, lr}
  bx    lr
