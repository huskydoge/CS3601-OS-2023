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
```assembly
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

### readline

```assembly
  0x0000000000400b10 <+0>:	stp	x29, x30, [sp, #-16]!
   0x0000000000400b14 <+4>:	mov	x29, sp
   0x0000000000400b18 <+8>:	adrp	x0, 0x49f000 <tunable_list+1376>
=> 0x0000000000400b1c <+12>:	ldr	x0, [x0, #3488]
   0x0000000000400b20 <+16>:	ldr	x2, [x0]
   0x0000000000400b24 <+20>:	mov	w1, #0x51                  	// #81
   0x0000000000400b28 <+24>:	adrp	x0, 0x4a2000 <_IO_helper_jumps+96>
   0x0000000000400b2c <+28>:	add	x0, x0, #0x138
   0x0000000000400b30 <+32>:	bl	0x413510 <fgets>
   0x0000000000400b34 <+36>:	mov	x0, #0x0                   	// #0
   0x0000000000400b38 <+40>:	adrp	x2, 0x4a2000 <_IO_helper_jumps+96>
   0x0000000000400b3c <+44>:	add	x2, x2, #0x138  // x2 = 4858168，input phase_1 = 1; the same value with input = 2

   0x0000000000400b40 <+48>:	ldrb	w1, [x0, x2] // w1 = 49, 10, 
   0x0000000000400b44 <+52>:	cbz	w1, 0x400b6c <read_line+92>
   0x0000000000400b48 <+56>:	cmp	w1, #0xa
   0x0000000000400b4c <+60>:	b.eq	0x400b60 <read_line+80>  // b.none, when w1 = 10, jump!
   0x0000000000400b50 <+64>:	add	x0, x0, #0x1 // x0 = 1
   0x0000000000400b54 <+68>:	cmp	x0, #0x50
   0x0000000000400b58 <+72>:	b.ne	0x400b40 <read_line+48>  // b.any, for loop, everytime x0 ++

   0x0000000000400b5c <+76>:	bl	0x400af4 <explode>
   0x0000000000400b60 <+80>:	adrp	x1, 0x4a2000 <_IO_helper_jumps+96>
   0x0000000000400b64 <+84>:	add	x1, x1, #0x138 // x1 = 4857856, input phase_1 = 1
   0x0000000000400b68 <+88>:	strb	wzr, [x1, w0, sxtw] // wzr, 32 bit to clear int to zero; xzr, 64 bit to clear long to zero
   // store 0 to [x1 + 2 * w0] = [x1 + 2]
   0x0000000000400b6c <+92>:	adrp	x0, 0x4a2000 <_IO_helper_jumps+96>
   0x0000000000400b70 <+96>:	add	x0, x0, #0x138 # x0 = 4858168, input phase_1 = 1
   0x0000000000400b74 <+100>:	ldp	x29, x30, [sp], #16
   0x0000000000400b78 <+104>:	ret


```

### Phase_0

```assembly
Dump of assembler code for function phase_0:
   0x0000000000400734 <+0>:	stp	x29, x30, [sp, #-16]!
   0x0000000000400738 <+4>:	mov	x29, sp
=> 0x000000000040073c <+8>:	bl	0x400bd4 <read_int>
   0x0000000000400740 <+12>:	adrp	x1, 0x4a0000
   0x0000000000400744 <+16>:	ldr	w1, [x1, #84] // w1 = 2022
   0x0000000000400748 <+20>:	cmp	w1, w0
   0x000000000040074c <+24>:	b.ne	0x400758 <phase_0+36>  // b.any
   0x0000000000400750 <+28>:	ldp	x29, x30, [sp], #16
   0x0000000000400754 <+32>:	ret
   0x0000000000400758 <+36>:	bl	0x400af4 <explode>
   0x000000000040075c <+40>:	b	0x400750 <phase_0+28>
End of assembler dump.

```

#### read_int
```assembly
Dump of assembler code for function read_int:
   0x0000000000400bd4 <+0>:	stp	x29, x30, [sp, #-32]!
   0x0000000000400bd8 <+4>:	mov	x29, sp
   0x0000000000400bdc <+8>:	add	x2, sp, #0x1c
   0x0000000000400be0 <+12>:	adrp	x1, 0x464000 <free_mem+64>
   0x0000000000400be4 <+16>:	add	x1, x1, #0x850
=> 0x0000000000400be8 <+20>:	bl	0x406d80 <__isoc99_sscanf>
   0x0000000000400bec <+24>:	cmp	w0, #0x0
   0x0000000000400bf0 <+28>:	b.le	0x400c00 <read_int+44>
   0x0000000000400bf4 <+32>:	ldr	w0, [sp, #28]
   0x0000000000400bf8 <+36>:	ldp	x29, x30, [sp], #32
   0x0000000000400bfc <+40>:	ret
   0x0000000000400c00 <+44>:	bl	0x400af4 <explode>
End of assembler dump.
```

* Check whether input number for phase_0 is less than 0, if so, explode.
* Return value in w0 register

### Phase_1

```assembly
Dump of assembler code for function phase_1:
   0x0000000000400760 <+0>:	stp	x29, x30, [sp, #-16]!
   0x0000000000400764 <+4>:	mov	x29, sp
   0x0000000000400768 <+8>:	adrp	x1, 0x4a0000
=> 0x000000000040076c <+12>:	ldr	x1, [x1, #88]  // at this point, x0 = 4858168, x1 = 4605968, irrelevant to the input
   0x0000000000400770 <+16>:	bl	0x421b80 <strcmp>
   0x0000000000400774 <+20>:	cbnz	w0, 0x400780 <phase_1+32> // w0 not equal to zero, then explode
   0x0000000000400778 <+24>:	ldp	x29, x30, [sp], #16
   0x000000000040077c <+28>:	ret
   0x0000000000400780 <+32>:	bl	0x400af4 <explode>
   0x0000000000400784 <+36>:	b	0x400778 <phase_1+24>

```


#### strcmp


```assembly
Dump of assembler code for function strcmp:
=> 0x0000000000421b80 <+0>:	nop
   0x0000000000421b84 <+4>:	sub	x10, x1, x0 // x10 = -252200 = 0xffff ffff fffc 26d8
   0x0000000000421b88 <+8>:	mov	x8, #0x101010101010101     	// #72340172838076673
   0x0000000000421b8c <+12>:	and	x6, x0, #0x7 // x6 = 0
   0x0000000000421b90 <+16>:	tst	x10, #0x7,  // 
   0x0000000000421b94 <+20>:	b.ne	0x421c14 <strcmp+148>  // b.any, b not equal to zero. Because b is equal to zero(x10 least 3 bits are 000), not jump
   0x0000000000421b98 <+24>:	cbnz	x6, 0x421bf0 <strcmp+112> // x6 = 0, not jump
   0x0000000000421b9c <+28>:	nop 
   0x0000000000421ba0 <+32>:	ldr	x3, [x0, x10] // x3 = 7298963055962179915
   0x0000000000421ba4 <+36>:	ldr	x2, [x0], #8  // x2 = 3355185
   0x0000000000421ba8 <+40>:	sub	x4, x2, x8    // x4 = -72340172834721488
   0x0000000000421bac <+44>:	orr	x6, x2, #0x7f7f7f7f7f7f7f7f   
   0x0000000000421bb0 <+48>:	bics	x4, x4, x6   // x4 = .....
   0x0000000000421bb4 <+52>:	ccmp	x2, x3, #0x0, eq  // eq = none, if eq satisfied, then carry out comparison else dismiss
   0x0000000000421bb8 <+56>:	b.eq	0x421ba0 <strcmp+32>  // b.none
   0x0000000000421bbc <+60>:	eor	x5, x2, x3
   0x0000000000421bc0 <+64>:	orr	x6, x5, x4
   0x0000000000421bc4 <+68>:	rev	x6, x6
   0x0000000000421bc8 <+72>:	rev	x2, x2
   0x0000000000421bcc <+76>:	rev	x3, x3
   0x0000000000421bd0 <+80>:	clz	x9, x6
   0x0000000000421bd4 <+84>:	lsl	x2, x2, x9
   0x0000000000421bd8 <+88>:	lsl	x3, x3, x9
   0x0000000000421bdc <+92>:	lsr	x2, x2, #56 // after this instruction, x2 = 98, x3 = -7596825387575433526
   0x0000000000421be0 <+96>:	sub	x0, x2, x3, lsr #56
   0x0000000000421be4 <+100>:	ret // at this point, x0 = -52
   0x0000000000421be8 <+104>:	nop
   0x0000000000421bec <+108>:	nop
   0x0000000000421bf0 <+112>:	and	x0, x0, #0xfffffffffffffff8
   0x0000000000421bf4 <+116>:	ldr	x3, [x0, x10]
   0x0000000000421bf8 <+120>:	ldr	x2, [x0], #8
   0x0000000000421bfc <+124>:	neg	x9, x1, lsl #3
   0x0000000000421c00 <+128>:	mov	x6, #0xffffffffffffffff    	// #-1
   0x0000000000421c04 <+132>:	lsr	x6, x6, x9
   0x0000000000421c08 <+136>:	orr	x2, x2, x6
   0x0000000000421c0c <+140>:	orr	x3, x3, x6
   0x0000000000421c10 <+144>:	b	0x421ba8 <strcmp+40>
   0x0000000000421c14 <+148>:	cbz	x6, 0x421c34 <strcmp+180>
   0x0000000000421c18 <+152>:	ldrb	w2, [x0], #1
   0x0000000000421c1c <+156>:	ldrb	w3, [x1], #1
   0x0000000000421c20 <+160>:	cmp	w2, #0x0
   0x0000000000421c24 <+164>:	ccmp	w2, w3, #0x0, ne  // ne = any
   0x0000000000421c28 <+168>:	b.ne	0x421cac <strcmp+300>  // b.any
   0x0000000000421c2c <+172>:	tst	x0, #0x7
   0x0000000000421c30 <+176>:	b.ne	0x421c18 <strcmp+152>  // b.any
   0x0000000000421c34 <+180>:	neg	x9, x1, lsl #3
   0x0000000000421c38 <+184>:	and	x1, x1, #0xfffffffffffffff8
   0x0000000000421c3c <+188>:	ldr	x7, [x1], #8
   0x0000000000421c40 <+192>:	lsr	x6, x8, x9
   0x0000000000421c44 <+196>:	orr	x7, x7, x6
   0x0000000000421c48 <+200>:	sub	x4, x7, x8
   0x0000000000421c4c <+204>:	orr	x6, x7, #0x7f7f7f7f7f7f7f7f
   0x0000000000421c50 <+208>:	bics	x4, x4, x6
   0x0000000000421c54 <+212>:	b.ne	0x421c90 <strcmp+272>  // b.any
   0x0000000000421c58 <+216>:	sub	x5, x1, x0
   0x0000000000421c5c <+220>:	nop
   0x0000000000421c60 <+224>:	ldr	x7, [x0, x5]
   0x0000000000421c64 <+228>:	ldr	x3, [x0, x10]
   0x0000000000421c68 <+232>:	sub	x4, x7, x8
   0x0000000000421c6c <+236>:	orr	x6, x7, #0x7f7f7f7f7f7f7f7f
   0x0000000000421c70 <+240>:	ldr	x2, [x0], #8
   0x0000000000421c74 <+244>:	bics	x4, x4, x6
   0x0000000000421c78 <+248>:	ccmp	x2, x3, #0x0, eq  // eq = none
   0x0000000000421c7c <+252>:	b.eq	0x421c60 <strcmp+224>  // b.none
   0x0000000000421c80 <+256>:	lsl	x6, x4, x9
   0x0000000000421c84 <+260>:	eor	x5, x2, x3
   0x0000000000421c88 <+264>:	orr	x6, x5, x6
   0x0000000000421c8c <+268>:	cbnz	x6, 0x421bc4 <strcmp+68>
   0x0000000000421c90 <+272>:	ldr	x2, [x0]
   0x0000000000421c94 <+276>:	neg	x9, x9
   0x0000000000421c98 <+280>:	lsr	x3, x7, x9
   0x0000000000421c9c <+284>:	lsr	x4, x4, x9
   0x0000000000421ca0 <+288>:	eor	x5, x2, x3
   0x0000000000421ca4 <+292>:	orr	x6, x5, x4
   0x0000000000421ca8 <+296>:	b	0x421bc4 <strcmp+68>
   0x0000000000421cac <+300>:	sub	x0, x2, x3
   0x0000000000421cb0 <+304>:	ret
End of assembler dump.

```

## Common Problems 
1. When `sudo apt install qemu-user`, terminal shows that somepackages fail to be downloaded due to 404 error.
   
   * Solution: run `sudo apt update` first.
