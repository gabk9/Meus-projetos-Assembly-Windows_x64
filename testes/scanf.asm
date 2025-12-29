global main
extern printf
extern scanf

section .data
    prompt db "Type-in a number: ", 0
    prompt_in db "%d", 0
    
    msg db "You typed: %d", 10, 0

section .text
main:
    sub rsp, 36

    lea rcx, [rel prompt]
    call printf

    lea rcx, [rel prompt_in]
    lea rdx, [rsp]
    call scanf

    mov eax, [rsp]
    lea rcx, [rel msg]
    mov edx, eax
    call printf

    add rsp, 36
    xor eax, eax
    ret
