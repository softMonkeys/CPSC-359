
.section .text

.global controller3
controller3:
push    {r0-r10,lr}
        //call Init_GPIO to initialize GPIO
        bl      Init_GPIO

        //r5 is the copy of r9 numberlist, which prevent the program keeping printing the same button
        mov     r10, #0
        mov     r5, #0
        ldr     r5, =0xffff

//the loop to get the pressed button(s) and print the corresponding message
Loop:
        //call the Read_SNES to get the numberlist and store it in r9
        bl      Read_SNES
        cmp     r5, r9
        bne    reStart

//print out the corresponding button(s)





next:
        b       Loop


start:
        bl      StartGame
        b       exit
quit:
        bl      QuitGame

exit:

pop     {r0-r10,lr}
mov     pc, lr
