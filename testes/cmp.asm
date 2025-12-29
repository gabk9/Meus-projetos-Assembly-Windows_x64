global main
extern printf

section .data
    msg db "%d > %d = %d", 10, 0

section .text
main:
    sub rsp, 40

    mov rax, 10
    mov rbx, 20
    mov r10, rax
    cmp rax, rbx
    setg al         ; if rax > rbx al = 1
    movzx r11, al

    lea rcx, [rel msg]
    mov rdx, r10
    mov r8, rbx
    mov r9, r11

    call printf

    add rsp, 40
    xor eax, eax
    ret