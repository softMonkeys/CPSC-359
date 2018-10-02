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
main:
          bl    InstallIntTable   // call InstallIntTable function
          bl    EnableJTAG    // Enable JTAG
          bl		InitFrameBuffer   // initialize the framebuffer
          bl    drawIntroduction    // draw the introduction page
          bl    drawIndicatorAtStart    // display the indicator
          bl    controller    // branch to controller

// Define an infinte loop for interrupt
.global   haltLoop$
haltLoop$:b     haltLoop$   // Infinite loop at the end of program
