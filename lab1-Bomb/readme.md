## IPADS 讲解视频
https://www.bilibili.com/video/BV1q94y1a7BF/?vd_source=63231f40c83c4d292b2a881fda478960

## Address already used？
* find the corresponding process of a port: `lsof -i: port`
* kill process: `kill -9 PID`

## ASCII编码表
https://blog.csdn.net/yueyueniaolzp/article/details/82178954

## Assembly Grammar

### address

* Base addressing mode `[rb]` 
* Base address plus offset mode `[rb, offset]`
* Pre-index addressing (update base address before addressing operation) `[rb, offset]!`: rb += Offset; Addressing M[rb] 
* Post-indexed addressing (update base address after addressing operation) `[rb], offset`:  M[rb]; rb += Offset

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

### readline (C function)

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
=> 0x000000000040076c <+12>:	ldr	x1, [x1, #88]  // at this point, x0 = 4858168, x1 = 4605968, are pointers！try *x0, *x1 using "x/s pointer" command in gdb
   0x0000000000400770 <+16>:	bl	0x421b80 <strcmp>
   0x0000000000400774 <+20>:	cbnz	w0, 0x400780 <phase_1+32> // w0 not equal to zero, then explode
   0x0000000000400778 <+24>:	ldp	x29, x30, [sp], #16
   0x000000000040077c <+28>:	ret
   0x0000000000400780 <+32>:	bl	0x400af4 <explode>
   0x0000000000400784 <+36>:	b	0x400778 <phase_1+24>

```


#### strcmp (C function)


```assembly
Dump of assembler code for function strcmp:
=> 0x0000000000421b80 <+0>:	nop
   0x0000000000421b84 <+4>:	sub	x10, x1, x0 // x10 = -252200 = 0xffff ffff fffc 26d8, fixed
   0x0000000000421b88 <+8>:	mov	x8, #0x101010101010101     	// #72340172838076673, fixed
   0x0000000000421b8c <+12>:	and	x6, x0, #0x7 // x6 = 0, fixed
   0x0000000000421b90 <+16>:	tst	x10, #0x7,  // 
   0x0000000000421b94 <+20>:	b.ne	0x421c14 <strcmp+148>  // b.any, b not equal to zero. Because b is equal to zero(x10 least 3 bits are 000), not jump
   0x0000000000421b98 <+24>:	cbnz	x6, 0x421bf0 <strcmp+112> // x6 = 0, not jump
   0x0000000000421b9c <+28>:	nop 
   0x0000000000421ba0 <+32>:	ldr	x3, [x0, x10] // x3 = 7298963055962179915, maybe not fixed
   0x0000000000421ba4 <+36>:	ldr	x2, [x0], #8  // x2 = 3355185, maybe not fixed
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

### Phase_2

``` assembly
   0x0000000000400788 <+0>:	stp	x29, x30, [sp, #-64]!
   0x000000000040078c <+4>:	mov	x29, sp
   0x0000000000400790 <+8>:	stp	x19, x20, [sp, #16]
   0x0000000000400794 <+12>:	add	x1, sp, #0x20
=> 0x0000000000400798 <+16>:	bl	0x400b7c <read_8_numbers>
   0x000000000040079c <+20>:	ldr	w0, [sp, #32]
   0x00000000004007a0 <+24>:	cmp	w0, #0x1
   0x00000000004007a4 <+28>:	b.ne	0x4007b4 <phase_2+44>  // b.any
   0x00000000004007a8 <+32>:	ldr	w0, [sp, #36]
   0x00000000004007ac <+36>:	cmp	w0, #0x1
   0x00000000004007b0 <+40>:	b.eq	0x4007b8 <phase_2+48>  // b.none
   0x00000000004007b4 <+44>:	bl	0x400af4 <explode>
   0x00000000004007b8 <+48>:	add	x19, sp, #0x20
   0x00000000004007bc <+52>:	add	x20, sp, #0x38
   0x00000000004007c0 <+56>:	b	0x4007d0 <phase_2+72>
   0x00000000004007c4 <+60>:	add	x19, x19, #0x4
   0x00000000004007c8 <+64>:	cmp	x19, x20
   0x00000000004007cc <+68>:	b.eq	0x4007f4 <phase_2+108>  // b.none
   0x00000000004007d0 <+72>:	ldr	w0, [x19]  // here is a loop, meaning: x[i+2] = x[i] + x[i+1] + 2
   0x00000000004007d4 <+76>:	ldr	w1, [x19, #4]
   0x00000000004007d8 <+80>:	add	w0, w0, w1
   0x00000000004007dc <+84>:	add	w0, w0, #0x2
   0x00000000004007e0 <+88>:	ldr	w1, [x19, #8]
   0x00000000004007e4 <+92>:	cmp	w1, w0
   0x00000000004007e8 <+96>:	b.eq	0x4007c4 <phase_2+60>  // b.none
   0x00000000004007ec <+100>:	bl	0x400af4 <explode>
   0x00000000004007f0 <+104>:	b	0x4007c4 <phase_2+60>
   0x00000000004007f4 <+108>:	ldp	x19, x20, [sp, #16]
   0x00000000004007f8 <+112>:	ldp	x29, x30, [sp], #64
   0x00000000004007fc <+116>:	ret

```


#### read_8_numbers

```assembly
0x0000000000400b7c <+0>:	sub	sp, sp, #0x20
   0x0000000000400b80 <+4>:	stp	x29, x30, [sp, #16]
   0x0000000000400b84 <+8>:	add	x29, sp, #0x10
   0x0000000000400b88 <+12>:	mov	x2, x1
   0x0000000000400b8c <+16>:	add	x1, x1, #0x1c
   0x0000000000400b90 <+20>:	str	x1, [sp, #8]
   0x0000000000400b94 <+24>:	add	x1, x2, #0x18
   0x0000000000400b98 <+28>:	str	x1, [sp]
   0x0000000000400b9c <+32>:	add	x7, x2, #0x14
   0x0000000000400ba0 <+36>:	add	x6, x2, #0x10
   0x0000000000400ba4 <+40>:	add	x5, x2, #0xc
   0x0000000000400ba8 <+44>:	add	x4, x2, #0x8
   0x0000000000400bac <+48>:	add	x3, x2, #0x4
   0x0000000000400bb0 <+52>:	adrp	x1, 0x464000 <free_mem+64>
   0x0000000000400bb4 <+56>:	add	x1, x1, #0x838
=> 0x0000000000400bb8 <+60>:	bl	0x406d80 <__isoc99_sscanf>
   0x0000000000400bbc <+64>:	cmp	w0, #0x7
   0x0000000000400bc0 <+68>:	b.le	0x400bd0 <read_8_numbers+84>
   0x0000000000400bc4 <+72>:	ldp	x29, x30, [sp, #16]
   0x0000000000400bc8 <+76>:	add	sp, sp, #0x20
   0x0000000000400bcc <+80>:	ret
   0x0000000000400bd0 <+84>:	bl	0x400af4 <explode>

```

### Phase_3

```assembly
0x0000000000400800 <+0>:	stp	x29, x30, [sp, #-32]!
   0x0000000000400804 <+4>:	mov	x29, sp
   0x0000000000400808 <+8>:	add	x3, sp, #0x18
   0x000000000040080c <+12>:	add	x2, sp, #0x1c
   0x0000000000400810 <+16>:	adrp	x1, 0x464000 <free_mem+64>
   0x0000000000400814 <+20>:	add	x1, x1, #0x7d8
=> 0x0000000000400818 <+24>:	bl	0x406d80 <__isoc99_sscanf>
   0x000000000040081c <+28>:	cmp	w0, #0x2
   0x0000000000400820 <+32>:	b.ne	0x40084c <phase_3+76>  // b.any
   0x0000000000400824 <+36>:	ldr	w0, [sp, #28]
   0x0000000000400828 <+40>:	cmp	w0, #0x2
   0x000000000040082c <+44>:	b.eq	0x400854 <phase_3+84>  // b.none
   0x0000000000400830 <+48>:	cmp	w0, #0x5
   0x0000000000400834 <+52>:	b.eq	0x400884 <phase_3+132>  // b.none
   0x0000000000400838 <+56>:	cmp	w0, #0x1
   0x000000000040083c <+60>:	b.eq	0x4008a0 <phase_3+160>  // b.none
   0x0000000000400840 <+64>:	bl	0x400af4 <explode>
   0x0000000000400844 <+68>:	ldp	x29, x30, [sp], #32
   0x0000000000400848 <+72>:	ret
   0x000000000040084c <+76>:	bl	0x400af4 <explode>
   0x0000000000400850 <+80>:	b	0x400824 <phase_3+36>
   0x0000000000400854 <+84>:	ldr	w2, [sp, #24]
   0x0000000000400858 <+88>:	mov	w0, #0x6667                	// #26215
   0x000000000040085c <+92>:	movk	w0, #0x6666, lsl #16
   0x0000000000400860 <+96>:	smull	x0, w2, w0
   0x0000000000400864 <+100>:	asr	x0, x0, #34
   0x0000000000400868 <+104>:	sub	w0, w0, w2, asr #31
   0x000000000040086c <+108>:	add	w1, w0, w0, lsl #2
   0x0000000000400870 <+112>:	sub	w1, w2, w1, lsl #1
   0x0000000000400874 <+116>:	add	w0, w1, w0
   0x0000000000400878 <+120>:	cmp	w0, #0x2
   0x000000000040087c <+124>:	b.eq	0x400844 <phase_3+68>  // b.none
   0x0000000000400880 <+128>:	bl	0x400af4 <explode>
   0x0000000000400884 <+132>:	ldr	w0, [sp, #24]
   0x0000000000400888 <+136>:	eor	w0, w0, w0, asr #3
   0x000000000040088c <+140>:	and	w0, w0, #0x7
   0x0000000000400890 <+144>:	ldr	w1, [sp, #28]
   0x0000000000400894 <+148>:	cmp	w0, w1
   0x0000000000400898 <+152>:	b.eq	0x400844 <phase_3+68>  // b.none
   0x000000000040089c <+156>:	bl	0x400af4 <explode>
   0x00000000004008a0 <+160>:	ldr	w0, [sp, #24]
   0x00000000004008a4 <+164>:	ldr	w1, [sp, #28]
   0x00000000004008a8 <+168>:	and	w2, w0, #0x7
   0x00000000004008ac <+172>:	cmp	w2, w1
   0x00000000004008b0 <+176>:	b.eq	0x400844 <phase_3+68>  // b.none
   0x00000000004008b4 <+180>:	ubfx	x0, x0, #3, #3
   0x00000000004008b8 <+184>:	cmp	w1, w0
   0x00000000004008bc <+188>:	b.eq	0x400844 <phase_3+68>  // b.none
   0x00000000004008c0 <+192>:	bl	0x400af4 <explode>
   0x00000000004008c4 <+196>:	b	0x400840 <phase_3+64>

```

### Phase_4

```assembly
   0x00000000004009e4 <+0>:	stp	x29, x30, [sp, #-32]!
   0x00000000004009e8 <+4>:	mov	x29, sp
   0x00000000004009ec <+8>:	stp	x19, x20, [sp, #16]
   0x00000000004009f0 <+12>:	mov	x19, x0 // *x0 = your input string, x19 = x0
=> 0x00000000004009f4 <+16>:	bl	0x400300 // w0 = 3
   0x00000000004009f8 <+20>:	mov	x20, x0 // x20 = 3
   0x00000000004009fc <+24>:	cmp	w0, #0xa
   0x0000000000400a00 <+28>:	b.gt	0x400a3c <phase_4+88>
   0x0000000000400a04 <+32>:	mov	w1, w20 // w1 = x20 = w0 = 3
   0x0000000000400a08 <+36>:	mov	x0, x19
   0x0000000000400a0c <+40>:	bl	0x4008c8 <encrypt_method1> //after this w5 = 0
   0x0000000000400a10 <+44>:	mov	w1, w20 // w20 = 3
   0x0000000000400a14 <+48>:	mov	x0, x19 // *x19 = *x1 = *x0, after strcpy
   0x0000000000400a18 <+52>:	bl	0x400964 <encrypt_method2>
   0x0000000000400a1c <+56>:	adrp	x0, 0x4a0000
   0x0000000000400a20 <+60>:	ldr	x1, [x0, #104] // x/s $x1 = isggstsvkw
   0x0000000000400a24 <+64>:	mov	x0, x19
   0x0000000000400a28 <+68>:	bl	0x421b80 <strcmp>
   0x0000000000400a2c <+72>:	cbnz	w0, 0x400a44 <phase_4+96>
   0x0000000000400a30 <+76>:	ldp	x19, x20, [sp, #16]
   0x0000000000400a34 <+80>:	ldp	x29, x30, [sp], #32
   0x0000000000400a38 <+84>:	ret
   0x0000000000400a3c <+88>:	bl	0x400af4 <explode>
   0x0000000000400a40 <+92>:	b	0x400a04 <phase_4+32>
   0x0000000000400a44 <+96>:	bl	0x400af4 <explode>
   0x0000000000400a48 <+100>:	b	0x400a30 <phase_4+76>
End of assembler dump.


```
#### e1

``` assembly
0x00000000004008c8 <+0>:	stp	x29, x30, [sp, #-32]!
   0x00000000004008cc <+4>:	mov	x29, sp
   0x00000000004008d0 <+8>:	add	x2, sp, #0x10
=> 0x00000000004008d4 <+12>:	strb	wzr, [x2, w1, sxtw]
   0x00000000004008d8 <+16>:	add	w3, w1, w1, lsr #31
   0x00000000004008dc <+20>:	asr	w3, w3, #1
   0x00000000004008e0 <+24>:	cmp	w1, #0x1
   0x00000000004008e4 <+28>:	b.le	0x40095c <encrypt_method1+148>
   0x00000000004008e8 <+32>:	mov	x4, x2
   0x00000000004008ec <+36>:	mov	x2, #0x0                   	// #0
   0x00000000004008f0 <+40>:	lsl	x5, x2, #1
   0x00000000004008f4 <+44>:	ldrb	w5, [x0, x5]
   0x00000000004008f8 <+48>:	strb	w5, [x4], #1
   0x00000000004008fc <+52>:	add	x2, x2, #0x1
   0x0000000000400900 <+56>:	cmp	w3, w2 // w3 = w2 = 1
   0x0000000000400904 <+60>:	b.gt	0x4008f0 <encrypt_method1+40>
   0x0000000000400908 <+64>:	cmp	w3, #0x0
   0x000000000040090c <+68>:	csinc	w5, w3, wzr, gt
   0x0000000000400910 <+72>:	cmp	w1, w5
   0x0000000000400914 <+76>:	b.le	0x40094c <encrypt_method1+132>
   0x0000000000400918 <+80>:	sub	w4, w1, w5 // w5 = 1，w1 = 3 => w4 = 2
   0x000000000040091c <+84>:	sub	w2, w5, w3 // w5 = 1，w3 = 1 => w2 = 0
   0x0000000000400920 <+88>:	add	x2, x0, w2, sxtw #1 // x2 = x0, *x2 = input[:]
   0x0000000000400924 <+92>:	add	x2, x2, #0x1 // *x2 = input[1:]
   0x0000000000400928 <+96>:	mov	x1, #0x0                   	// #0
   0x000000000040092c <+100>:	add	x3, sp, #0x10
   0x0000000000400930 <+104>:	add	x5, x3, w5, sxtw
   0x0000000000400934 <+108>:	lsl	x3, x1, #1
   0x0000000000400938 <+112>:	ldrb	w3, [x2, x3]
   0x000000000040093c <+116>:	strb	w3, [x5, x1]
   0x0000000000400940 <+120>:	add	x1, x1, #0x1 //x1 ++
   0x0000000000400944 <+124>:	cmp	x1, x4 //x4 = 2
   0x0000000000400948 <+128>:	b.ne	0x400934 <encrypt_method1+108>  // b.any
   0x000000000040094c <+132>:	add	x1, sp, #0x10
   0x0000000000400950 <+136>:	bl	0x421cc0 <strcpy> // after this *x0's value is set to *x1 
   0x0000000000400954 <+140>:	ldp	x29, x30, [sp], #32
   0x0000000000400958 <+144>:	ret
   0x000000000040095c <+148>:	mov	w5, #0x0                   	// #0
   0x0000000000400960 <+152>:	b	0x400910 <encrypt_method1+72>


```


#### e2

```assembly
=> 0x0000000000400964 <+0>:	cmp	w1, #0x0
   0x0000000000400968 <+4>:	b.le	0x4009e0 <encrypt_method2+124>
   0x000000000040096c <+8>:	stp	x29, x30, [sp, #-48]!
   0x0000000000400970 <+12>:	mov	x29, sp
   0x0000000000400974 <+16>:	stp	x19, x20, [sp, #16]
   0x0000000000400978 <+20>:	stp	x21, x22, [sp, #32]
   0x000000000040097c <+24>:	mov	x19, x0
   0x0000000000400980 <+28>:	add	x21, x0, w1, sxtw
   0x0000000000400984 <+32>:	adrp	x22, 0x4a0000
   0x0000000000400988 <+36>:	add	x22, x22, #0x58 \\ after, x/s $x22 = '\020HF'
   0x000000000040098c <+40>:	b	0x4009b0 <encrypt_method2+76>
   0x0000000000400990 <+44>:	ldrb	w1, [x20]
   0x0000000000400994 <+48>:	ldr	x0, [x22, #8] // x/s $x0 = qwertyuiopasdfghjklzxcvbnm
   0x0000000000400998 <+52>:	add	x0, x0, x1
   0x000000000040099c <+56>:	ldurb	w0, [x0, #-97]
   0x00000000004009a0 <+60>:	strb	w0, [x20] // use char w0 to replace the str encoded by ecryptmethod1 at index 0
   0x00000000004009a4 <+64>:	add	x19, x19, #0x1 
   0x00000000004009a8 <+68>:	cmp	x19, x21 // x21 is the length of the string
   0x00000000004009ac <+72>:	b.eq	0x4009d0 <encrypt_method2+108>  // b.none
   0x00000000004009b0 <+76>:	mov	x20, x19  // before this op, x20 = 3
   0x00000000004009b4 <+80>:	ldrb	w0, [x19]  // x19 is the string remained to be encoded, load s19[0] to w0
   0x00000000004009b8 <+84>:	sub	w0, w0, #0x61
   0x00000000004009bc <+88>:	and	w0, w0, #0xff // get the char's distance to 'a', like 'c' - 'a' = 2
   0x00000000004009c0 <+92>:	cmp	w0, #0x19
   0x00000000004009c4 <+96>:	b.ls	0x400990 <encrypt_method2+44>  // b.plast
   0x00000000004009c8 <+100>:	bl	0x400af4 <explode>
   0x00000000004009cc <+104>:	b	0x400990 <encrypt_method2+44>
   0x00000000004009d0 <+108>:	ldp	x19, x20, [sp, #16]
   0x00000000004009d4 <+112>:	ldp	x21, x22, [sp, #32]
   0x00000000004009d8 <+116>:	ldp	x29, x30, [sp], #48
   0x00000000004009dc <+120>:	ret
   0x00000000004009e0 <+124>:	ret

```
input string -> encode1 -> encode2 = encoded string: `isggstsvkw`

* encoder1: For a string, if the length is odd, it is truncated to even. Then take all the odd digits and put them at the top (starting with the left to right subscript 1), and then take all the even digits
* encoder2: char map, key: `qwertyuiopasdfghjklzxcvbnm`, x = 97 + key.index(char), char is in the encoded string, x is originial string after encoder1.

### Phase_5

```assembly
   0x0000000000400ac0 <+0>:	stp	x29, x30, [sp, #-16]!
   0x0000000000400ac4 <+4>:	mov	x29, sp
=> 0x0000000000400ac8 <+8>:	bl	0x400bd4 <read_int>
   0x0000000000400acc <+12>:	adrp	x1, 0x4a0000
   0x0000000000400ad0 <+16>:	add	x1, x1, #0x58
   0x0000000000400ad4 <+20>:	add	x1, x1, #0x18
   0x0000000000400ad8 <+24>:	bl	0x400a4c <func_5>
   0x0000000000400adc <+28>:	cmp	w0, #0x3
   0x0000000000400ae0 <+32>:	b.ne	0x400aec <phase_5+44>  // b.any
   0x0000000000400ae4 <+36>:	ldp	x29, x30, [sp], #16
   0x0000000000400ae8 <+40>:	ret
   0x0000000000400aec <+44>:	bl	0x400af4 <explode>
   0x0000000000400af0 <+48>:	b	0x400ae4 <phase_5+36>

```

#### func_5

```assembly
   0x0000000000400a4c <+0>:	cbz	x1, 0x400ab8 <func_5+108> //x1 = 1, not jump 
   0x0000000000400a50 <+4>:	stp	x29, x30, [sp, #-32]!
   0x0000000000400a54 <+8>:	mov	x29, sp
   0x0000000000400a58 <+12>:	stp	x19, x20, [sp, #16]
   0x0000000000400a5c <+16>:	mov	w20, w0 // w0 = 2023
   0x0000000000400a60 <+20>:	mov	x19, x1  
   0x0000000000400a64 <+24>:	ldr	w0, [x1] //
   0x0000000000400a68 <+28>:	cmp	w0, w20
   0x0000000000400a6c <+32>:	b.eq	0x400a98 <func_5+76>  // b.none
   0x0000000000400a70 <+36>:	ldr	w0, [x19]
   0x0000000000400a74 <+40>:	cmp	w0, w20
   0x0000000000400a78 <+44>:	b.le	0x400aa0 <func_5+84>
   0x0000000000400a7c <+48>:	ldr	x1, [x19, #8]
   0x0000000000400a80 <+52>:	mov	w0, w20
   0x0000000000400a84 <+56>:	bl	0x400a4c <func_5>
   0x0000000000400a88 <+60>:	lsl	w0, w0, #1
   0x0000000000400a8c <+64>:	ldp	x19, x20, [sp, #16]
   0x0000000000400a90 <+68>:	ldp	x29, x30, [sp], #32
   0x0000000000400a94 <+72>:	ret
   0x0000000000400a98 <+76>:	bl	0x400af4 <explode>
   0x0000000000400a9c <+80>:	b	0x400a70 <func_5+36>
   0x0000000000400aa0 <+84>:	ldr	x1, [x19, #16]
   0x0000000000400aa4 <+88>:	mov	w0, w20
   0x0000000000400aa8 <+92>:	bl	0x400a4c <func_5>
   0x0000000000400aac <+96>:	lsl	w0, w0, #1
   0x0000000000400ab0 <+100>:	add	w0, w0, #0x1
   0x0000000000400ab4 <+104>:	b	0x400a8c <func_5+64>
   0x0000000000400ab8 <+108>:	mov	w0, #0x0                   	// #0
   0x0000000000400abc <+112>:	ret

```


## Common Problems 
1. When `sudo apt install qemu-user`, terminal shows that somepackages fail to be downloaded due to 404 error.
   
   * Solution: run `sudo apt update` first.
