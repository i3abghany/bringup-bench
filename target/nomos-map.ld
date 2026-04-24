OUTPUT_ARCH(riscv)

MEMORY
{
    ram   : ORIGIN = 0x00100000, LENGTH = 0x00e00000
    stack : ORIGIN = 0x00f00000, LENGTH = 0x00010000
}

_min_stack    = 0x2000;
_stack_len    = LENGTH(stack);
_stack_start  = ORIGIN(stack) + LENGTH(stack);

ENTRY(_start)

SECTIONS
{
    .text : {
        . = ALIGN(4);
        *(.text)
        *(.text.*)
    } > ram :text

    .rodata : {
        . = ALIGN(4);
        *(.srodata)
        *(.srodata.*)
        *(.rodata)
        *(.rodata.*)
    } > ram :text

    .data : {
        . = ALIGN(4);
        __global_pointer$ = . + 0x800;
        *(.sdata)
        *(.sdata.*)
        *(.data)
        *(.data.*)
    } > ram :data

    .bss : {
        . = ALIGN(4);
        _bss_start = .;
        *(.sbss)
        *(.sbss.*)
        *(.bss)
        *(.bss.*)
        *(COMMON)
        _bss_end = .;
    } > ram :data

    .stack (NOLOAD): {
        . = ALIGN(4);
        . = . + _min_stack;
        . = ALIGN(4);
        stack = .;
        _stack = .;
    } > stack :data
}

PHDRS {
  text PT_LOAD FLAGS(5);
  data PT_LOAD FLAGS(6);
}
