.section .init
.globl _start
_start:
b main

.section .text
main:
mov sp, #0x8000

ldr r0,= 0x20200000

mov r1, #1

lsl r1, #18
str r1, [r0, #4]

mov r1, #1

lsl r1, #16

str r1, [r0, #40]

ptrn .req r4
ldr ptrn, =pattern
ldr ptrn, [ptrn]
seq .req r5
mov seq, #0

mov r1, #1
lsl r1, seq
and r1, ptrn


loop$:
b loop$

mov r2, #0x3F0000
wait1$:
sub r2, #1
@ remember the results in the current processor status register
cmp r2, #0
@ ne--the command executed only if the last comparison  the numbers were not equal
bne wait1$

@ to differentiate between data and code, we put all the data int the .data
.section .data
@ this data will be placed at an address which is a multiple of 2^2 = 4; ldr only works at address that are multiple of 4
.align 2
pattern:
.int 0b11111111101010100010001000101010
