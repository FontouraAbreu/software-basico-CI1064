#!/bin/bash
file=$(basename $1 .asm)
as -o ${file}.o ${file}.asm -g
ld -o ${file} ${file}.o -g

