# Reading Notes

[TOC]



### Overview of the Arm Architecture

The processor must be in the **correct execution state** for the instructions it is executing.

A processor that is executing A64 instructions is operating in AArch64 state. In this state, the instructions can access **<u>both the 64-bit and 32-bit registers</u>**.

A processor that is executing A32 or T32 instructions is operating in AArch32 state. In this state, the instructions can **only** access the 32-bit registers, and not the 64-bit registers.

**A processor can only execute instructions from the instruction set that matches its current execution state.** A processor in AArch32 state cannot execute A64 instructions, and a processor in AArch64 state cannot execute A32 or T32 instructions. **You must ensure that the processor never receives instructions from the wrong instruction set for the current execution state.**

##  [A Guide to ARM64 / AArch64 Assembly on Linux with Shellcodes and Cryptography](https://modexp.wordpress.com/2018/10/30/arm64-assembly/) 

Reduced Instruction Set Computer (RISC)

**AArch32**

32-bit, with support for the T32 (Thumb) and A32 (ARM) instruction sets.

**AArch64**

64-bit, with support for the A64 instruction set.

This post only focuses on the A64 instruction set.

### Registers

**W denotes 32-bit registers while X denotes 64-bit registers.**

### Calling convention

The following is applicable to Debian Linux. You may freely use x0-x18, but remember that if calling subroutines, they may use them as well.

| Registers | Description                |
| :-------- | :------------------------- |
| X0 – X7   | arguments and return value |
| X8 – X18  | temporary registers        |
| X19 – X28 | callee-saved registers     |
| X29       | frame pointer              |
| X30       | link register              |
| SP        | stack pointer              |

x0 – x7 are used to pass parameters and return values. The value of these registers may be freely modified by the called function (the callee) so the caller cannot assume anything about their content, even if they are not used in the parameter passing or for the returned value. **This means that these registers are in practice caller-saved.**

x8 – x18 are temporary registers for every function. No assumption can be made on their values upon returning from a function. **In practice these registers are also caller-saved.**

x19 – x28 are registers, that, if used by a function, must have their values preserved and later restored upon returning to the caller. These registers are known as callee-saved.

x29 can be used as a frame pointer and x30 is the link register. The callee should save x30 if it intends to call a subroutine.

### Condition Flags

ARM has a “process state” with condition flags that affect the behaviour of some instructions. Branch instructions can be used to change the flow of execution. Some of the data processing instructions allow setting the condition flags with the S suffix. e.g ANDS or ADDS. The flags are the Zero Flag (Z), the Carry Flag (C), the Negative Flag (N) and the is Overflow Flag (V).

| Flag | Description                                                  |
| :--- | :----------------------------------------------------------- |
| N    | Bit 31. Set if the result of an operation is negative. Cleared if the result is positive or zero. |
| Z    | Bit 30. Set if the result of an operation is zero/equal. Cleared if non-zero/not equal. |
| C    | Bit 29. Set if an instruction results in a carry or overflow. Cleared if no carry. |
| V    | Bit 28. Set if an instruction results in an overflow. Cleared if no overflow. |

### Condition Codes

The A32 instruction set supports conditional execution for most of its operations. To improve performance, **ARM removed support with A64**. These conditional codes are now only effective with branch, select and compare instructions. This appears to be a disadvantage, but there are sufficient alternatives in the A64 set that are a distinct improvement.

| Mnemonic | Description                   | Condition flags           |
| :------- | :---------------------------- | :------------------------ |
| EQ       | Equal                         | Z set                     |
| NE       | Not Equal                     | Z clear                   |
| CS or HS | Carry Set                     | C set                     |
| CC or LO | Carry Clear                   | C clear                   |
| MI       | Minus                         | N set                     |
| PL       | Plus, positive or zero        | N clear                   |
| VS       | Overflow                      | V set                     |
| VC       | No overflow                   | V clear                   |
| HI       | Unsigned Higher than or equal | C set and Z clear         |
| LS       | Unsigned Less than or equal   | C clear or Z set          |
| GE       | Signed Greater than or Equal  | N and V the same          |
| LT       | Signed Less than              | N and V differ            |
| GT       | Signed Greater than           | Z clear, N and V the same |
| LE       | Signed Less than or Equal     | Z set, N and V differ     |
| AL       | Always. Normally omitted.     | Any                       |

### Data Types

A “word” on x86 is 16-bits and a “doubleword” is 32-bits. **A “word” for ARM is 32-bits and a “doubleword” is 64-bits.**

| Type       | Size     |
| :--------- | :------- |
| Byte       | 8 bits   |
| Half-word  | 16 bits  |
| Word       | 32 bits  |
| Doubleword | 64 bits  |
| Quadword   | 128 bits |

### Data Alignment (?)

<div style="color: red"><u>The alignment of sp must be two times the size of a pointer. For AArch32 that’s 8 bytes, and for AArch64 it’s 16 bytes.</u></div>