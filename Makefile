#
# Linux makefile
# Use with make 
#

AS		:= nasm
ASFLAGS := -f elf
CFLAGS	:= -m32
LDFLAGS := -m32
CC		:= gcc
CXX		:= g++
CXXFLAGS := -m32 -O0 -g
TARGETS :=  fibo_2
DEP := driver.o

.PHONY: clean

%.o: %.asm
	$(AS) $(ASFLAGS) $< 

all: $(TARGETS) 

calc_fibo_2.o : calc_fibo_2.c
	$(CC) $(CXXFLAGS)  -c calc_fibo_2.c  -o calc_fibo_2.o

fibo_2: fibo_2.o calc_fibo_2.o 
	$(CC) $(CXXFLAGS) fibo_2.o calc_fibo_2.o   -o fibo_2
clean :
	rm -f *.o $(TARGETS)
