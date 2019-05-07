# SPDX-License-Identifier: GPL-2.0
PROGS := exit
PROGS += fp
PROGS += int
PROGS += mem
SRCS  := $(patsubst %,%.asm,$(PROGS))
all: $(PROGS)
$(PROGS): $(SRCS)
	yasm -f elf64 -g dwarf2 -l $@.lst $@.asm
	gcc $(LDFLAGS) -o $@ $@.o
.PHONY: test clean
test: $(PROGS)
	@for prog in $^; do ./$$prog; done
clean:
	@$(RM) $(PROGS) *.o *.lst
