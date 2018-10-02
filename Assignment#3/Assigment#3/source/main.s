// Created by:
//   Jiongkai Jiang 10138743
//   BenKun Chen 30005337
// Section: T01

// Initialization section
.section  .init
.global   _start

_start:   b   main

// Coding section
.section  .text
main:     mov sp, #0x8000 // Initializing the stack pointer
          bl  EnableJTAG  // Enable JTAG
          bl  InitUART    // Initializing the UART
          // Introduction
          ldr r0, =name   // Load name buffer o r0
          mov r1, #45     // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          // Initializing the LATCH, DATA and CLOCK GPIO lines
          mov r0, #9
          mov r4, #1
          bl  Init_GPIO   // Call Init_GPIO function
          mov r0, #10
          mov r4, #0
          bl  Init_GPIO   // Call Init_GPIO function
          mov r0, #11
          mov r4, #1
          bl  Init_GPIO   // Call Init_GPIO function
          mov r4, #0     // reset r4 into 0
          // Ask question for the first time in order to avoid multiple same button pressed
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27     // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          bl  Read_SNES   // call Read_SNES function to get the 16 bits data output
          mov r5, r0
          bl  Print_Message   // call Print_Message to print the button pressed by user
// Loop to keep tracking the input from SNES controller and print the appropriate button pressed by user on screen
ask:      ldr r0, =0x0000C350
          bl  Wait    // To wait 0.05s in the starting of each loop to avoid running out of memory
          bl  Read_SNES   // call Read_SNES function to get the 16 bits data output
          cmp r5, r0    // compare the previous 16 bits data ouput with the current data output in order to avoid multiple same button pressed
          beq ask
          mov r5, r0
          bl  Print_Message   // call Print_Message to print the button pressed by user
// The end of the program
haltLoop$:b   haltLoop$   // Infinite loop at the end of program

// Subroutines section
// Initializes a GPIO line subroutine
Init_GPIO:cmp r0, #9    // If the parameter equals to 9, it mean GPIO9(LATCH)
          beq pin9
          cmp r0, #10   // If the parameter equals to 10, it mean GPIO10(DATA); else, it is GPIO11(CLOCK)
          beq pin10
          // Initializes Clock
          ldr r0, =0x3F200004   // address for GPFSEL1
          ldr r1, [r0]    // copy GPFSEL1 into r1
          mov r2, #7    // (b0111)
          lsl r2, #3    // index of 1st bit for pin11
          bic r1, r2    // clear bits
          mov r3, r4    // output function code
          lsl r3, #3    // r3 = 0 001 000
          orr r1, r3    // set pin11 function in r1
          str r1, [r0]   // write back to GPFSEL1
          bx  lr
          // Initializes Data
pin10:    ldr r0, =0x3F200004   // address for GPFSEL1
          ldr r1, [r0]    // copy GPFSEL1 into r1
          mov r2, #7    // (b0111)
          bic r1, r2    // clear bits
          mov r3, r4    // output function code
          orr r1, r3    // set pin10 function in r1
          str r1, [r0]   // write back to GPFSEL1
          bx  lr
          // Initializes Latch
pin9:     ldr r0, =0x3F200000   // address for GPFSEL0
          ldr r1, [r0]    // copy GPFSEL0 into r1
          mov r2, #7    // (b0111)
          lsl r2, #27   // index of 1st bit for pin9
          bic r1, r2    // clear bits
          mov r3, r4    // output function code
          lsl r3, #27    //r3 = 001 000 000 000 000 000 000 000 000 000
          orr r1, r3    // set pin9 function in r1
          str r1, [r0]     // write back to GPFSEL0
          bx  lr

