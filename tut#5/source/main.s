// Initialization Section
.section    	.init
.globl      	_start	// Jump to beginning of code

_start:     	b       main

// Coding Section
.section    	.text
main:		mov     sp, #0x8000	// Initializing the stack pointer
		bl      EnableJTAG    	// Enable JTAG

    ldr   r0, =0x3F200010
    ldr   r1, [r0]

    mov   r2, #0b111
    bic   r1, r2, lsl #21

    mov   r2, #0b001
    orr   r1, r2, lsl #21

    str   r1, [r0]
loop:
    // Set GPIO 47: turn ACT LED on
    ldr   r0, =0x3F200020  // set register 1, SETn(n = 32...53)
    mov   r1, #0x00000001   // 1 << (47 - 32 = 15)
    lsl   r1, #15
    str   r1, [r0]

    ldr r0, =0x3F003004   // address of CLO
    ldr r1, [r0]    // read CLO
    ldr r3, =0x000F4240   // add 12 micros
    add r1, r3
    waitLoop:
    ldr r2, [r0]
    cmp r1, r2 // stop when CLO = r1
    bhi waitLoop

    // Clear GPIO 47: turn ACT LED off
    ldr   r0, =0x3F20002C // clear register 1, CLRn(n = 32...53)
    mov   r1, #0x00000001    // 1 << (47 - 32 = 15)
    lsl   r1, #15
    str   r1, [r0]


    ldr r0, =0x3F003004 // address of CLO
    ldr r1, [r0] // read CLO
    ldr r3, =0x000F4240 // add 12 micros
    add r1, r3
    waitLoop1:
    ldr r2, [r0]
    cmp r1, r2 // stop when CLO = r1
    bhi waitLoop1

    b     loop

haltLoop$:  	b	haltLoop$ 	// Infinite loop at end of program
