.syntax unified

@ DO NOT UNDER ANY CIRCUMSTANCES FLASH YOUR MICROBIT WITH THIS CODE UNLESS YOU ARE INTIMATELY FAMILIAR WITH THE RISKS
@ AND ARE 100% CONFIDENT YOU CAN FOLLOW THE INSTRUCTIONS IN ../README.md TO FIX YOUR BOARD
@ THIS WILL BREAK YOUR MICROBIT! 

@ This is the evil source code in AMR thumb2 assembly
@ The bug here is that the student switches registers to shift left in the middle of their code. 

.global main
.type main, %function
main:


    ldr r1, =0x50000000
    ldr r2, [r1, 0x514] @ First instance of the bug occurs in this sequence, notice the lsl instruction goes from lsl r3, r3; to lsl r3, r2.
    mov r3, 0b1 
    lsl r3, r3, #11 @ set DIR for column 2 @ P0.11
    orr r2, r2, r3
    lsl r3, r3, #4 @ set DIR for row 3 @ P0.15
    orr r2, r2, r3
    lsl r3, r2, #4 @ set DIR for row 5 @ P0.19
    orr r2, r2, r3
    lsl r3, r2, #2 @ set DIR for row 1 @ P0.21
    orr r2, r2, r3
    lsl r3, r2, #1 @ set DIR for row 2 @ P0.22
    orr r2, r2, r3
    lsl r3, r2, #2 @ set DIR for row 4 @ P0.24
    orr r2, r2, r3
    str r2, [r1, 0x514]

    on:
    movs r0, 0x2
    ldr r2, [r1, 0x504]
    mov r3, 0b1
    lsl r3, r3, #15 @ set OUT for row 3 @ P0.15
    orr r2, r2, r3
    lsl r3, r2, #4 @ set OUT for row 5 @ P0.19
    orr r2, r2, r3
    lsl r3, r2, #2 @ set OUT for row 1 @ P0.21
    orr r2, r2, r3
    lsl r3, r2, #1 @ set OUT for row 2 @ P0.22
    orr r2, r2, r3
    lsl r3, r2, #2 @ set OUT for row 4 @ P0.24
    orr r2, r2, r3
    lsl r3, r2, #4 @ set OUT for column 1 @ P0.28
    orr r2, r2, r3
    lsl r3, r2, #2 @ set OUT for column 5 @ P0.30
    orr r2, r2, r3
    lsl r3, r2, #1 @ set OUT for column 3 @ P0.31
    orr r2, r2, r3
    str r2, [r1, 0x504]

    b delay_on
    off:
    movs r0, 0x2
    ldr r2, [r1, 0x504]
    mov r3, 0b0
    lsl r3, r3, #11 @ set OUT for row 3 @ P0.15
    and r2, r2, r3

    @ lsl r3, r2, #4 @ set OUT for row 5 @ P0.19
    @ orr r2, r2, r3
    @ lsl r3, r2, #2 @ set OUT for row 1 @ P0.21
    @ orr r2, r2, r3
    @ lsl r3, r2, #1 @ set OUT for row 2 @ P0.22
    @ orr r2, r2, r3
    @ lsl r3, r2, #2 @ set OUT for row 4 @ P0.24
    @ orr r2, r2, r3

    str r2, [r1, 0x504]
    b delay_off
    delay_on:
    subs r0, 1
    bne delay_on
    b off

    delay_off:
    subs r0, 1
    bne delay_off

.size main, .-main

.data @ Part of our template 
hello:
    .word 0x424242