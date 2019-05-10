# SPDX-License-Identifier: GPL-2.0
PROGS := exit
PROGS += fp
PROGS += int
PROGS += mem
PROGS += reg
PROGS += add
PROGS += sum
PROGS += sub
PROGS += add2
SRCS  := $(patsubst %,%.asm,$(PROGS))
QEMU  ?= /usr/bin/qemu-aarch64-static
all: $(PROGS)
$(PROGS): $(SRCS)
	yasm -f elf64 -g dwarf2 -l $@.lst $@.asm
	gcc -static -o $@ $@.o
.PHONY: test clean
test: $(PROGS)
	@for prog in $^;                  \
	do printf "$$prog:\t";            \
		if ./$$prog;              \
		then echo "PASS";         \
		else echo "FAIL"; exit 1; \
		fi;                       \
	done
clean:
	@$(RM) $(PROGS) *.o *.lst
# Docker based compilation.
.PHONY: amd64
amd64: amd64-image
	docker run -v $(PWD):/home/build x86/$@ make all clean
%-image:
	if [ -x $(QEMU) ]; then cp $(QEMU) .; fi
	docker build -t x86/$* -f Dockerfile.$* .
%-amd64: amd64-image
	docker run -v $(PWD):/home/build x86/amd64 make $* clean
