# Copyright 2025 Filip Pynckels
# See https://github.com/Pynckels/tiny-linux/blob/main/LICENSE

# This software is distributed as-is, with no warranty or
# guarantee of its functionality, performance, or usability.

# Set compiler parameters
CC       = gcc
CCFLAGS  = -Os -Wall -Werror
CCFLAGS += -fno-ident -fno-asynchronous-unwind-tables -fno-stack-protector -fomit-frame-pointer

# Set linker parameters
LD       = ld
LDFLAGS  = --strip-all -z noexecstack -z nodefaultlib

# Get the number of available processors
NJBS = $(shell nproc)

# Get all .c source files in src
SRCS = $(wildcard src/*.c)

# Replace .c with .o and move to build
OBJS = $(SRCS:.c=.o)
OBJS := $(patsubst src/%, build/%, $(OBJS))

# ------------------------------------------------------------------------------

all: build/init.cpio

# ------------------------------------------------------------------------------

build/%.o: src/%.c src/sys.h
	@echo "  CC      $@"
	@mkdir -p build
	@$(CC) $(CCFLAGS) -c -o $@ $<

build/init: $(OBJS) src/init.ld
	@echo "  LD      $@"
	@$(LD) $(LD_FLAGS) -o $@ -T src/init.ld $(OBJS)

build/init.cpio: build/init
	@echo "  CPIO    init"
	@cd build && echo "init" | cpio -H newc -o > init.cpio

src/sys.h:

# ------------------------------------------------------------------------------

clean:
	@echo "  CLEAN"
	@rm -rf build

# ------------------------------------------------------------------------------

help:
	@echo "usage: make [all | clean | help ]"
	@echo " "
	@echo "Build a minimal non-secure Linux user space."
	@echo " "
	@echo "targets:"
	@echo "  all             build a user space application"
	@echo "  clean           reset project directory"
	@echo "  help            show this help message and exit"
