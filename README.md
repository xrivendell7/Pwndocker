Pwndocker
===

A docker environment for pwn in ctf based on **phusion/baseimage**, which is a modified ubuntu 16.04 baseimage for docker. I forked and magic changed by [pwndocker](https://github.com/skysider/pwndocker)

### Usage

```bash
git clone https://github.com/TacXingXing/Pwndocker
cd Pwndocker
docker build -t pwndocker .
docker run -it -v -v $(pwd)/${ctf_name}:/ctf/work -p 23946:23946 --privileged --cap-add=SYS_PRTACE pwndocker
```

### included software

- [pwntools](https://github.com/Gallopsled/pwntools)  —— CTF framework and exploit development library
- [pwndbg](https://github.com/pwndbg/pwndbg)  —— a GDB plug-in that makes debugging with GDB suck less, with a focus on features needed by low-level software developers, hardware hackers, reverse-engineers and exploit developers
- [pwngdb](https://github.com/scwuaptx/Pwngdb) —— gdb for pwn
- [ropgadget](https://github.com/JonathanSalwan/ROPgadget)  —— facilitate ROP exploitation tool
- [roputils](https://github.com/inaz2/roputils)     —— A Return-oriented Programming toolkit
- [one_gadget](https://github.com/david942j/one_gadget) —— A searching one-gadget of execve('/bin/sh', NULL, NULL) tool for amd64 and i386
- [angr](https://github.com/angr/angr)   ——  A platform-agnostic binary analysis framework
- [radare2](https://github.com/radare/radare2) ——  A rewrite from scratch of radare in order to provide a set of libraries and tools to work with binary files
- [welpwn](https://github.com/matrix1001/welpwn) —— designed to make pwnning an art, freeing you from dozens of meaningless jobs.
- linux_server[64]     —— IDA 7.0 debug server for linux
- [tmux](https://tmux.github.io/)     —— a terminal multiplexer
- [ltrace](https://linux.die.net/man/1/ltrace)      —— trace library function call
- [strace](https://linux.die.net/man/1/strace)     —— trace system call

### added softwares

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) -- A delightful community-driven (with 1,300+ contributors) framework for managing your zsh configuration.
- [peda](https://github.com/scwuaptx/peda) -- Python Exploit Development Assistance for GDB
- [socat](http://www.dest-unreach.org/socat/) -- A relay for bidirectional data transfer between two independent data channels.
- [z3](https://github.com/Z3Prover/z3) --  Theorem Prover
- [seccomp-tools](https://github.com/david942j/seccomp-tools) -- Provide powerful tools for seccomp analysis
- [qemu](https://www.qemu.org) -- QEMU is a generic and open source machine emulator and virtualizer.
.gdbinit
.zshrc
.tmux.conf

### included glibc

Default compiled glibc path is `/glibc`.
- 2.19  —— ubuntu 12.04 default libc version
- 2.23  —— pwndocker default libc version
- 2.24  —— introduce vtable check in file struct
- 2.27  —— intruduce tcache in heap (since 2.26)
- 2.28  —— new libc version ubuntu19.04
- 2.29  —— new libc version ubuntu19.04
- 2.30  —— new libc version ubuntu19.10
- 2.31  —— new libc version ubuntu20.04


### include multiarch libraries

- arm -- gcc-5-arm-linux-gnueabi
- aarch64 -- gcc-5-aarch64-linux-gnu
- mips -- gcc-5-mips-linux-gnu
- mipsel -- gcc-5-mipsel-linux-gnu 
- mips64 -- gcc-5-mips64-linux-gnuabi64
- mips64el -- gcc-5-mips64el-linux-gnuabi64
- powerpc -- gcc-5-powerpc-linux-gnu
- powerpc64 -- gcc-5-powerpc64-linux-gnu
- powerpc64le -- gcc-5-powerpc64le-linux-gnu

#### How to run in custom libc version?

```shell
cp /glibc/2.27/64/lib/ld-2.27.so /tmp/ld-2.27.so
patchelf --set-interpreter /tmp/ld-2.27.so ./test
LD_PRELOAD=./libc.so.6 ./test
```
