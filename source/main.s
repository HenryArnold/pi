@ the needed styles
.section .init
.globl _start
_start:

@GPIO Controller Address--20200000
@00 - 24:Function Select
@28 - 36:Turn On Pin
@40 - 48:Turn Off Pin
@52 - 60:Pin Input
ldr r0,= 0x20200000

@ mov is faster than ldr because it does not involve a memory interaction will ldr does
@ mov can only used to load certain values
mov r1, #1

@ the manual says that there is a set of 24 bytes in the GPIO controller
@ the first 4 bits relate to the first 10 GPIO pins and so on; there are 54 GPIO pins
@ #18(6x3) every 3 bits relates to a particular GPIO pin
lsl r1, #18
@ enable output
str r1, [r0, #4]

@ send messages to the GPIO controller to trun pin 16 off
@ it make the LED turn on; the ok led is wired to the 16th GPIO pin
mov r1, #1

@ 16th pin
lsl r1, #16

@ pin off ; #28 will on
str r1, [r0, #40]

@ the processor will never finsh, so let it loop
loop$:
b loop$
