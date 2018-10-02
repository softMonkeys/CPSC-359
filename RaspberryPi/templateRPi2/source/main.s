.section    .init
.globl     _start

_start:
    b       main
    
.section .text

main:
   	mov     	sp, #0x8000
	bl		EnableJTAG
	
	//Example of assembly code; (you can put your own)
	mov		r0, #5
    mov     r3, #8

    add     r0, r3

haltLoop$:
	b		haltLoop$


.section .data


