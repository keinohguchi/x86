# x86-64 Assembly Programming

[![CircleCI]](https://circleci.com/gh/keinohguchi/workflows/x86)

Ray Seyfarth's [Introduction to 64 Bit Assembly Language Programming]
in Action.

[CircleCI]: https://circleci.com/gh/keinohguchi/workflows/x86
[Introduction to 64 Bit Assembly Language Programming]: http://rayseyfarth.com/asm/

## Programs

- [hello.asm]: Hello world program
  - [hello_test.c]: [hello.asm] unit test

[hello.asm]: hello.asm
[hello_test.c]: hello_test.c

## Tests

`make test` will run fork(2)/execv(3) based unit test:

```sh
$ make test
hello_test:      PASS
```

Happy Hacking!
