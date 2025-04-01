// Copyright 2025 Filip Pynckels
// See https://github.com/Pynckels/tiny-linux/blob/main/LICENSE

// This software is distributed as-is, with no warranty or
// guarantee of its functionality, performance, or usability.

#include "sys.h"

// -----------------------------------------------------------------------------

#define NULL    (void *)0
#define STDIN   0
#define STDOUT  1
#define PROMPT  "# "

// -----------------------------------------------------------------------------

__attribute__((section(".text.main")))
int main() {
    char      command[255];
    int       count;
    pid_t     fork_result;
    siginfo_t info;

    while (1) {
        sys_write(STDOUT, PROMPT, sizeof(PROMPT) - 1);

        count = sys_read(STDIN, command, sizeof(command));
        if (count <= 0) continue;                               // If read error: loop
        command[count - 1] = 0;                                 // Replace '\n' with '\0'

        fork_result = sys_fork();
        if (fork_result == 0) {
            sys_execve(command, NULL, NULL);                    // Run command in child process
            sys_exit(0);                                        // Exit child process
        } else {
            sys_waitid(P_ALL, 0, &info, WEXITED, NULL);         // Wait for all child processes
        }
    }

    sys_exit(0);                                                // This should never be reached
}
