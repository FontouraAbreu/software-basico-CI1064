#!/bin/bash
file=$(basename $1 .asm)
as -o ${file}.o ${file}.asm
ld -o ${file} ${file}.o

