// Created by:
//   Jiongkai Jiang 10138743
//   BenKun Chen 30005337
// Section: T01

// Initialization section
.section  .init
.global   _start

_start:   b   main

// Coding section
.section .text

main:     mov   sp, #0x8000   // Initializing the stack pointer
          bl    EnableJTAG    // Enable JTAG
          bl		InitFrameBuffer
          //bl    clearScreen
          bl    drawIntroduction
          bl    drawIndicatorAtStart
          bl    controller
      

haltLoop$:b     haltLoop$   // Infinite loop at the end of program
