#!/bin/bash
set -e

# Clean up
rm -f *.o test out_*.txt

# Assemble your NASM functions
nasm -f elf64 ft_strlen.s
nasm -f elf64 ft_strcmp.s
nasm -f elf64 ft_strcpy.s
nasm -f elf64 ft_strdup.s
nasm -f elf64 ft_write.s
nasm -f elf64 ft_read.s
nasm -f elf64 ft_list_push_front.s
nasm -f elf64 ft_list_size.s

# Compile test file
gcc -no-pie -o test main.c *.o

# Run libc version
echo "Running libc version..."
USE_LIBC=1 ./test

# Run asm version
echo "Running asm version..."
./test USE_LIBC=0 

# Compare outputs
echo "Diff between outputs:"
diff -u out_libc.txt out_asm.txt || echo "Differences found!"
