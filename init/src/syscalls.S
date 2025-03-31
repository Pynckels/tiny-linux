# Copyright 2025 Filip Pynckels
# See https://github.com/Pynckels/tiny-linux/blob/main/LICENSE

# This software is distributed as-is, with no warranty or
# guarantee of its functionality, performance, or usability.

.intel_syntax noprefix

# ------------------------------------------------------------------------------

.global sys_exit
.global sys_execve
.global sys_fork
.global sys_read
.global sys_waitid
.global sys_write

# ------------------------------------------------------------------------------
# Terminate the calling process
#
# Params:
#   %rax - 60
#   %rdi - int error_code
#
# This call does not return to the caller
# ------------------------------------------------------------------------------

sys_exit:
        mov rax, 60
        syscall

# ------------------------------------------------------------------------------
# Execute program
#
# Params:
#   %rax - 59
#   %rdi - const char *filename
#   %rsi - const char *const argv[]
#   %rdx - const char *const envp[]
#
# Returncode:
#   %rax
# ------------------------------------------------------------------------------

sys_execve:
        mov rax, 59
        syscall
        ret

# ------------------------------------------------------------------------------
# Create a child process
#
# Params:
#   %rax - 57
#
# Returncode:
#   %rax
# ------------------------------------------------------------------------------

sys_fork:
        mov rax, 57
        syscall
        ret

# ------------------------------------------------------------------------------
# Read from a file descriptor
#
# Params:
#   %rax - 0
#   %rdi - unsigned int fd
#   %rsi - char *buf
#   %rdx - size_t count
#
# Returncode:
#   %rax
# ------------------------------------------------------------------------------

sys_read:
        mov rax, 0
        syscall
        ret

# ------------------------------------------------------------------------------
# Wait for process to change state
#
# Params:
#   %rax - 247
#   %rdi - int which
#   %rsi - pid_t upid
#   %rdx - struct siginfo *infop
#   %r10 - int options
#   %r8  - struct rusage *ru
#
# Returncode:
#   %rax
# ------------------------------------------------------------------------------

sys_waitid:
        mov rax, 247
        mov r10, rcx
        syscall
        ret

# ------------------------------------------------------------------------------
# Write to a file descriptor
#
# Params:
#   %rax - 1
#   %rdi - unsigned int fd
#   %rsi - const char *buf
#   %rdx - size_t count
#
# Returncode:
#   %rax
# ------------------------------------------------------------------------------

sys_write:
        mov rax, 1
        syscall
        ret
