global main
extern printf

section .data
    msg db "Number: %d", 10, "Sum: %d", 10, 0

section .text
main:
    sub rsp, 40

    mov rax, 3
    mov rbx, 1
    mov r10, 0

.loop:
    add r10, rbx
    inc rbx
    cmp rbx, rax
    jle .loop

    lea rcx, [rel msg]
    mov rdx, rax
    mov r8, r10

    call printf

    add rsp, 40
    xor eax, eax
    ret