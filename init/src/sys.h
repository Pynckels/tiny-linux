// Copyright 2025 Filip Pynckels
// See https://github.com/Pynckels/tiny-linux/blob/main/LICENSE

// This software is distributed as-is, with no warranty or
// guarantee of its functionality, performance, or usability.

#ifndef __SYS_H__
#define __SYS_H__

    #include <sys/wait.h>

    #define __user

    void sys_exit(int error_code);

    long sys_execve(const char __user *filepath,
                    const char __user *const __user *argv,
                    const char __user *const __user *envp);

    long sys_fork(void);

    long sys_read(unsigned int fd,
                  char __user *buffer,
                  int buffer_size);

    long sys_waitid(int which,
                    pid_t pid,
                    siginfo_t __user *infop,
                    int options,
                    struct rusage __user *ru);

    long sys_write(unsigned int fd,
                   const char __user *buffer,
                   size_t buffer_size);

#endif // __SYS_H__
