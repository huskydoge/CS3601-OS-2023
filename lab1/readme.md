## GDB

### Enter and Step out a Function
 In GDB, if you have entered a function and wish to exit, you can use the `finish` command. This command will continue running the program until the current function returns. If you want to stop the program immediately, you can use `interrupt` or `Ctrl+C`. 
 
If you just want to step out of the current function, but not run until the function returns, you can use the `next` command. The "next" command executes the program until it reaches the next line of the same function. If the current line is a function call, it will not enter the called function. 
 
In general, the `finish` command helps you exit the current function, the `next` command helps you avoid entering functions you're not interested in, and the `interrupt` or `Ctrl+C` command allows you to stop the program at any time.
### How to Delete Breakpoints?
* `"delete"`: This will clear all breakpoints. 
* `"delete breakpoints"`: This will also clear all breakpoints. 
* `"delete < breakpoint number >"`: This clears the breakpoint with the specified number. 
* `"delete < breakpoint 1> < breakpoint 2>..."` : This will clear multiple breakpoints specified.
  
## Assembly Code
```
Dump of assembler code for function main:
   0x0000000000400694 <+0>:	stp	x29, x30, [sp, #-16]!
   0x0000000000400698 <+4>:	mov	x29, sp
   0x000000000040069c <+8>:	adrp	x0, 0x464000 <free_mem+64>
   0x00000000004006a0 <+12>:	add	x0, x0, #0x778
=> 0x00000000004006a4 <+16>:	bl	0x413b20 <puts>
   0x00000000004006a8 <+20>:	bl	0x400b10 <read_line>
   0x00000000004006ac <+24>:	bl	0x400734 <phase_0>
   0x00000000004006b0 <+28>:	bl	0x400708 <phase_defused>
   0x00000000004006b4 <+32>:	bl	0x400b10 <read_line>
   0x00000000004006b8 <+36>:	bl	0x400760 <phase_1>
   0x00000000004006bc <+40>:	bl	0x400708 <phase_defused>
   0x00000000004006c0 <+44>:	bl	0x400b10 <read_line>
   0x00000000004006c4 <+48>:	bl	0x400788 <phase_2>
   0x00000000004006c8 <+52>:	bl	0x400708 <phase_defused>
   0x00000000004006cc <+56>:	bl	0x400b10 <read_line>
   0x00000000004006d0 <+60>:	bl	0x400800 <phase_3>
   0x00000000004006d4 <+64>:	bl	0x400708 <phase_defused>
   0x00000000004006d8 <+68>:	bl	0x400b10 <read_line>
   0x00000000004006dc <+72>:	bl	0x4009e4 <phase_4>
   0x00000000004006e0 <+76>:	bl	0x400708 <phase_defused>
   0x00000000004006e4 <+80>:	bl	0x400b10 <read_line>
   0x00000000004006e8 <+84>:	bl	0x400ac0 <phase_5>
   0x00000000004006ec <+88>:	bl	0x400708 <phase_defused>
   0x00000000004006f0 <+92>:	adrp	x0, 0x464000 <free_mem+64>
   0x00000000004006f4 <+96>:	add	x0, x0, #0x798
   0x00000000004006f8 <+100>:	bl	0x413b20 <puts>
   0x00000000004006fc <+104>:	mov	w0, #0x0                   	// #0
   0x0000000000400700 <+108>:	ldp	x29, x30, [sp], #16
   0x0000000000400704 <+112>:	ret
End of assembler dump.

```



## Common Problems 
1. When `sudo apt install qemu-user`, terminal shows that somepackages fail to be downloaded due to 404 error.
   
   * Solution: run `sudo apt update` first.
