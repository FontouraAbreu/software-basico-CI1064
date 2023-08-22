.section .data
    I: .quad 0  # %rdi
    J: .quad 0  # %rsi
    VETOR: .quad 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 # %rax
    SUBVETOR: .quad 6, 7, 8    # %rbx
    HAS_SUB: .quad 0 # %rcx
.section .text
.globl _start
_start:
    movq $0, I
    movq $0, J
    movq $0, HAS_SUB

main_loop:
    movq I, %rdi    # rdi=0
    cmpq $10, %rdi  # verifica fim do loop
    je fim_err     # não tem o subvetor
    movq J, %rsi    # rsi=0
    movq VETOR(, %rdi, 8), %rax     # salva vetor[i]
    movq SUBVETOR(, %rsi, 8), %rbx # salva subvetor[j]
    cmpq %rbx, %rax # compara vetor[i] e subvetor[j]
    je sub_loop    # pula pro outro laco se forem iguais
    addq $1, %rdi   # soma i
    movq %rdi, I    # salva em I
    jmp main_loop   # proximo loop
sub_loop:
    addq $1, %rdi   # i++
    addq $1, %rsi   # j++
    cmpq $4, %rdi   # confere fim do subloop
    je fim_succ    # tem subvetor
    movq VETOR(, %rdi, 8), %rax     # salva vetor[i] em rax
    movq SUBVETOR(, %rdi, 8), %rbx  # salva subvetor[j] em rbx
    cmpq %rbx, %rax # compara vetor[i] e subvetor[j]
    jne main_loop   # volta pro loop principal
    jmp sub_loop    # proxima iteracao
fim_err:
    movq $60, %rax
    movq $1, %rdi   # sinal de erro
    syscall
fim_succ:
    movq $60, %rax
    movq $0, %rdi   # sinal de sucesso
    syscall
