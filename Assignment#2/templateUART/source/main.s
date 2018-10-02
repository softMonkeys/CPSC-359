// Created by:
// Jiongkai Jiang 10138743
// BenKun Chen 30005337
// Section: T01
// Initialization Section
.section    	.init
.globl      	_start	// Jump to beginning of code

_start:     	b       main

// Coding Section
.section    	.text
main:		mov     sp, #0x8000	// Initializing the stack pointer
		bl      EnableJTAG    	// Enable JTAG
		bl      InitUART    	// Initialize the UART

        	// Introduction
        	ldr     r0, =Intro	// Load Intro buffer to r0
        	mov     r1, #44		// R1 store the length of the Intro String
        	bl      WriteStringUART	// Display the Intro string

        	mov     r9, #0		// Initializing number of stars for square
        	mov     r10, #0   	// Initializing number of stars for rectangle
        	mov     r11, #0   	// Initializing number of stars for triangle

next:           ldr     r0, =question   // Load question buffer to r0
        	mov     r1, #125	// R1 store the length of the question string
        	bl      WriteStringUART	// Display the question string

        	// Error checking
loop:       	ldr     r0, =ABuff	// Load ABuff buffer to r0
        	mov     r1, #256	// R1 store the lenght constrain of the input
        	bl      ReadLineUART	// Store the input to the ABuff

		// The valid 1 byte inputs are 1, 2, 3 and q
		cmp     r0, #1          // R0 store the length of the input value, make sure the input value is one byte
        	bne     negative	// If user input not equal to 1 byte, it will go to the negative lable
        	ldr     r2, =ABuff	// Register R2 has a address of ABuff
        	ldrb    r4, [r2]	// Store the valid one byte input into r4
        	sub     r4, #48   	// Convert the ASCII value into integer
        	cmp     r4, #1          // Compare the valid one byte input with 1
        	beq     valid   	// If user input is 1, it is a valid input
        	ldrb    r4, [r2]
        	sub     r4, #48
        	cmp     r4, #2		// Compare the valid one byte input with 2
        	beq     valid   	// If user input is 2, it is a valid input
        	ldrb    r4, [r2]
        	sub     r4, #48
        	cmp     r4, #3		// Compare the vaild one byte input with 3
        	beq     valid    	// If user input is 3, it is a valid input
        	ldrb    r4, [r2]
        	cmp     r4, #113	// Compare the vaild one byte input with q
        	bne     error   	// If user input is q, it will terminate the program, else the will show the error message, and people have to enter a new value
		ldr	r0, =exitProgram
		mov	r1, #20
		bl	WriteStringUART // Display the exit message
                b       haltLoop$

		// The only case for a valid 2 bytes input is -1
