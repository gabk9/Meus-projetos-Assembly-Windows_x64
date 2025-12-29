global main
extern printf

section .data
    msg db "%d x %d = %d", 10 ,0

section .text
main:
    sub rsp, 40

    mov rax, 10
    mov rbx, 7
    mov r10, rax
    imul rax, rbx

    lea rcx, [rel msg]
    mov rdx, r10
    mov r8, rbx
    mov r9, rax
    call printf

    add rsp, 40
    xor eax, eax
    ret 