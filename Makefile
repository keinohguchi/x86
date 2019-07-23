# SPDX-License-Identifier: GPL-2.0
PROGS := hello
ASMS  := $(patsubst %,%.asm,$(PROGS))
TESTS := $(patsubst %.c,%,$(wildcard *_test.c))
CSRCS := $(filter-out *_test.c,$(wildcard *.c))
DASMS := $(patsubst %.c,%.s,$(CSRCS))
all: $(PROGS) $(DASMS) test
%: %.asm
	yasm -f elf64 -g dwarf2 -l $@.lst $<
	$(CC) -g -static -o $@ $@.o
%.s: %.c
	$(CC) -O3 -S -masm=intel $<
.PHONY: run test clean $(TESTS)
run: $(PROGS)
	@for prog in $^;                  \
	do printf "$$prog:\t";            \
		if ./$$prog;              \
		then echo "PASS";         \
		else echo "FAIL"; exit 1; \
		fi;                       \
	done
test: $(PROGS) $(TESTS)
$(TESTS):
	@$(CC) $(CFLAGS) -o $@ $@.c
	@if ./$@;                                      \
	then printf "%-14s%4s\n" "$@:" "PASS";         \
	else printf "%-14s%4s\n" "$@:" "FAIL"; exit 1; \
	fi
clean:
	@$(RM) $(PROGS) *.o *.s *.lst
# Docker based compilation.
.PHONY: amd64
amd64: amd64-image
	docker run -v $(PWD):/home/build x86/$@ make all clean
%-image:
	docker build -t x86/$* -f Dockerfile.$* .
%-amd64: amd64-image
	docker run -v $(PWD):/home/build x86/amd64 make $* clean
