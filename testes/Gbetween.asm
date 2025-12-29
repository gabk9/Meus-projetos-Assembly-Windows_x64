global main
extern printf
extern scanf

section .data
    prompt db "Type-in a number: ", 0
    prompt_in db "%d", 0
    msg db "The biggest number between %d, %d and %d is %d", 10, 0

section .bss
    numbers resd 3

section .text
main:
    sub rsp, 40
    xor rsi, rsi
    
.read_loop:
    sub rsp, 32
    lea rcx, [rel prompt]
    call printf
    add rsp, 32
    
    sub rsp, 32
    mov rax, rsi
    imul rax, 4
    lea rdx, [rel numbers]
    add rdx, rax
    lea rcx, [rel prompt_in]
    call scanf
    add rsp, 32
    
    inc rsi
    cmp rsi, 3
    jl .read_loop

    mov eax, dword [rel numbers]
    mov ebx, dword [rel numbers+4]
    mov ecx, dword [rel numbers+8]
    
    cmp eax, ebx
    cmovl eax, ebx
    cmp eax, ecx
    cmovl eax, ecx

    mov dword [rsp + 32], eax
    lea rcx, [rel msg]
    mov edx, dword [rel numbers]
    mov r8d, dword [rel numbers+4] 
    mov r9d, dword [rel numbers+8]
    call printf

    add rsp, 40
    xor eax, eax
    ret