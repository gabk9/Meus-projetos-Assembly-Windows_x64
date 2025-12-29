global main
extern printf
extern fgets
extern __acrt_iob_func

section .data
    input db "Type-in a message: ", 0
    msg db "String size: %d", 10, 0
    lastMsg db "String size without spaces: %d", 10, 0
    newline db 10, 0
    MAX_CHAR equ 256

section .bss
    buffer resb MAX_CHAR

section .text
main:
    sub rsp, 40
    
    sub rsp, 32
    lea rcx, [rel input]
    call printf
    add rsp, 32

    mov ecx, 0
    call __acrt_iob_func
    mov r8, rax

    sub rsp, 32
    lea rcx, [rel buffer]
    mov rdx, MAX_CHAR
    call fgets
    add rsp, 32

    lea rsi, [rel buffer]
    xor rdi, rdi

strlen_total:
    mov al, [rsi]
    test al, al
    jz print_total
    
    inc rdi
    inc rsi
    jmp strlen_total

print_total:
    sub rsp, 32
    lea rcx, [rel msg]
    dec edi
    mov edx, edi
    xor rax, rax
    call printf
    add rsp, 32

    lea rsi, [rel buffer]
    xor rdi, rdi

strlen_no_spaces:
    mov al, [rsi]
    test al, al
    jz print_no_spaces
    
    cmp al, ' '
    je skip_space
    
    inc rdi

skip_space:
    inc rsi
    jmp strlen_no_spaces

print_no_spaces:
    sub rsp, 32
    lea rcx, [rel lastMsg]
    dec edi
    mov edx, edi
    xor rax, rax
    call printf
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel newline]
    call printf
    add rsp, 32

    add rsp, 40
    xor eax, eax
    ret