// Copyright 2025 Filip Pynckels
// See https://github.com/Pynckels/tiny-linux/blob/main/LICENSE

// This software is distributed as-is, with no warranty or
// guarantee of its functionality, performance, or usability.

#include <sys/syscall.h>
#include <stdarg.h>

#include "sys.h"

// -----------------------------------------------------------------------------

long int syscall(long int __sysno, ...) {
    va_list args;
    va_start(args, __sysno);
    register long rax asm("rax") = __sysno;
    register long rdi asm("rdi") = va_arg(args, long);
    register long rsi asm("rsi") = va_arg(args, long);
    register long rdx asm("rdx") = va_arg(args, long);
    register long r10 asm("r10") = va_arg(args, long);
    register long r8 asm("r8") = va_arg(args, long);
    register long r9 asm("r9") = va_arg(args, long);
    asm volatile ("syscall"
                  : "=a"(rax)
                  : "0"(rax), "D"(rdi), "S"(rsi), "d"(rdx), "r"(r10), "r"(r8), "r"(r9)
                  : "rcx", "r11", "memory");
    va_end(args);
    return rax;
}

// -----------------------------------------------------------------------------

void sys_exit(int error_code)
{
    syscall(SYS_exit, error_code);
}

// -----------------------------------------------------------------------------

long int  sys_execve(const char __user *filepath,
                    const char __user *const __user *argv,
                    const char __user *const __user *envp)
{
    return syscall(SYS_execve, filepath, argv, envp);
}

// -----------------------------------------------------------------------------

long int sys_fork(void)
{
    return syscall(SYS_fork);
}

// -----------------------------------------------------------------------------

long int sys_read(unsigned int fd,
                  char __user *buffer,
                  int buffer_size)
{
    return syscall(SYS_read, fd, buffer, buffer_size);
}

// -----------------------------------------------------------------------------

long int sys_waitid(int which,
                    pid_t pid,
                    siginfo_t __user *infop,
                    int options,
                    struct rusage __user *ru)
{
    return syscall(SYS_waitid, which, pid, infop, options, ru);
}

// -----------------------------------------------------------------------------

long int sys_write(unsigned int fd,
                   const char __user *buffer,
                   size_t buffer_size)
{
    return syscall(SYS_write, fd, buffer, buffer_size);
}
