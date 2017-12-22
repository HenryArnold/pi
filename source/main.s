.section .init
.globl _start
_start:
@ the first line
ldr r0,= 0x20200000
@ enable output
mov r1, #1
lsl r1, #18
str r1, [r0, #4]
@ a sign of life
mov r1, #1
lsl r1, #16
str r1, [r0, #40]
@ happily ever after
loop$:
b loop$