// Writes a bit to the GPIO latch line
Write_Latch:
          // r1 = value to write{0, 1}
          mov r0, #9    // pin#9 = LATCH line
          ldr r2, =0x3F200000   // base GPIO register
          mov r3, #1
          lsl r3, r0    // align bit for pin #9
          teq r1, #0
          streq r3, [r2, #40]   // GPCLR0
          strne r3, [r2, #28]   // GPSET0
          bx  lr

// Writes a value to the GPIO Clock line
Write_Clock:
          // r1 = value to write{0, 1}
          mov r0, #11    // pin#11 = CLOCK line
          ldr r2, =0x3F200000   // base GPIO register
          mov r3, #1
          lsl r3, r0    // align bit for pin #9
          teq r1, #0
          streq r3, [r2, #40]   // GPCLR0
          strne r3, [r2, #28]   // GPSET0
          bx  lr

// Reads a bit from the GPIO data line
Read_Data:mov r0, #10   // pin#10 is the pin for SNES Controller(DAT)
          ldr r2, =0x3F200000   // base GPIO register
          ldr r1, [r2, #52]   // GPLEV0 (0x34)
          mov r3, #1
          lsl r3, r0    // align pin#10 bit
          and r1, r3    // mask everyting else
          teq r1, #0
          moveq r0, #0  // return 0
          movne r0, #1  // return 1
          bx  lr
// Waits for a time interval, passed as a parameter
Wait:     mov r3, r0    // move the time into r3
          ldr r0, =0x3F003004   // address of CLO
          ldr r1, [r0]    // read CLO
          add r1, r3
          waitLoop:
          ldr r2, [r0]
          cmp r1, r2    // stop when CLO = r1
          bhi waitLoop
          bx  lr
// Main SNES subroutine that reads input (buttons pressed) from a SNES controller
Read_SNES:push  {r4, r5, lr}    // Created local variable r4 and r5
          mov r5, #0    // register sampling buttons
          mov r1, #1
          bl  Write_Latch   //writeGPIO(LATCH,#1)
          mov r1, #1
          bl  Write_Clock   //writeGPIO(CLOCK,#1)
          mov r0, #12
          bl  Wait    // signal to SNES to sample buttons
          mov r1, #0
          bl  Write_Latch   //writeGPIO(LATCH,#0)
          mov r4, #0   // counter i
loop:     mov r0, #6
          bl  Wait    // wait(6 micro seconds)
          mov r1, #0
          bl  Write_Clock   // falling edge
          mov r0, #6
          bl  Wait    // wait(6 micro seconds)
          bl  Read_Data   // read bit i
          lsl r0, r4
          orr r5, r0
          mov r1, #1
          bl  Write_Clock   // rising edge; new cycle
          add r4, #1    // i++
          cmp r4, #16
          blt loop    //if (i < 16) branch pulseLoop
          mov r0, r5    // return value(16-bit numbers)
          pop {r4, r5, lr}
          bx  lr
// Prints an appropriate message to the UART terminal (Press a button, You pressed X, etc ..)
Print_Message:
          // B Button
          mov r4, r5    // pass the parameter into r4
          and r4, #1
          cmp r4, #0
          bne button2   // if there is no data input, skip the code below
          ldr	r0, =Button_1_Msg   // Load name buffer o r0
          mov	r1, #21   // Store the length of name's string into r1
          bl	WriteStringUART    // Display the string
          // Ask question
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27   // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          b   ask
          // Y Button
button2:  mov r4, r5
          lsr r4, #1    // left shift 1 to check the next digit in 16-bit
          and r4, #1
          cmp r4, #0
          bne button3
          ldr	r0, =Button_2_Msg   // Load name buffer o r0
        	mov	r1, #21    // Store the length of name's string into r1
        	bl	WriteStringUART   // Display the string
          // Ask question
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27   // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          b   ask
          // SELECT Button
button3:  mov r4, r5
          lsr r4, #2    // left shift 2 to check the next digit in 16-bit
          and r4, #1
          cmp r4, #0
          bne button4
          ldr	r0, =Button_3_Msg   // Load name buffer o r0
        	mov	r1, #26    // Store the length of name's string into r1
        	bl	WriteStringUART   // Display the string
          // Ask question
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27   // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          b   ask
          // TERMINATE Button
button4:  mov r4, r5
          lsr r4, #3    // left shift 3 to check the next digit in 16-bit
          and r4, #1
          cmp r4, #0
          bne button5
          ldr	r0, =Button_4_Msg   // Load name buffer o r0
        	mov	r1, #25    // Store the length of name's string into r1
        	bl	WriteStringUART   // Display the string
          b   haltLoop$ // terminate the program
          // Joy-pad UP Button
button5:  mov r4, r5
          lsr r4, #4    // left shift 4 to check the next digit in 16-bit
          and r4, #1
          cmp r4, #0
          bne button6
          ldr	r0, =Button_5_Msg   // Load name buffer o r0
        	mov	r1, #30    // Store the length of name's string into r1
        	bl	WriteStringUART   // Display the string
          // Ask question
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27   // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          b   ask
          // Joy-pad DOWN Button
button6:  mov r4, r5
          lsr r4, #5    // left shift 5 to check the next digit in 16-bit
          and r4, #1
          cmp r4, #0
          bne button7
          ldr	r0, =Button_6_Msg   // Load name buffer o r0
        	mov	r1, #32    // Store the length of name's string into r1
        	bl	WriteStringUART   // Display the string
          // Ask question
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27   // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          b   ask
          // Joy-pad LEFT Button
button7:  mov r4, r5
          lsr r4, #6    // left shift 6 to check the next digit in 16-bit
          and r4, #1
          cmp r4, #0
          bne button8
          ldr	r0, =Button_7_Msg   // Load name buffer o r0
        	mov	r1, #32    // Store the length of name's string into r1
        	bl	WriteStringUART   // Display the string
          // Ask question
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27   // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          b   ask
          // Joy-pad RIGHT Button
button8:  mov r4, r5
          lsr r4, #7    // left shift 7 to check the next digit in 16-bit
          and r4, #1
          cmp r4, #0
          bne button9
          ldr	r0, =Button_8_Msg   // Load name buffer o r0
          mov	r1, #33   // Store the length of name's string into r1
          bl	WriteStringUART    // Display the string
          // Ask question
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27   // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          b   ask
          // A Button
button9:  mov r4, r5
          lsr r4, #8    // left shift 8 to check the next digit in 16-bit
          and r4, #1
          cmp r4, #0
          bne button10
          ldr	r0, =Button_9_Msg   // Load name buffer o r0
        	mov	r1, #21    // Store the length of name's string into r1
        	bl	WriteStringUART   // Display the string
          // Ask question
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27   // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          b   ask
          // X Button
button10: mov r4, r5
          lsr r4, #9    // left shift 9 to check the next digit in 16-bit
          and r4, #1
          cmp r4, #0
          bne button11
          ldr	r0, =Button_10_Msg    // Load name buffer o r0
        	mov	r1, #21    // Store the length of name's string into r1
        	bl	WriteStringUART   // Display the string
          // Ask question
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27   // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          b   ask
          // LEFT Button
button11: mov r4, r5
          lsr r4, #10   // left shift 10 to check the next digit in 16-bit
          and r4, #1
          cmp r4, #0
          bne button12
          ldr	r0, =Button_11_Msg    // Load name buffer o r0
        	mov	r1, #24    // Store the length of name's string into r1
        	bl	WriteStringUART   // Display the string
          // Ask question
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27   // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          b   ask
          // RIGHT Button
button12: mov r4, r5
          lsr r4, #11   // left shift 11 to check the next digit in 16-bit
          and r4, #1
          cmp r4, #0
          bne ask
          ldr	r0, =Button_12_Msg
        	mov	r1, #25    // Store the length of name's string into r1
        	bl	WriteStringUART   // Display the string
          // Ask question
          ldr r0, =question   // Load name buffer o r0
          mov r1, #27   // Store the length of name's string into r1
          bl  WriteStringUART   // Display the string
          b ask
// Data section
.section  .data
.align    2
name:     .ascii  "Created By: Jiongkai Jiang and BenKun Chen\n\n\r"
question: .ascii  "Please press a button...\n\n\r"
Button_1_Msg:
        .ascii  "You have pressed B\n\n\r"
Button_2_Msg:
        .ascii  "You have pressed Y\n\n\r"
Button_3_Msg:
        .ascii  "You have pressed Select\n\n\r"
Button_4_Msg:
        .ascii  "Program is terminating\n\n\r"
Button_5_Msg:
        .ascii  "You have pressed Joy-pad UP\n\n\r"
Button_6_Msg:
        .ascii  "You have pressed Joy-pad DOWN\n\n\r"
Button_7_Msg:
        .ascii  "You have pressed Joy-pad LEFT\n\n\r"
Button_8_Msg:
        .ascii  "You have pressed Joy-pad RIGHT\n\n\r"
Button_9_Msg:
        .ascii  "You have pressed A\n\n\r"
Button_10_Msg:
        .ascii  "You have pressed X\n\n\r"
Button_11_Msg:
        .ascii  "You have pressed Left\n\n\r"
Button_12_Msg:
        .ascii  "You have pressed Right\n\n\r"
