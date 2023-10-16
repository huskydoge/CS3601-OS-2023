
ENTRY(_start)

SECTIONS
{
    . = 0x80000;

    img_start = .;
    init : {
        CMakeFiles/kernel.img.dir/arch/aarch64/boot/raspi3/init/start.S.obj
CMakeFiles/kernel.img.dir/arch/aarch64/boot/raspi3/init/mmu.c.obj
CMakeFiles/kernel.img.dir/arch/aarch64/boot/raspi3/init/tools.S.obj
CMakeFiles/kernel.img.dir/arch/aarch64/boot/raspi3/init/init_c.c.obj
CMakeFiles/kernel.img.dir/arch/aarch64/boot/raspi3/peripherals/uart.c.obj
    }
    . = ALIGN(4K);
    init_end = ABSOLUTE(.);

    .text 0xffffff0000000000 + init_end : AT(init_end) {
    _text_start = .;
        *(.text*)
    }
    . = ALIGN(4K);
    _text_end = .;

    .data : {
        *(.data*)
    }
    . = ALIGN(4K);

    .rodata : {
        *(.rodata*)
    }
    . = ALIGN(4K);
    _edata = . - 0xffffff0000000000;

    _bss_start = . - 0xffffff0000000000;
    .bss : {
        *(.bss*)
    }
    . = ALIGN(4K);
    _bss_end = . - 0xffffff0000000000;

    _extable_start = .;
    .extable : {
        *(.extable*)
    }
    . = ALIGN(4K);
    _extable_end = .;

    img_end = . - 0xffffff0000000000;

    /DISCARD/ : { *(.comment) *(.gnu*) *(.note*) *(.eh_frame*) }
}
