# Copyright 2025 Filip Pynckels
# See https://github.com/Pynckels/tiny-linux/blob/main/LICENSE

# This software is distributed as-is, with no warranty or
# guarantee of its functionality, performance, or usability.

SECTIONS
{
    . = 0x10000;
    ENTRY(main)
    .text : {*(.text)}
}
