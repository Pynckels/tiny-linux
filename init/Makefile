# Copyright 2025 Filip Pynckels
# See https://github.com/Pynckels/tiny-linux/blob/main/LICENSE

# This software is distributed as-is, with no warranty or
# guarantee of its functionality, performance, or usability.

AS      = as
ASFLAGS =

CC      = gcc
CCFLAGS = -Os -fno-ident -fno-asynchronous-unwind-tables -fno-stack-protector -fomit-frame-pointer

LD      = ld
LDFLAGS = --strip-all -z noexecstack

NJBS = $(shell nproc)

# ------------------------------------------------------------------------------

all: build/init.cpio

# ------------------------------------------------------------------------------

build:
	@echo "  MKDIR   build"
	@mkdir -p build

build/init: src/init.ld build/init.o build/syscalls.o
	@echo "  LD      init"
	@$(LD) $(LDFLAGS) -o build/init -T src/init.ld build/init.o build/syscalls.o

build/init.cpio: build/init
	@echo "  CPIO    init"
	@cd build && echo "init" | cpio -H newc -o > init.cpio

build/init.o: build src/init.c src/syscalls.h
	@echo "  CC      init"
	@$(CC) $(CCFLAGS) -c -o build/init.o src/init.c

src/syscalls.h:

build/syscalls.o: build src/syscalls.S
	@echo "  AS      syscalls"
	@$(AS) $(ASFLAGS) -o build/syscalls.o src/syscalls.S

# ------------------------------------------------------------------------------

clean:
	@echo "  CLEAN"
	@rm -r build

# ------------------------------------------------------------------------------

help:
	@echo "usage: make [build-init | clean | help ]"
	@echo " "
	@echo "Build a minimal non-secure Linux user space."
	@echo " "
	@echo "options:"
	@echo "  build-init      build a user space application"
	@echo "  clean           reset project directory"
	@echo "  help            show this help message and exit"
