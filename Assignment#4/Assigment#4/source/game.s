.section    .text
.global     StartGame

StartGame:
  push  {r4-r8, lr}
  bl    drawFirstMap


  
  pop   {r4-r8,lr}
  mov   pc, lr
