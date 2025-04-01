# Copyright 2025 Filip Pynckels
# See https://github.com/Pynckels/tiny-linux/blob/main/LICENSE

# This software is distributed as-is, with no warranty or
# guarantee of its functionality, performance, or usability.

ENTRY(main)             /* Define the entry point   */

SECTIONS
{
    . = 0x10000;
    .text : 
    {
        *(.text.main)   /* Place main first         */
        *(.text)        /* Place all .text sections */
    }

    .data : 
    {
        *(.data)        /* Place all .data sections */
    }

    .bss : 
    {
        *(.bss)         /* Place all .bss sections  */
    }
}
