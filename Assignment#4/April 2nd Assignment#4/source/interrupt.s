.global	InstallIntTable
InstallIntTable:
	push	{r0-r12, lr}
	ldr		r0, =IntTable
	mov		r1, #0x00000000

	// load the first 8 words and store at the 0 address
	ldmia	r0!, {r2-r9}
	stmia	r1!, {r2-r9}

	// load the second 8 words and store at the next address
	ldmia	r0!, {r2-r9}
	stmia	r1!, {r2-r9}

	// switch to IRQ mode and set stack pointer
	mov		r0, #0xD2
	msr		cpsr_c, r0
	mov		sp, #0x8000

	// switch back to Supervisor mode, set the stack pointer
	mov		r0, #0xD3
	msr		cpsr_c, r0
	mov		sp, #0x8000000

	bx		lr

// This subroutine will count 30s until it call draw valur pack function
.global	InterruptFuction
InterruptFuction:
	push	{r0-r12, lr}
	ldr		r5, =0X3F003004		// address of CLO
	ldr		r6, [r5]		// read CLO
	ldr		r7, =0x1C9C380		// time to let InterruptFuction to wait until draw the value pack
	add		r6, r7		// add the wait time to the system's current time
	ldr		r8, =0X3F003010
	str 	r6, [r8]
	ldr		r5, =0X3F00B210
	ldr		r6, =0XA
	str 	r6, [r5]
	ldr		r0, =0x3F00B214
	mov		r1, #0
	str 	r1, [r0]
	mrs		r5, cpsr
	bic		r5, #0x80
	msr		cpsr_c, r5
	pop		{r0-r12, lr}
	bx		lr

// This subroutine will determine when to trigger the draw value pack function
.global	Setting
Setting:
	push	{r0-r12, lr}
	ldr		r0, =0x3F00B204
	ldr		r1, [r0]
	ldr		r3, =0x2
	tst		r1, r3
	beq		clearing

	// Check if user is in the game map or not, if not, don't draw
	ldr		r0, =enterTheGameCheck
	ldr		r1, [r0]
	cmp		r1, #1
	beq		clearing

	// Check if the screen is printing the winning page or losing page, if yes, dont draw
	ldr		r0, =MarioWin
	ldr		r1, [r0]
	cmp		r1, #2
	bne		clearing

	// Check if the user is in the map transition process, if yes, don't draw
	ldr		r0, =mapTransitionCheck
	ldr		r1, [r0]
	cmp		r1, #1
	beq		clearing

// If the previous conditions are all pass, it means we need to generate a value pack on the map
drawValuePick:
	push	{lr}

	// when program first run, avoid printing value pack immediately
	ldr		r0, =IsItFirstTimeDraw
	ldr   r1, [r0]
	cmp   r1, #0
	beq   ItIsNot

	// if the value pack is already exist and player didn't eat it in the past 30s, don't generate another value pack
	ldr		r0, =valuePackExist
	ldr		r0, [r0]
	cmp		r0, #1
	beq		ItIsNot

	// The following code will calculate the offset and generate a value pack on the offset of the map
	ldr     r8, =valuePackXPosition
	ldr     r4, [r8]
	ldr     r9, =valuePackYPosition
	ldr     r5, [r9]
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
	///////////////
	mov			r2, r12		// move the offset to a temperate register
	///////////////
	ldr     r7, =mapNumber		// load the map number to get ready for drawing value pack
	ldr     r8, [r7]
	cmp     r8, #1
	beq     LoadFirstMap
	cmp     r8, #2
	beq     LoadSecondMap
	cmp     r8, #3
	beq     LoadThirdMap
	LoadFirstMap:
	ldr     r7, =FirstMap		// load the first map's address to get ready for drawing value pack
	b       continueNext
	LoadSecondMap:
	ldr     r7, =SecondMap		// load the second map's address to get ready for drawing value pack
	b       continueNext
	LoadThirdMap:
	ldr     r7, =ThirdMap		// load the third map's address to get ready for drawing value pack

	continueNext:
	mov     r3, #40		// #40 stands for value pack
	strb    r3, [r7, r2]		// store #40 into the offset of the map

	// Draw the value pack
	ldr     r6, =Bonus2Picture
	ldr     r7, =32
	ldr     r8, =32
	bl      drawPictureValuePack

	// Trigger the label to let program know that the value pack is drawn
	ldr			r0, =valuePackExist
	mov			r1, #1
	str 		r1, [r0]
ItIsNot:
	// Trigger the label to let program know that it is not the fist time program run
	ldr		r0, =IsItFirstTimeDraw
	mov		r1, #1
	str   r1, [r0]
	pop		{lr}
clearing:
	ldr		r5, =0x3F003000
	ldr		r6, =0x2
	str 	r6, [r5]
	bl		InterruptFuction		// call back to InterruptFuction
	ldr 	r5, =0x3F003000
	ldr		r4, [r5]
	ldr		r6, =0x2
	orr 	r4, r6
	str 	r4, [r5]
	pop		{r0-r12, lr}
	subs	pc, lr, #4

// The data section initialize the system call
.section	.data
IntTable:
	ldr		pc, reset_handler
	ldr		pc, undefined_handler
	ldr		pc, swi_handler
	ldr		pc, prefetch_handler
	ldr		pc, data_handler
	ldr		pc, unused_handler
	ldr		pc,	irq_handler
	ldr		pc, fiq_handler

reset_handler:			.word	InstallIntTable
undefined_handler:	.word	haltLoop$
swi_handler:				.word	haltLoop$
prefetch_handler:		.word	haltLoop$
data_handler:				.word	haltLoop$
unused_handler:			.word	haltLoop$
irq_handler:				.word	Setting
fiq_handler:				.word	haltLoop$
