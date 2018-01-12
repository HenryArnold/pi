@ FUNCTION--return address of GPIO
.globl GetGpioAddress
GetGpioAddress
ldr r0, =0x20200000
@ pc is a special register which always contains this address of the next instruction to be run
@ lr contains the address of the code thar we have to go back to when a method finishes
mov pc, 1r

@ FUNCTION--enable output on GPIO pin
.globl SetGpioFunction
SetGpioFunction:
@ warning: this is very dangerous when working with hardware, let's check the pinNum--input
@ there are 54 pins and each pin has 8 functions
cmp r0, #53
cmpls r1, #7
movhi pc, lr
push {1r}
mov r2, r0
bl GetGpioAddress
functionLoop$:
    cmp r2, #9
    subhi r2, #10
    addhi r0, #4
    bhi functionLoop$
@
@r2 x 3 -> r2 x 2 + r2
add r2, r2, lsl #1
lsl r1, r2
str r1, [r0]
pop {pc}

@ FUNCTION--turn pinNum on if pinVal ≠ 0
.globl SetGpio
SetGpio:
pinNum .req r0
pinVal .req r1
@ check the pin num if a valid num
cmp pinNum, #53
movhi pc, 1r
push {1r}
mov r2, pinNum
.unreq pinNum
pinNum .req r2
bl GetGpioAddress
gpioAddr .req r0
@
pinBank .req r3
lsr pinBank, pinNum, #5
lsr pinBank, #2
add gpioAddr, pinBank
.unreq pinBank
@
and pinNum, #31
setBit .req r3
mov setBit, pinNum
.unreq pinNum
@
teq pinVal, #0
