
.section .text

/*
 * rotate type1 tetrimino down
 */
 .global type1_rotateDown
 type1_rotateDown:
 push {r4-r10,lr}
 x .req r0
 y .req r1
 style .req r3

 ldr r4, =currentTetrimino

 ldrb style, [r4,#9]

 style1_1:
 cmp style, #1
 bne style1_2
 bl type1_4
 mov style, #4
 strb style, [r4,#9]
 b next_type1_rotateDown

 style1_2:
 cmp style, #2
 bne style1_3
 bl type1_1
 mov style, #1
 strb style, [r4,#9]
 b next_type1_rotateDown

 style1_3:
 cmp style, #3
 bne style1_4
 bl type1_2
 mov style, #2
 strb style, [r4,#9]
 b next_type1_rotateDown

 style1_4:
 cmp style, #4
 bne next_type1_rotateDown
 bl type1_3
 mov style, #3
 strb style, [r4,#9]
 b next_type1_rotateDown

 next_type1_rotateDown:

 .unreq x
 .unreq y
 .unreq style
 pop {r4-r10,lr}
 mov pc, lr

 /*
  * rotate type2 tetrimino down
  */
  .global type2_rotateDown
  type2_rotateDown:
  push {r4-r10,lr}
  x .req r0
  y .req r1
  style .req r3

  ldr r4, =currentTetrimino

  ldrb style, [r4,#9]

  style2_1:
  cmp style, #1
  bne style2_2
  bl type2_4
  mov style, #4
  strb style, [r4,#9]
  b next_type2_rotateDown

  style2_2:
  cmp style, #2
  bne style2_3
  bl type2_1
  mov style, #1
  strb style, [r4,#9]
  b next_type2_rotateDown

  style2_3:
  cmp style, #3
  bne style2_4
  bl type2_2
  mov style, #2
  strb style, [r4,#9]
  b next_type2_rotateDown

  style2_4:
  cmp style, #4
  bne next_type2_rotateDown
  bl type2_3
  mov style, #3
  strb style, [r4,#9]
  b next_type2_rotateDown

  next_type2_rotateDown:

  .unreq x
  .unreq y
  .unreq style
  pop {r4-r10,lr}
  mov pc, lr

  /*
   * rotate type3 tetrimino down
   */
   .global type3_rotateDown
   type3_rotateDown:
   push {r4-r10,lr}
   x .req r0
   y .req r1
   style .req r3

   ldr r4, =currentTetrimino

   ldrb style, [r4,#9]

   style3_1:
   cmp style, #1
   bne style3_2
   bl type3_4
   mov style, #4
   strb style, [r4,#9]
   b next_type3_rotateDown

   style3_2:
   cmp style, #2
   bne style3_3
   bl type3_1
   mov style, #1
   strb style, [r4,#9]
   b next_type3_rotateDown

   style3_3:
   cmp style, #3
   bne style3_4
   bl type3_2
   mov style, #2
   strb style, [r4,#9]
   b next_type3_rotateDown

   style3_4:
   cmp style, #4
   bne next_type3_rotateDown
   bl type3_3
   mov style, #3
   strb style, [r4,#9]
   b next_type3_rotateDown

   next_type3_rotateDown:

   .unreq x
   .unreq y
   .unreq style
   pop {r4-r10,lr}
   mov pc, lr

   /*
    * rotate type4 tetrimino down
    */
    .global type4_rotateDown
    type4_rotateDown:
    push {r4-r10,lr}
    x .req r0
    y .req r1
    style .req r3

    ldr r4, =currentTetrimino

    ldrb style, [r4,#9]

    style4_1:
    cmp style, #1
    bne style4_2
    bl type4_4
    mov style, #4
    strb style, [r4,#9]
    b next_type4_rotateDown

    style4_2:
    cmp style, #2
    bne style4_3
    bl type4_1
    mov style, #1
    strb style, [r4,#9]
    b next_type4_rotateDown

    style4_3:
    cmp style, #3
    bne style4_4
    bl type4_2
    mov style, #2
    strb style, [r4,#9]
    b next_type4_rotateDown

    style4_4:
    cmp style, #4
    bne next_type4_rotateDown
    bl type4_3
    mov style, #3
    strb style, [r4,#9]
    b next_type4_rotateDown

    next_type4_rotateDown:

    .unreq x
    .unreq y
    .unreq style
    pop {r4-r10,lr}
    mov pc, lr

    /*
     * rotate type6 tetrimino down
     */
     .global type6_rotateDown
     type6_rotateDown:
     push {r4-r10,lr}
     x .req r0
     y .req r1
     style .req r3

     ldr r4, =currentTetrimino

     ldrb style, [r4,#9]

     style6_1:
     cmp style, #1
     bne style6_2
     bl type6_2
     mov style, #2
     strb style, [r4,#9]
     b next_type6_rotateDown

     style6_2:
     cmp style, #2
     bne next_type6_rotateDown
     bl type6_1
     mov style, #1
     strb style, [r4,#9]
     b next_type6_rotateDown


     next_type6_rotateDown:

     .unreq x
     .unreq y
     .unreq style
     pop {r4-r10,lr}
     mov pc, lr

     /*
      * rotate type7 tetrimino down
      */
      .global type7_rotateDown
      type7_rotateDown:
      push {r4-r10,lr}
      x .req r0
      y .req r1
      style .req r3

      ldr r4, =currentTetrimino

      ldrb style, [r4,#9]

      style7_1:
      cmp style, #1
      bne style7_2
      bl type7_2
      mov style, #2
      strb style, [r4,#9]
      b next_type7_rotateDown

      style7_2:
      cmp style, #2
      bne next_type7_rotateDown
      bl type7_1
      mov style, #1
      strb style, [r4,#9]
      b next_type7_rotateDown


      next_type7_rotateDown:

      .unreq x
      .unreq y
      .unreq style
      pop {r4-r10,lr}
      mov pc, lr
