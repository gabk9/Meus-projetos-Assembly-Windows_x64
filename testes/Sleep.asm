global main
extern printf
extern Sleep

section .data
    init db "Initializing timer...", 0x0A, 0x00
    msg db "Sleep de %d seconds", 0x0A, 0x00
    ms dd 3000

section .text
main:
    push rbp

    sub rsp, 0x20
    lea rcx, [rel init]
    xor rax, rax
    call printf
    add rsp, 0x20

    mov ecx, [rel ms]
    call Sleep

    mov eax, [rel ms]      
    mov ecx, 1000          
    cdq
    idiv ecx    

    sub rsp, 0x20
    lea rcx, [rel msg]
    mov edx, eax
    mov r8d, eax
    call printf
    add rsp, 0x20

    pop rbp
    xor eax, eax
    ret