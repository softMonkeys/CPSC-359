.section    .init
.globl     _start

_start:
    b       main
    
.section .text

main:
    bl		InstallIntTable			// *** MUST COME FIRST, sets the stack pointer
	
	bl		EnableJTAG

	bl		InitLED					// initialize the LED (pin 47 to output)
	bl		InitSNES				// initialize the SNES controller

	mov		r0, #1
	bl		SetLATLevel				// set the Latch line high, so the B button changes the Data line


	// set the Rising Edge detect bit for GPIO line 10 (on the device)
	ldr		r0, =0x3F20004C
	ldr		r1, [r0]
	orr		r1, #0x400				// set bit 10
	str		r1, [r0]

	// enable GPIO IRQ lines on Interrupt Controller
	ldr		r0, =0x3F00B214			// Enable IRQs 2
	mov		r1, #0x001E0000			// bits 17 to 20 set (IRQs 49 to 52)
	str		r1, [r0]

	// Enable IRQ
	mrs		r0, cpsr
	bic		r0, #0x80
	msr		cpsr_c, r0

ledLoop$:
	ldr		r1, =SNESDat
	ldr		r0, [r1]
	bl		SetLEDLevel

	b		ledLoop$
    
hang:
	b		hang

InstallIntTable:
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

irq:
	push	{r0-r12, lr}

	// test if there is an interrupt pending in IRQ Pending 2
	ldr		r0, =0x3F00B200
	ldr		r1, [r0]
	tst		r1, #0x200		// bit 9
	beq		irqEnd

	// test that at least one GPIO IRQ line caused the interrupt
	ldr		r0, =0x3F00B208		// IRQ Pending 2 register
	ldr		r1, [r0]
	tst		r1, #0x001E0000
	beq		irqEnd

	// test if GPIO line 10 caused the interrupt
	ldr		r0, =0x3F200040		// GPIO event detect status register
	ldr		r1, [r0]
	tst		r1, #0x400			// bit 10
	beq		irqEnd

	// invert the LSB of SNESDat
	ldr		r0, =SNESDat
	ldr		r1, [r0]
	eor		r1, #1
	str		r1, [r0]

	// clear bit 10 in the event detect register
	ldr		r0, =0x3F200040
	mov		r1, #0x400
	str		r1, [r0]
	
irqEnd:
	pop		{r0-r12, lr}
	subs	pc, lr, #4

.section .data

SNESDat:
	.int	0

IntTable:
	// Interrupt Vector Table (16 words)
	ldr		pc, reset_handler
	ldr		pc, undefined_handler
	ldr		pc, swi_handler
	ldr		pc, prefetch_handler
	ldr		pc, data_handler
	ldr		pc, unused_handler
	ldr		pc, irq_handler
	ldr		pc, fiq_handler

reset_handler:		.word InstallIntTable
undefined_handler:	.word hang
swi_handler:		.word hang
prefetch_handler:	.word hang
data_handler:		.word hang
unused_handler:		.word hang
irq_handler:		.word irq
fiq_handler:		.word hang

