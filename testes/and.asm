global main
extern printf

section .data
    msg db "%d & %d = %d", 10, 0

section .text
main:
    sub rsp, 40

    mov rax, 5
    mov rbx, 1
    mov r10, rax
    and rax, rbx

    lea rcx, [rel msg]
    mov rdx, r10
    mov r8, r10
    mov r9, rax
    
    call printf

    add rsp, 40
    xor eax, eax
    ret