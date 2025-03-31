## Goal

Creation of a tiny linux kernel image without operating system (only a user space application: init).

The created image can be used with qemu to test applications written for the Linux kernel without libraries like libc.

The created image is not suited for production purposes since it contains no security elements whatsoever.

## Use

#### Install

    git clone git@github.com:Pynckels/tiny-linux.git

#### Get help

    make help

#### Run make procedure

    make

#### Test build iso image

    make run

## Credits

Idea and most of the procedure: https://www.youtube.com/@nirlichtman
