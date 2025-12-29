global main
extern printf

section .data
    msg db "RAX -> %d", 10
        db "RBX -> %d", 10, 0

section .text
main:
    sub rsp, 32

    mov rax, 10
    mov rbx, 20
    xchg rax, rbx

    lea rcx, [rel msg]
    mov rdx, rax
    mov r8, rbx

    call printf

    add rsp, 32
    xor eax, eax
    ret