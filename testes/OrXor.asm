global main
extern printf

section .data
    msg db "%d | %d = %d", 10
        db "%d ^ %d = %d", 10, 0 

section .text
main:
    sub rsp, 48

    mov rax, 5
    mov rbx, 3
    mov r10, rax
    or rax, rbx
    mov r11, r10
    xor r10, rbx

    lea rcx, [rel msg]
    mov rdx, r11    
    mov r8, rbx
    mov r9, rax
    mov [rsp + 32], r11
    mov [rsp + 40], rbx
    mov [rsp + 48], r10
    
    call printf

    add rsp, 48
    xor eax, eax
    ret