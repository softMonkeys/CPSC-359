.section    .text
.global     StartGame

StartGame:
  push  {r4-r8, lr}
  bl    drawFirstMap
  bl    drawMario
  bl    controller1



  pop   {r4-r8, lr}
  mov   pc, lr
