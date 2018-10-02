// THis subroutine will generate a random number and return in r0
.globl    RandomNumberGenerator
RandomNumberGenerator:
    push    {r1-r9, lr}

    ldr    r1,     =w          //5
    ldr    r2,     =x          //6
    ldr    r3,    =y          //7
    ldr    r4,     =z          //8

    ldrb    r5,    [r1]           //w
    ldrb    r6,    [r2]            //x
    ldrb    r7,    [r3]            //y
    ldrb    r8,    [r4]            //z

    mov    r9,    r6            // mov x to t
    eor    r9,    r9,r9,lsl #11        // xor t shift by 11
    eor    r9,    r9,r9,lsl #8            // xor t shift by 8
    mov    r6,    r7            // mov y to x
    mov    r7,    r8            // mov z to y
    mov     r8,    r5                 // mov w to z
    eor     r5,    r5,r5,lsl #19        // xor w shift by 19
    eor     r5,    r9            // xor w with t


    mov     r0, r5

    strb    r5, [r1]
    strb    r6, [r2]
    strb    r7, [r3]
    strb    r8, [r4]

    and     r0, #7

    pop     {r1-r9, lr}
    bx lr

.section .data
w:
    .byte    45
x:
    .byte   101
y:
    .byte  95
z:
    .byte  78
