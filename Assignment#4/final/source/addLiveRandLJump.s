// This subroutine will add mario's live when he eat the value pack
.global marioBonusRandL
marioBonusRandL:
  push    {r0-r12, lr}
  // Load the map numer to determine which map is mario located
  ldr     r7, =mapNumber
  ldr     r8, [r7]
  cmp     r8, #1
  beq     LoadFirstMap11
  cmp     r8, #2
  beq     LoadSecondMap11
  cmp     r8, #3
  beq     LoadThirdMap11
  LoadFirstMap11:
  ldr     r7, =FirstMap
  b       continueNext11
  LoadSecondMap11:
  ldr     r7, =SecondMap
  b       continueNext11
  LoadThirdMap11:
  ldr     r7, =ThirdMap
  continueNext11:
  // Replace the value pcak to sky
  mov     r3, #2
  add     r12, #32
  strb    r3, [r7, r12]

  // Update the valuePackExist to the status that there is no value pack
  ldr     r0, =valuePackExist
  mov     r1, #0
  str     r1, [r0]

  // generate a radom place to palce value pack
  testPlaceValuePack:
  ldr     r8, =valuePackXPosition
  ldr     r4, [r8]
  ldr     r9, =valuePackYPosition
  ldr     r5, [r9]
  add     r4, #32
  str     r4, [r8]
  cmp     r4, #992
  beq     resetX
  b       continueX

  resetX:
  mov     r4, #0
  str     r4, [r8]
  continueX:
  mov     r8, #0    //r8 is row index for FirstMap
  mov     r9, #0    //r9 is column index for FirstMap
  mov     r10, #32    //r10 is the width and height for a cell
  mov     r12, #0   //r12 is the offset of the FirstMap
  mov     r0, #1    //r0 is offset for byte
  mov     r1, #0    //r1 is a temp value
  udiv    r8, r5, r10
  udiv    r9, r4, r10
  add     r9, #1
  mul     r12, r8, r10
  mov     r0, #1
  mul     r12, r0
  mul     r0, r9, r0
  add     r12, r0   //get the offset in front of mario from the FirstMap
  sub			r12, #1
  mov			r2, r12   // move r12 into a temperate register
  ldr     r7, =mapNumber
  ldr     r8, [r7]
  cmp     r8, #1
  beq     LoadFirstMap
  cmp     r8, #2
  beq     LoadSecondMap
  cmp     r8, #3
  beq     LoadThirdMap
  LoadFirstMap:
  ldr     r7, =FirstMap
  b       continueNext
  LoadSecondMap:
  ldr     r7, =SecondMap
  b       continueNext
  LoadThirdMap:
  ldr     r7, =ThirdMap

  // After the random place is genrated, add live
  continueNext:
  ldrb     r3, [r7, r2]
  cmp     r3, #2
  bne     testPlaceValuePack

  bl      LivesShowingOnTheScreenAdd
  pop    {r0-r12, lr}
  bx      lr
