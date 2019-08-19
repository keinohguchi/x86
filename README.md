# x86-64 Assembly Programming

[![CircleCI]](https://circleci.com/gh/keinohguchi/workflows/x86)

Ray Seyfarth's [Introduction to 64 Bit Assembly Language Programming]
in Action.

[CircleCI]: https://circleci.com/gh/keinohguchi/workflows/x86
[Introduction to 64 Bit Assembly Language Programming]: http://rayseyfarth.com/asm/

## Programs

- [hello.asm]: Hello world program
  - [hello_test.c]: [hello.asm] unit test
- [cmdline.asm]: Command line argument handling example
  - [cmdline_test.c]: [cmdline.asm] unit test
- [memory.asm]: Data and BSS memory handling example
  - [memory_test.c]: [memory.asm] unit test
- [register.asm]: Registers exmaple
  - [register_test.c]: [register.asm] unit test
- [bit.asm]: Bit operation example
  - [bit_test.c]: [bit.asm] unit test
- [countbits.asm]: Bit counting example
  - [countbits_test.c]: [countbits.asm] unit test
- [factorial.asm]: Factorial example
  - [factorial_test.c]: [factorial.asm] unit test

[hello.asm]: hello.asm
[hello_test.c]: hello_test.c
[cmdline.asm]: cmdline.asm
[cmdline_test.c]: cmdline_test.c
[memory.asm]: mem.asm
[memory_test.c]: mem_test.c
[register.asm]: register.asm
[register_test.c]: register_test.c
[bit.asm]: bit.asm
[bit_test.c]: bit_test.c
[countbits.asm]: countbits.asm
[countbits_test.c]: countbits_test.c
[factorial.asm]: factorial.asm
[factorial_test.c]: factorial_test.c

## Tests

`make test` runs unit tests driven by the command line arguments

```sh
$ make test
hello_test:     PASS
cmdline_test:   PASS
memory_test:    PASS
register_test:  PASS
bit_test:       PASS
countbits_test: PASS
factorial_test: PASS
```

Happy Hacking!
