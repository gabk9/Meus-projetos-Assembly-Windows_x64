global main
extern printf

section .data
    msg db "RAX -> %d", 10
        db "RAX -> %d", 10, 0

section .text
main:
    sub rsp, 32

    mov rax, 10
    mov rbx, rax
    not rax

    lea rcx, [rel msg]
    mov rdx, rbx
    mov r8, rax

    call printf

    add rsp, 32
    xor eax, eax
    ret