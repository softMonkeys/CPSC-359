.section    .init
.globl     _start

_start:
    b       main

.section .text

main:
    	mov     	sp, #0x8000 // Initializing the stack pointer
	bl		EnableJTAG // Enable JTAG
	bl		InitUART    // Initialize the UART


// This will read the user characters from UART and save into the buffer.

	ldr	r0, =ABuff
	mov	r1, #256
	bl	ReadLineUART

// when you press enter, you will have "foo" printed on a new line
	ldr	r0, =foo
	mov	r1, #4
	bl	WriteStringUART

haltLoop$:
	b	haltLoop$

.section .data

.align	2
AnInteger:
	.int 42
AStructure:
	.byte 	12
	.hword	0xA3

foo:
	.ascii	"\nfoo"
	.asciz	"bar"

ABuff:
	.rept	256
	.byte	0
	.endr

SomeNumbers:
	.int	2*3
	.int	4,5,6
	.int	ABuff

NumNumbers:
	.int	(.-SomeNumbers)/4
