# SPDX-License-Identifier: GPL-2.0
PROGS  := hello
PROGS  += memory
PROGS  += register
PROGS  += bit
PROGS  += countbits
PROGS  += factorial
ASMS   := $(patsubst %,%.asm,$(PROGS))
TESTS  := $(patsubst %,%_test,$(PROGS))
CSRCS  := $(filter-out *_test.c,$(wildcard *.c))
DASMS  := $(patsubst %.c,%.s,$(CSRCS))
CFLAGS += -Wall
CFLAGS += -Werror
CFLAGS += -Wimplicit-fallthrough
.PHONY: run test clean $(TESTS)
all: $(PROGS) $(DASMS) run test
run: $(PROGS)
	@for prog in $^;                           \
	do if ./$$prog;                            \
	then printf "%-16s%4s\n" "$$prog:" "PASS"; \
	else printf "%-16s%4s\n" "$$prog:" "FAIL"; \
	fi; done
test: $(PROGS) $(TESTS)
$(TESTS):
	@$(CC) $(CFLAGS) -o $@ $@.c
	@if ./$@;                                      \
	then printf "%-16s%4s\n" "$@:" "PASS";         \
	else printf "%-16s%4s\n" "$@:" "FAIL"; exit 1; \
	fi
%: %.asm
	yasm -f elf64 -g dwarf2 -l $@.lst $<
	$(CC) $(CFLAGS) -g -static -o $@ $@.o
%.s: %.c
	$(CC) $(CFLAGS) -O3 -S -masm=intel $<
clean:
	@$(RM) $(PROGS) $(TESTS) *.o *.s *.lst
# Docker based compilation.
.PHONY: amd64
amd64: amd64-image
	docker run -v $(PWD):/home/build x86/$@ make all clean
%-image:
	docker build -t x86/$* -f Dockerfile.$* .
%-amd64: amd64-image
	docker run -v $(PWD):/home/build x86/amd64 make $* clean
