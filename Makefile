# Copyright 2025 Filip Pynckels
# See https://github.com/Pynckels/tiny-linux/blob/main/LICENSE

# This software is distributed as-is, with no warranty or
# guarantee of its functionality, performance, or usability.

# ------------------------------------------------------------------------------
#
# kernel.defconfig is created as follows:
# ======================================
#
#    cd kernel
#    make tinyconfig
#    make menuconfig
#
#        General setup
#
#            [*] Initial RAM filesystem and RAM disk (initramfs/initrd) support
#            ()    Initramfs source file(s) (NEW)
#            [ ]   Support initial ramdisk/ramfs compressed using gzip
#            [ ]   Support initial ramdisk/ramfs compressed using bzip2
#            [ ]   Support initial ramdisk/ramfs compressed using LZMA
#            [ ]   Support initial ramdisk/ramfs compressed using XZ
#            [ ]   Support initial ramdisk/ramfs compressed using LZO
#            [ ]   Support initial ramdisk/ramfs compressed using LZ4
#            [ ]   Support initial ramdisk/ramfs compressed using ZSTD
#
#            [*] Configure standard kernel features (expert users)
#                [*]   Enable support for printk
#
#        [*] 64-bit kernel
#
#        Device Drivers
#            Character devices
#                [*] Enable TTY
#
#        Executable file formats
#            [*] Kernel support for ELF binaries
#
#    make savedefconfig
#    mv defconfig ../kernel.defconfig
#    cd ..
#
#
# arch/x86/boot/bzImage can be tested as follows:
# ==============================================
#
#    qemu-system-x86_64 -kernel kernel/arch/x86/boot/bzImage
#
# ------------------------------------------------------------------------------

DISK      = tiny-linux.iso

# Default value if "make MESSAGES=0" or "make MESSAGES=1" is not used
MESSAGES ?= 0

# ------------------------------------------------------------------------------

NJBS = $(shell nproc)

ifeq ($(MESSAGES), 0)
	GITOUT = -q
	STDOUT = > /dev/null 2>&1
endif

# ------------------------------------------------------------------------------

all: build-kernel \
	 build-init   \
	 build-iso

# ------------------------------------------------------------------------------

build-init:

	@echo "  BUILD   init"
	@$(MAKE) -j$(NJBS) --no-print-directory -C init $(STDOUT)

# ------------------------------------------------------------------------------

build-kernel:

	@if [ ! -d "kernel/.git" ]; then                                            \
		echo "  CLONE   kernel";                                                \
		git clone --depth 1 $(GITOUT) https://github.com/torvalds/linux kernel; \
	fi

	@if [ ! -f "kernel/.config" ]; then                                \
		echo "  CONFIG  kernel";                                       \
		cp kernel.defconfig kernel/.config;                            \
		$(MAKE) olddefconfig --no-print-directory -C kernel $(STDOUT); \
	fi

	@echo "  BUILD   kernel"
	@$(MAKE) -j$(NJBS) --no-print-directory -C kernel $(STDOUT)

# ------------------------------------------------------------------------------

build-iso:
# If an error occurs: "sudo apt install isolinux"
# If an error occurs: "sudo apt install genisoimage"

	@echo "  BUILD   $(DISK)"
	@$(MAKE) isoimage FDARGS="initrd=/init.cpio" FDINITRD=../init/build/init.cpio --no-print-directory -C kernel $(STDOUT)
	@cp kernel/arch/x86/boot/image.iso $(DISK)

# ------------------------------------------------------------------------------

clean: clean-kernel clean-init clean-iso

clean-kernel:

	@echo "  CLEAN   kernel"
	@$(MAKE) --no-print-directory distclean -C kernel $(STDOUT)

clean-init:

	@echo "  CLEAN   init"
	@$(MAKE) --no-print-directory clean     -C init   $(STDOUT)

clean-iso:

	@echo "  CLEAN   iso"
	@rm $(DISK)

# ------------------------------------------------------------------------------

help:

	@echo "usage: make [MESSAGES=0 | MESSAGES=1] [all | clean | help | run]"
	@echo " "
	@echo "Download, build and run a minimal non-secure gnu-linux."
	@echo " "
	@echo "targets:"
	@echo "  all             build the minimal kernel and a user space application"
	@echo "  clean           reset project"
	@echo "  help            show this help message and exit"
	@echo "  run             run the build tiny-linux in qemu"
	@echo " "
	@echo "options:"
	@echo "  MESSAGES=n      detailed logging"
	@echo "                    0: no detailed logging"
	@echo "                    1: detailed logging"

# ------------------------------------------------------------------------------

run:

	@qemu-system-x86_64 -cdrom $(DISK) &
