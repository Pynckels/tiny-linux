// Copyright 2025 Filip Pynckels
// See https://github.com/Pynckels/tiny-linux/blob/main/LICENSE

// This software is distributed as-is, with no warranty or
// guarantee of its functionality, performance, or usability.

#ifndef __SYSCALLS_H__
#define __SYSCALLS_H__

    #include <sys/wait.h>

    #define __user

    void sys_exit(int error_code);

    long sys_execve(const char __user *filename,
                    const char __user *const __user *argv,
                    const char __user *const __user *envp);

    long sys_fork(void);

    long sys_read(const char __user *path,
                  char __user *buf,
                  int bufsiz);

    long sys_waitid(int which,
                    pid_t pid,
                    siginfo_t __user *infop,
                    int options,
                    struct rusage __user *ru);

    long sys_write(unsigned int fd,
                   const char __user *buf,
                   size_t count);

#endif // __SYSCALLS_H__
