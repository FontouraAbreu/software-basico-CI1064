.section .data
    I: .quad 0 # %rdi
    LISTA: .quad 1,1,1,1,1,1,1,1,1,1 # %rbx
    SOMA: .quad 0 # %rax
.section .text
.globl _start
_start:
    movq $0, %rdi
    movq $0, %rax
loop:
    movq LISTA(, %rdi, 8), %rbx
    addq %rbx, %rax
    cmpq $9, %rdi
    jge fim_loop
    addq $1, %rdi
    jmp loop
fim_loop:
    movq %rax, %rdi
    call printf
    movq $60, %rax
    syscall
    