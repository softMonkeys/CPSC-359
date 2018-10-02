.section .text
/* Draw Pixel
 *  r0 - x
 *  r1 - y
 *  r2 - color
 */
.global		DrawPixel
DrawPixel:
	push	{r4}
	offset	.req	r4

	// offset = (y * 1024) + x = x + (y << 10)
	add		offset,	r0, r1, lsl #10

	// offset *= 2 (for 16 bits per pixel = 2 bytes per pixel)
	lsl		offset, #1

	// store the colour (half word) at framebuffer pointer + offset
	ldr	r0, =FrameBufferPointer
	ldr	r0, [r0]
	strh	r2, [r0, offset]

	pop		{r4}
	bx		lr

/* drawPicture
 * r4 - Starting postion for x
 * r5 - Starting postion for y
 * r6 - Load the address of "Intro" in "data.s"
 * r7 - Width of the picture
 * r8 - Height of the picture
 */
 .global	drawPicture
drawPicture:
	push	{r0-r3, r6-r10, lr}
	add  	r7, r4
  add  	r8, r5
  mov  	r9, r4
	mov  	r10, r5

drawPictureLoop:
	mov		r0, r4			//passing x for ro which is used by the Draw pixel function
	mov		r1,	r5			//passing y for r1 which is used by the Draw pixel formula

	ldrh	r2,	[r6], #2			//setting pixel color by loading it from the data section. We load hald word
	bl		DrawPixel
	add		r4,	#1			//increment x position
	cmp		r4,	r7			//compare with image with
	blt		drawPictureLoop
	mov		r4,	r9			//reset x
	add		r5,	#1			//increment Y
	cmp		r5,	r8			//compare y with image height
	blt		drawPictureLoop

	mov  	r4, r9
	mov  	r5, r10
	pop		{r0-r3, r6-r10, lr}
	mov		pc,	lr			//return

/* drawPicture2
 * r11 - Starting postion for x
 * r12 - Starting postion for y
 * r6 - Load the address of "Intro" in "data.s"
 * r7 - Width of the picture
 * r8 - Height of the picture
 */
.global	drawPicture2
drawPicture2:
	push	{r0-r3, r6-r12, lr}
	ldr		r0, =mushRoomXPosition
	ldr		r11, [r0]
	ldr		r0, =mushRoomYPosition
	ldr		r12, [r0]

	add  	r7, r11
	add  	r8, r12
	mov  	r9, r11
	mov  	r10, r12

	drawPictureLoop2:
	mov		r0, r11			//passing x for ro which is used by the Draw pixel function
	mov		r1,	r12			//passing y for r1 which is used by the Draw pixel formula

	ldrh	r2,	[r6], #2			//setting pixel color by loading it from the data section. We load hald word
	bl		DrawPixel
	add		r11,	#1			//increment x position
	cmp		r11,	r7			//compare with image with
	blt		drawPictureLoop2
	mov		r11,	r9			//reset x
	add		r12,	#1			//increment Y
	cmp		r12,	r8			//compare y with image height
	blt		drawPictureLoop2

	mov  	  r11, r9
	mov  	  r12, r10

	pop		{r0-r3, r6-r12, lr}
	mov		pc,	lr			//return

/* drawPicture3
 * r11 - Starting postion for x
 * r12 - Starting postion for y
 * r6 - Load the address of "Intro" in "data.s"
 * r7 - Width of the picture
 * r8 - Height of the picture
 */
.global	drawPicture3
drawPicture3:
	push	{r0-r3, r6-r12, lr}
	ldr		r0, =coinDisappearX
	ldr		r11, [r0]
	ldr		r0, =coinDisappearY
	ldr		r12, [r0]

	add  	r7, r11
	add  	r8, r12
	mov  	r9, r11
	mov  	r10, r12

	drawPictureLoop3:
	mov		r0, r11			//passing x for ro which is used by the Draw pixel function
	mov		r1,	r12			//passing y for r1 which is used by the Draw pixel formula

	ldrh	r2,	[r6], #2			//setting pixel color by loading it from the data section. We load hald word
	bl		DrawPixel
	add		r11,	#1			//increment x position
	cmp		r11,	r7			//compare with image with
	blt		drawPictureLoop3
	mov		r11,	r9			//reset x
	add		r12,	#1			//increment Y
	cmp		r12,	r8			//compare y with image height
	blt		drawPictureLoop3

	mov  	  r11, r9
	mov  	  r12, r10

	pop		{r0-r3, r6-r12, lr}
	mov		pc,	lr			//return

/* drawPicture4
 * r11 - Starting postion for x
 * r12 - Starting postion for y
 * r6 - Load the address of "Intro" in "data.s"
 * r7 - Width of the picture
 * r8 - Height of the picture
 */
.global	drawPicture4
drawPicture4:
	push	{r0-r3, r6-r12, lr}
	ldr		r0, =TurtleXPosition
	ldr		r11, [r0]
	ldr		r0, =TurtleYPosition
	ldr		r12, [r0]

	add  	r7, r11
	add  	r8, r12
	mov  	r9, r11
	mov  	r10, r12

	drawPictureLoop4:
	mov		r0, r11			//passing x for ro which is used by the Draw pixel function
	mov		r1,	r12			//passing y for r1 which is used by the Draw pixel formula

	ldrh	r2,	[r6], #2			//setting pixel color by loading it from the data section. We load hald word
	bl		DrawPixel
	add		r11,	#1			//increment x position
	cmp		r11,	r7			//compare with image with
	blt		drawPictureLoop4
	mov		r11,	r9			//reset x
	add		r12,	#1			//increment Y
	cmp		r12,	r8			//compare y with image height
	blt		drawPictureLoop4

	mov  	  r11, r9
	mov  	  r12, r10

	pop		{r0-r3, r6-r12, lr}
	mov		pc,	lr			//return

/* drawPictureValuePack
 * r11 - Starting postion for x
 * r12 - Starting postion for y
 * r6 - Load the address of "Intro" in "data.s"
 * r7 - Width of the picture
 * r8 - Height of the picture
 */
.global	drawPictureValuePack
drawPictureValuePack:
	push	{r0-r3, r6-r12, lr}
	ldr		r0, =valuePackXPosition
	ldr		r11, [r0]
	ldr		r0, =valuePackYPosition
	ldr		r12, [r0]

	add  	r7, r11
	add  	r8, r12
	mov  	r9, r11
	mov  	r10, r12

	drawPictureLoop5:
	mov		r0, r11			//passing x for ro which is used by the Draw pixel function
	mov		r1,	r12			//passing y for r1 which is used by the Draw pixel formula

	ldrh	r2,	[r6], #2			//setting pixel color by loading it from the data section. We load hald word
	bl		DrawPixel
	add		r11,	#1			//increment x position
	cmp		r11,	r7			//compare with image with
	blt		drawPictureLoop5
	mov		r11,	r9			//reset x
	add		r12,	#1			//increment Y
	cmp		r12,	r8			//compare y with image height
	blt		drawPictureLoop5

	mov  	  r11, r9
	mov  	  r12, r10

	pop		{r0-r3, r6-r12, lr}
	mov		pc,	lr			//return
