.section .data
    VETOR: .quad 1, 6, 7, 4, 5, 6, 7, 8, 9, 10 # %rax
    SUBVETOR: .quad 6, 7, 8    # %rbx
.section .text
.globl _start
_start:
    movq $0, %rdi    # I
    movq $0, %rsi    # J
    movq $0, %rcx    # I temp
main_loop:
    movq %rcx, %rdi # retorna o valor anterior de I
    cmpq $9, %rdi  # verifica fim do loop
    je fim_err     # não tem o subvetor
    movq VETOR(, %rdi, 8), %rax     # salva vetor[i]
    movq SUBVETOR(, %rsi, 8), %rbx # salva subvetor[j]
    movq %rdi, %rcx # salva variável temporária, para caso não encontre o subvetor
    cmpq %rbx, %rax # compara vetor[i] e subvetor[j]
    je sub_loop    # pula pro outro laco se forem iguais
    addq $1, %rcx   # soma i
    jmp main_loop   # proximo loop
sub_loop:
    addq $1, %rdi   # i++
    addq $1, %rsi   # j++
    cmpq $3, %rsi   # confere fim do subloop
    je fim_succ    # tem subvetor
    cmpq $9, %rdi   # confere fim do loop principal
    je fim_err      # não tem o subvetor
    movq VETOR(, %rdi, 8), %rax     # salva vetor[i] em rax
    movq SUBVETOR(, %rsi, 8), %rbx  # salva subvetor[j] em rbx
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
