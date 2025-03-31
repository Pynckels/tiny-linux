// Copyright 2025 Filip Pynckels
// See https://github.com/Pynckels/tiny-linux/blob/main/LICENSE

// This software is distributed as-is, with no warranty or
// guarantee of its functionality, performance, or usability.

#include "syscalls.h"

// -----------------------------------------------------------------------------

#define STDIN   0
#define STDOUT  1

#define PROMPT  "# "

// -----------------------------------------------------------------------------

int main()
{
    char      command[255];
    int       count;
    siginfo_t info;

    while (1) {
        sys_write(STDOUT, PROMPT, sizeof(PROMPT));
        count = sys_read(STDIN, command, sizeof(command));
        command[count - 1] = 0;                                 // Replace '\n' with '\0'
        pid_t fork_result = sys_fork();
        if (fork_result == 0) {
            sys_execve(command, 0, 0);
            break;
        } else {
            sys_waitid(P_ALL, 0, &info, WEXITED, 0);            // Wait for child processes
        }
    }
    sys_exit(0);
}
