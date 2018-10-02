.section    .init
.globl     _start

_start:
    b       main

.section .text

main:
    mov     sp, #0x8000

	bl		EnableJTAG
	bl		InitFrameBuffer
  bl    clearScreen

  bl    drawMainMenu

  bl    drawPointerStartM

  bl    controller

haltLoop$:
	b		haltLoop$
