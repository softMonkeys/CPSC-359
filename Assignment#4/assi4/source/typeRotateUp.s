
.section .text

/*
 * rotate type1 tetrimino up
 */
 .global type1_rotateUp
 type1_rotateUp:
 push {r4-r10,lr}
 x .req r0
 y .req r1
 style .req r3

 ldr r4, =currentTetrimino

 ldrb style, [r4,#9]

 style1_1:
 cmp style, #1
 bne style1_2
 bl type1_2
 mov style, #2
 strb style, [r4,#9]
 b next_type1_rotateUp

 style1_2:
 cmp style, #2
 bne style1_3
 bl type1_3
 mov style, #3
 strb style, [r4,#9]
 b next_type1_rotateUp

 style1_3:
 cmp style, #3
 bne style1_4
 bl type1_4
 mov style, #4
 strb style, [r4,#9]
 b next_type1_rotateUp

 style1_4:
 cmp style, #4
 bne next_type1_rotateUp
 bl type1_1
 mov style, #1
 strb style, [r4,#9]
 b next_type1_rotateUp

 next_type1_rotateUp:

 .unreq x
 .unreq y
 .unreq style
 pop {r4-r10,lr}
 mov pc, lr

 /*
  * rotate type2 tetrimino up
  */
  .global type2_rotateUp
  type2_rotateUp:
  push {r4-r10,lr}
  x .req r0
  y .req r1
  style .req r3

  ldr r4, =currentTetrimino

  ldrb style, [r4,#9]

  style2_1:
  cmp style, #1
  bne style2_2
  bl type2_2
  mov style, #2
  strb style, [r4,#9]
  b next_type2_rotateUp

  style2_2:
  cmp style, #2
  bne style2_3
  bl type2_3
  mov style, #3
  strb style, [r4,#9]
  b next_type2_rotateUp

  style2_3:
  cmp style, #3
  bne style2_4
  bl type2_4
  mov style, #4
  strb style, [r4,#9]
  b next_type2_rotateUp

  style2_4:
  cmp style, #4
  bne next_type2_rotateUp
  bl type2_1
  mov style, #1
  strb style, [r4,#9]
  b next_type2_rotateUp

  next_type2_rotateUp:

  .unreq x
  .unreq y
  .unreq style
  pop {r4-r10,lr}
  mov pc, lr

  /*
   * rotate type3 tetrimino up
   */
   .global type3_rotateUp
   type3_rotateUp:
   push {r4-r10,lr}
   x .req r0
   y .req r1
   style .req r3

   ldr r4, =currentTetrimino

   ldrb style, [r4,#9]

   style3_1:
   cmp style, #1
   bne style3_2
   bl type3_2
   mov style, #2
   strb style, [r4,#9]
   b next_type3_rotateUp

   style3_2:
   cmp style, #2
   bne style3_3
   bl type3_3
   mov style, #3
   strb style, [r4,#9]
   b next_type3_rotateUp

   style3_3:
   cmp style, #3
   bne style3_4
   bl type3_4
   mov style, #4
   strb style, [r4,#9]
   b next_type3_rotateUp

   style3_4:
   cmp style, #4
   bne next_type3_rotateUp
   bl type3_1
   mov style, #1
   strb style, [r4,#9]
   b next_type3_rotateUp

   next_type3_rotateUp:

   .unreq x
   .unreq y
   .unreq style
   pop {r4-r10,lr}
   mov pc, lr

   /*
    * rotate type4 tetrimino up
    */
    .global type4_rotateUp
    type4_rotateUp:
    push {r4-r10,lr}
    x .req r0
    y .req r1
    style .req r3

    ldr r4, =currentTetrimino

    ldrb style, [r4,#9]

    style4_1:
    cmp style, #1
    bne style4_2
    bl type4_2
    mov style, #2
    strb style, [r4,#9]
    b next_type4_rotateUp

    style4_2:
    cmp style, #2
    bne style4_3
    bl type4_3
    mov style, #3
    strb style, [r4,#9]
    b next_type4_rotateUp

    style4_3:
    cmp style, #3
    bne style4_4
    bl type4_4
    mov style, #4
    strb style, [r4,#9]
    b next_type4_rotateUp

    style4_4:
    cmp style, #4
    bne next_type4_rotateUp
    bl type4_1
    mov style, #1
    strb style, [r4,#9]
    b next_type4_rotateUp

    next_type4_rotateUp:

    .unreq x
    .unreq y
    .unreq style
    pop {r4-r10,lr}
    mov pc, lr

    /*
     * rotate type6 tetrimino up
     */
     .global type6_rotateUp
     type6_rotateUp:
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
     b next_type6_rotateUp

     style6_2:
     cmp style, #2
     bne next_type6_rotateUp
     bl type6_1
     mov style, #1
     strb style, [r4,#9]
     b next_type6_rotateUp

     next_type6_rotateUp:

     .unreq x
     .unreq y
     .unreq style
     pop {r4-r10,lr}
     mov pc, lr

     /*
      * rotate type6 tetrimino up
      */
      .global type7_rotateUp
      type7_rotateUp:
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
      b next_type7_rotateUp

      style7_2:
      cmp style, #2
      bne next_type7_rotateUp
      bl type7_1
      mov style, #1
      strb style, [r4,#9]
      b next_type7_rotateUp

      next_type7_rotateUp:

      .unreq x
      .unreq y
      .unreq style
      pop {r4-r10,lr}
      mov pc, lr