negative:   	cmp     r0, #2          // R0 store the length of the input value, make sure the input value is two bytes
        	bne     error   	// Since the maximum bytes that user is allowed to input is 2, if user input has more than 2 bytes, it is invalid
                ldr     r2, =ABuff	// Register R2 has a address of ABuff
        	ldrb    r4, [r2]    	// Load the first byte of user's input
        	cmp     r4, #45		// Compare the first byte input with -
        	bne     error   	// If the first byte is not the negative sign "-", it is invalid
        	ldrb    r4, [r2, #1]    // Load the second byte of the user's input
        	sub     r4, #48   	// Convert the ASCII value into integer
        	cmp     r4, #1		// Compare the second byte input with 1
        	beq     summary		// If the the two bytes input is not valid, it will display an error message,  and people have to enter a new value

		// Error message for number of object
error:      	ldr     r0, =false
        	mov     r1, #186
        	bl      WriteStringUART
        	b       loop

		// Error message for length of width
errorWidth: 	ldr     r0, =invalid
        	mov     r1, #53
        	bl      WriteStringUART

		// Test the input value to make sure it is between 3 and 9. If the input value is not in this range, error message will be displied, and people have to re-enter the value.
valid:      	ldr     r0, =width
        	mov     r1, #71
        	bl      WriteStringUART
        	ldr     r0, =ABuff
        	mov     r1, #256
        	bl      ReadLineUART
        	cmp     r0, #1		// Make sure the input value is one byte
        	bne     errorWidth	// If the input value is not one byte, error message will be display, and peole have to re-enter the value
        	ldr     r2, =ABuff
        	ldrb    r3, [r2]
        	sub     r3, #48
        	cmp     r3, #3		// Make sure the input value is >= 3
        	blt     errorWidth
        	cmp     r3, #9		// Make sure the inout value is <= 9
        	bgt     errorWidth

		// Draw the object
choice:   	cmp	r4, #1		// If the input value is 1, and the width of the square is correct, a square will be drew on the screen
		beq	SQUARE
		cmp	r4, #2		// If the input value is 2, and the width of the rectangle is correct, a rectangle will be drew on the screen
		beq	RECTANGLE

        	mov     r7, r3		// Store the width into r3
        	mov     r8, r3		// Store the width into r4

		// Calculate the total stars of triangles
decrement:	sub     r7, #1
        	add     r8, r7
        	cmp     r7, #1
        	bgt     decrement
        	add     r11, r8

		// If the input value is 3, and the width of the triangel is correct, a triangle will be drew on the screen
		// The base of the triangle will be the width. When the level goes up, the number of stars will be width-1
        	mov     r5, r3
        	mov     r12, #0
        	mov     r8, #0
        	mov     r7, #0

inner0:   	cmp     r8, r5
        	bge     inner01
        	ldr     r0, =space	// Draw " "
        	mov     r1, #1
        	bl      WriteStringUART
        	add     r8, #1
        	b       inner0

inner01:  	cmp     r7, r12
        	bgt     outter0
        	ldr     r0, =star
        	mov     r1, #2
        	bl      WriteStringUART	// Draw "* "
        	add     r7, #1
        	b       inner01


outter0:  	add     r12, #1
        	cmp     r12, r3
        	beq     last0

        	ldr     r0, =newLine
        	mov     r1, #2
        	bl      WriteStringUART	// Draw "\n\r"
        	sub     r5, #1
        	mov     r8, #0
        	mov     r7, #0
        	b       inner0

last0:    	ldr     r0, =newLine
        	mov     r1, #2
        	bl      WriteStringUART
        	b       next		// Ask to enter a new choice

		// Calculate the the total stars of squares
SQUARE:		mul     r7, r3, r3
        	add     r9, r7
        	mov     r7, #0
        	mov     r8, #0

		// If the input value is 1, and the width of the square is correct, a square will be drew on the screen
inner:    	cmp     r8, r3
        	bge     outter
        	ldr     r0, =star
        	mov     r1, #2
        	bl      WriteStringUART // Draw "* "
        	add     r8, #1
        	b       inner

outter:   	add     r7, #1
        	cmp     r7, r3
        	beq     last

        	ldr     r0, =newLine
        	mov     r1, #2
        	bl      WriteStringUART	// Draw "\n\r"
        	mov     r8, #0
        	b       inner

last:     	ldr     r0, =newLine
        	mov     r1, #2
        	bl      WriteStringUART
        	b       next		// Ask to enter a new choice

		// Calculate the the total stars of rectangles
RECTANGLE:	mov     r5, r3
        	sub     r5, #2
        	mov     r7, r3
        	mul     r7, r5
        	add     r10, r7
        	mov     r7, #0
        	mov     r8, #0

		// If the input value is 2, and the width of the rectangle is correct, a retangel will be drew on the screen
		// The height of the rectangle will be width-2
inner1:   	cmp     r8, r3
        	bge     outter1
        	ldr     r0, =star
        	mov     r1, #2
        	bl      WriteStringUART	// Draw "* "
        	add     r8, #1
        	b       inner1

outter1:  	add     r7, #1
        	cmp     r7, r5
        	beq     last1

        	ldr     r0, =newLine
        	mov     r1, #2
        	bl      WriteStringUART	// Draw "\n\r"
        	mov     r8, #0
        	b       inner1

last1:    	ldr     r0, =newLine
        	mov     r1, #2
        	bl      WriteStringUART
        	b       next		// Ask to enter a new choice

		// Caculate the total number of stars
summary:  	mov     r0, #0
        	add     r0, r9, r10
        	add     r0, r11

        	// Caculate the square mean
        	mov     r1, #10
        	mul     r9, r1
        	mov     r1, #0
        	udiv    r1, r9, r0

        	// Calculate rectangle mean
        	mov     r2, #10
        	mul     r10, r2
        	mov     r2, #0
        	udiv    r2, r10, r0

		// Calculate triangle mean
        	mov     r3, #10
        	mul     r11, r3
        	mov     r3, #0
        	udiv    r3, r11, r0

		// Check if total number of star is 0
        	cmp     r0, #0
        	bne     twoMeanZero       // If total number of stars are not zero and only one kind of shape has been drew, one of the mean value will be one and the rest of the mean values will be zero
		// Display "Total Number of Stars is: 0"
		ldr     r0, =totalStars
        	mov     r1, #26
        	bl      WriteStringUART
        	ldr     r0, =zero
        	mov     r1, #3
        	bl      WriteStringUART
		// Display "Mean of Stars used to draw Square(s): 0"
        	ldr     r0, =meanSquare
        	mov     r1, #38
        	bl      WriteStringUART
        	ldr     r0, =zero
        	mov     r1, #3
        	bl      WriteStringUART
		// "Mean of Stars used to draw Rectangle(s): 0"
        	ldr     r0, =meanRectangle
        	mov     r1, #41
        	bl      WriteStringUART
        	ldr     r0, =zero
          	mov     r1, #3
        	bl      WriteStringUART
		// "Mean of Stars used to draw Triangle(s): 0"
        	ldr     r0, =meanTriangle
        	mov     r1, #40
        	bl      WriteStringUART
        	ldr     r0, =zero
        	mov     r1, #3
        	bl      WriteStringUART
        	b       next

		// If total number of star is not zero
twoMeanZero:	mov     r4, #10		// move integer 10 into register r4
		udiv    r9, r4		// divide register r9 by r4
		cmp     r0, r9		// compare if total number of stars equal to the total number of square
		beq     outputMeanSqu	// if equal, branch to the outputMeanSqu
		udiv    r10, r4			// divide register r10 by r4
		cmp     r0, r10		// compare if total number of stars equal to the total number of rectangle
		beq     outputMeanRec	// if equal, branch to the outputMeanRec
		udiv    r11, r4		// divide register r11 by r4
		cmp     r0, r11		// compare if total number of stars equal to the total number of triangle
		beq     outputMeanTri	// if equal, branch to the outputMeanRec

		// If each of three objects' total number of stars is not equal to the total stars, they all have mean value
        	mov     r9, r1		// move the value of register r1 into r9
        	mov     r10, r2		// move the value of register r2 into r10
        	mov     r11, r3		// move the value of register r3 into r11
        	mov     r4, r0		// move the value of register r0 into r4
        	mov     r5, #1		// move 1 into the register r11
        	mov     r6, #10		// move 10 into the register r6
        	cmp     r4, #10		// if total number of stars < 10, just print single digit
        	blt     printSingleD	// branch to the printSingleD

checkD:   	cmp     r4, #10		// compare the value of r4 and 10
        	blt     doneD		// if r4 is smaller than 10, branch to doneD
        	udiv    r4, r6		//divide register r4 by r6
        	add     r5, #1        	// calculate the counter
        	b       checkD		// branch to checkD

doneD:    	sub     r5, #1        	// a = 10^(counter - 1)
        	mov     r7, #10		// move 10 into the register r7

check1D:  	cmp     r5, #1		// compare the value of a and 1
        	beq     done1D		// if equal, branch to done1D
        	mul     r6, r7		// multiple the value in register in r6 by r7
        	sub     r5, #1		// subtract the value in register r6 by 1
        	b       check1D		// branch to check1D
done1D:   	mov     r5, r0        	// a is calculated
        	mov     r7, r0		// move the value of register r0 into r7
        	ldr     r0, =totalStars	// load the base address of totalStars into r0
        	mov     r1, #26		// move 26 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function

check2D:  	udiv	r5, r6		//divide register r5 by r6
        	mov     r8, r5		// move the value of register r5 into r8
        	ldr     r4, =totalNumBuff// load the base address of totalNumBuff into r4
        	add     r8, #48		// add 48 to the value of register r8
        	strb    r8, [r4]	// store the ASCII value into the base address
        	ldr     r0, =totalNumBuff// load the base address of totalNumBuff into r0
        	mov     r1, #1		// move 1 into the register r1
        	bl      WriteStringUART// call WriteStringUART function
        	mul     r5, r6		// multiple the value in register in r5 by r6
        	sub     r7, r5		// subtract the value in register r7 by r5
        	mov     r4, #10		// move 10 into the register r4
        	udiv    r6, r4		//divide register r6 by r4
        	mov     r5, r7		// move the value of register r7 into r5
        	cmp     r6, #1		// compare the value of r6 and 1
        	bge     check2D		// if greater and equal to, branch to check2D
        	ldr     r0, =newLine	// load the base address of newLine into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function

next1D:   	ldr     r0, =meanSquare	// load the base address of meanSquare into r0
        	mov     r1, #38		// move 38 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =decimal	// load the base address of decimal into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r4, =totalNumBuff// load the base address of totalNumBuff into r4
        	add     r9, #48		// add 48 to the value of register r9
        	strb    r9, [r4]	// store the ASCII value into the base address
        	ldr     r0, =totalNumBuff// load the base address of totalNumBuff into r0
        	mov     r1, #1		// move 1 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =newLine	// load the base address of newLine into r0
        	mov     r1, #2		// move 2 into the register r2
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =meanRectangle// load the base address of meanRectangle into r0
        	mov     r1, #41		// move 41 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =decimal	// load the base address of decimal into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r4, =totalNumBuff// load the base address of totalNumBuff into r4
        	add     r10, #48	// add 48 to the value of register r10
        	strb    r10, [r4]	// store the ASCII value into the base address
        	ldr     r0, =totalNumBuff// load the base address of totalNumBuff into r0
        	mov     r1, #1		// move 1 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =newLine	// load the base address of newLine into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =meanTriangle// load the base address of meanTriangle into r0
        	mov     r1, #40		// move 40 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =decimal	// load the base address of decimal into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r4, =totalNumBuff// load the base address of totalNumBuff into r4
        	add     r11, #48	// add 48 to the value of register r11
        	strb    r11, [r4]	// store the ASCII value into the base address
        	ldr     r0, =totalNumBuff// load the base address of totalNumBuff into r0
        	mov     r1, #1		// move 1 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =newLine	// load the base address of newLine into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	b       next		// branch to next

printSingleD:	add     r4, #48		// add 48 to the value of register r4
        	ldr     r5, =totalNumBuff// load the base address of totalNumBuff into r5
        	strb    r4, [r5]	// store the ASCII value into the base address
        	ldr     r0, =totalStars	// load the base address of totalStars into r0
        	mov     r1, #26		// move 26 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =totalNumBuff// load the base address of totalNumBuff into r0
        	mov     r1, #1		// move 1 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =newLine	// load the base address of newLine into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	b       next1D		// branch to check1D

outputMeanSqu:	mov     r4, r0		// move the value of register r0 into r4
        	mov     r5, #1		// move 1 into the register r5
        	mov     r6, #10		// move 10 into the register r6
        	cmp     r4, #10         // if total number of stars < 10, just print single digit
        	blt     printSingle	// if less than, branch to printSingle

check:    	cmp     r4, #10		// compare the value of r4 and 10
        	blt     done		// if less than, branch to done
        	udiv    r4, r6		//divide register r4 by r6
        	add     r5, #1        	// calculate the counter
        	b       check		// branch to check

done:     	sub     r5, #1        	// a = 10^(counter - 1)
        	mov     r7, #10		// move 10 into the register r7

check1:   	cmp     r5, #1		// compare the value of r5 and 1
        	beq     done1		// if equal, branch to done1
        	mul     r6, r7		// multiple the value in register in r6 by r7
        	sub     r5, #1		// subtract the value in register r5 by 1
        	b       check1		// branch to check1

done1:    	mov     r5, r0        	// a is calculated
        	mov     r7, r0		// move the value of register r0 into r7
        	ldr     r0, =totalStars	// load the base address of totalStars into r0
        	mov     r1, #26		// move 26 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function

check2:   	udiv    r5, r6		//divide register r5 by r6
        	mov     r8, r5		// move the value of register r5 into r8
        	ldr     r4, =totalNumBuff// load the base address of totalNumBuff into r4
        	add     r8, #48		// add 48 to the value of register r8
        	strb    r8, [r4]	// store the ASCII value into the base address
        	ldr     r0, =totalNumBuff// load the base address of totalNumBuff into r0
        	mov     r1, #1		// move 1 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	mul     r5, r6		// multiple the value in register in r5 by r6
        	sub     r7, r5		// subtract the value in register r7 by r5
        	mov     r4, #10		// move 10 into the register r4
        	udiv    r6, r4		//divide register r6 by r4
        	mov     r5, r7		// move the value of register r7 into r5
        	cmp     r6, #1		// compare the value of r6 and 1
        	bge     check2		// if greater and equal to, branch to check2
        	ldr     r0, =newLine	// load the base address of newLine into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function

next1:    	ldr     r0, =meanSquare	// load the base address of meanSquare into r0
        	mov     r1, #38		// move 38 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =one	// load the base address of one into r0
        	mov     r1, #3		// move 3 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =meanRectangle// load the base address of meanRectangle into r0
        	mov     r1, #41		// move 41 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =zero	// load the base address of zero into r0
        	mov     r1, #3		// move 3 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =meanTriangle// load the base address of meanTriangle into r0
        	mov     r1, #40		// move 40 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =zero	// load the base address of zero into r0
        	mov     r1, #3		// move 3 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	b       next		// branch to next

printSingle:	add     r4, #48		// add 48 to the value of register r4
        	ldr     r5, =totalNumBuff// load the base address of totalNumBuff into r5
        	strb    r4, [r5]	// store the ASCII value into the base address
        	ldr     r0, =totalStars	// load the base address of totalStars into r0
        	mov     r1, #26		// move 26 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =totalNumBuff// load the base address of totalNumBuff into r0
        	mov     r1, #1		// move 1 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =newLine	// load the base address of newLine into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	b       next1		// branch to next1

outputMeanRec:	mov     r4, r0		// move the value of register r0 into r4
        	mov     r5, #1		// move 1 into the register r5
        	mov     r6, #10		// move 10 into the register r6
        	cmp     r4, #10         // if total number of stars < 10, just print single digit
        	blt     printSingleB	// if less than, branch to printSingleB

checkB:   	cmp     r4, #10		// compare the value of r4 and 10
        	blt     doneB		// if less than, branch to doneB
        	udiv    r4, r6		//divide register r4 by r6
        	add     r5, #1        	// calculate the counter
        	b       checkB		// branch to checkB

doneB:    	sub     r5, #1        	// a = 10^(counter - 1)
        	mov     r7, #10		// move 10 into the register r7

check1B:  	cmp     r5, #1		// compare the value of r5 and 1
        	beq     done1B		// if equal, branch to done1B
        	mul     r6, r7		// multiple the value in register in r6 by r7
        	sub     r5, #1		// subtract the value in register r5 by 1
        	b       check1B		// branch to check1B

done1B:   	mov     r5, r0        	// a is calculated
        	mov     r7, r0		// move the value of register r0 into r7
        	ldr     r0, =totalStars	// load the base address of totalStars into r0
        	mov     r1, #26		// move 26 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function

check2B:  	udiv    r5, r6		//divide register r5 by r6
        	mov     r8, r5		// move the value of register r5 into r8
        	ldr     r4, =totalNumBuff// load the base address of totalNumBuff into r4
        	add     r8, #48		// add 48 to the value of register r8
        	strb    r8, [r4]	// store the ASCII value into the base address
        	ldr     r0, =totalNumBuff// load the base address of totalNumBuff into r0
        	mov     r1, #1		// move 1 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	mul     r5, r6		// multiple the value in register in r5 by r6
        	sub     r7, r5		// subtract the value in register r7 by r5
        	mov     r4, #10		// move 10 into the register r4
        	udiv    r6, r4		//divide register r6 by r4
        	mov     r5, r7		// move the value of register r7 into r5
        	cmp     r6, #1		// compare the value of r6 and 1
        	bge     check2B		// if greater and equal to, branch to check2B
        	ldr     r0, =newLine	// load the base address of newLine into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function

next1B:   	ldr     r0, =meanSquare	// load the base address of meanSquare into r0
        	mov     r1, #38		// move 38 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =zero	// load the base address of zero into r0
        	mov     r1, #3		// move 3 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =meanRectangle// load the base address of meanRectangle into r0
        	mov     r1, #41		// move 41 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =one	// load the base address of one into r0
        	mov     r1, #3		// move 3 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =meanTriangle// load the base address of meanTriangle into r0
        	mov     r1, #40		// move 40 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =zero	// load the base address of zero into r0
        	mov     r1, #3		// move 3 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	b       next		// branch to next

printSingleB:	add     r4, #48		// add 48 to the value of register r4
        	ldr     r5, =totalNumBuff// load the base address of totalNumBuff into r5
        	strb    r4, [r5]	// store the ASCII value into the base address
        	ldr     r0, =totalStars	// load the base address of totalStars into r0
        	mov     r1, #26		// move 26 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =totalNumBuff// load the base address of totalNumBuff into r0
        	mov     r1, #1		// move 1 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =newLine	// load the base address of newLine into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	b       next1B		// branch to next1B

outputMeanTri:	mov     r4, r0		// move the value of register r0 into r4
        	mov     r5, #1		// move 1 into the register r5
        	mov     r6, #10		// move 10 into the register r6
        	cmp     r4, #10         // if total number of stars < 10, just print single digit
        	blt     printSingleC	// if less than, branch to printSingleC

checkC:   	cmp     r4, #10		// compare the value of r4 and 10
        	blt     doneC		// if less than, branch to doneC
        	udiv    r4, r6		//divide register r4 by r6
        	add     r5, #1        	// calculate the counter
        	b       checkC		// branch to checkC

doneC:    	sub     r5, #1        	// a = 10^(counter - 1)
        	mov     r7, #10		// move 10 into the register r7

check1C:  	cmp     r5, #1		// compare the value of r5 and 1
        	beq     done1C		// if equal, branch to done1C
        	mul     r6, r7		// multiple the value in register in r6 by r7
        	sub     r5, #1		// subtract the value in register r5 by 1
        	b       check1C		// branch to check1C

done1C:   	mov     r5, r0        	// a is calculated
        	mov     r7, r0		// move the value of register r0 into r7
        	ldr     r0, =totalStars	// load the base address of totalStars into r0
        	mov     r1, #26		// move 26 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function

check2C:  	udiv    r5, r6		//divide register r5 by r6
        	mov     r8, r5		// move the value of register r5 into r8
        	ldr     r4, =totalNumBuff// load the base address of totalNumBuff into r4
        	add     r8, #48		// add 48 to the value of register r8
        	strb    r8, [r4]	// store the ASCII value into the base address
        	ldr     r0, =totalNumBuff// load the base address of totalNumBuff into r0
        	mov     r1, #1		// move 1 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	mul     r5, r6		// multiple the value in register in r5 by r6
        	sub     r7, r5		// subtract the value in register r7 by 5
        	mov     r4, #10		// move 10 into the register r4
        	udiv    r6, r4		//divide register r6 by r4
        	mov     r5, r7		// move the value of register r7 into r5
        	cmp     r6, #1		// compare the value of r6 and 1
        	bge     check2C		// if greater and equal to, branch to check2C
        	ldr     r0, =newLine	// load the base address of newLine into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function

next1C:   	ldr     r0, =meanSquare	// load the base address of meanSquare into r0
        	mov     r1, #38		// move 38 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =zero	// load the base address of zero into r0
        	mov     r1, #3		// move 3 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =meanRectangle// load the base address of meanRectangle into r0
        	mov     r1, #41		// move 41 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =zero	// load the base address of zero into r0
        	mov     r1, #3		// move 3 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =meanTriangle// load the base address of zero into r0
        	mov     r1, #40		// move 40 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =one	// load the base address of one into r0
        	mov     r1, #3		// move 3 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	b       next		// branch to next

printSingleC:	add     r4, #48		// add 48 to the value of register r4
        	ldr     r5, =totalNumBuff// load the base address of totalNumBuff into r5
        	strb    r4, [r5]	// store the ASCII value into the base address
        	ldr     r0, =totalStars// load the base address of totalStars into r0
        	mov     r1, #26		// move 26 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =totalNumBuff// load the base address of totalNumBuff into r0
        	mov     r1, #1		// move 1 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	ldr     r0, =newLine	// load the base address of newLine into r0
        	mov     r1, #2		// move 2 into the register r1
        	bl      WriteStringUART	// call WriteStringUART function
        	b       next1C		// branch to next1C

haltLoop$:  	b	haltLoop$ 	// Infinite loop at end of program


// Data Section
.section    	.data
.align      	2

Intro:		.ascii  "Created By: Jiongkai Jiang and BenKun Chen\n\r"				// string for introduction

question:     	.ascii  "Please enter the number of object you want to draw. Press -1 for Summary or q to exit\n\r1- Square; 2- Rectangle; 3- Triangle\n\r"	//string for the question

false:      	.ascii  "Wrong number format! q is only allowed as character to exit\n\rPlease enter the number of object you want to draw. Press -1 for Summary or q to exit\n\r1- Square; 2- Rectangle; 3- Triangle\n\r"												 // String for the error messsage

exitProgram:	.ascii "Terminate Program.\n\r"								// string for exting the program

width:      	.ascii  "Please enter width of object. Please make sure it is between 3 and 9.\n\r"	// string for asking the width of the object

invalid:    	.ascii  "Invalid number! the width should be between 3 and 9\n\r"			// string for invalid input

totalStars:   	.ascii  "Total Number of Stars is: "							// string for printing total stars

meanSquare:   	.ascii  "Mean of Stars used to draw Square(s): "					// string for printing mean of suare

meanRectangle:	.ascii  "Mean of Stars used to draw Rectangle(s): "					// string for printing mean of rectangle

meanTriangle: 	.ascii  "Mean of Stars used to draw Triangle(s): "					// string for printing mean of triangle

star:       	.ascii  "* "										// string for printing the star

zero:         	.ascii  "0\n\r"										// string for printing the star

one:          	.ascii  "1\n\r"										// string for printing the one

newLine:    	.ascii  "\n\r"										// string for printing new line

space:        	.asciz  " "										// string for printing an empty space

decimal:      	.ascii  "0."										// string for printing decimal

ABuff:      	.rept   256										// buff for the user input
            	.byte   0
        	.endr

totalNumBuff: 	.int    0										// lable to store single digit
