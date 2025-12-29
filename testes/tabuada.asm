global main
extern printf
extern scanf
extern system

section .data
    input db "Type-in a number: ", 0
    fmt db "%lld", 0     
    msg db "%lld x %lld = %lld", 10, 0
    cmd db "pause", 0
    num dd 0

section .text
main:
    sub rsp, 40
    
    sub rsp, 32
    lea rcx, [rel input]
    xor rax, rax
    call printf
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel fmt]
    lea rdx, [rel num]
    xor rax, rax
    call scanf
    add rsp, 32

    mov rsi, 1
    mov rbx, 10
    
.loop:
    mov rax, [rel num]
    imul rax, rsi

    lea rcx, [rel msg]
    mov rdx, [rel num]
    mov r8, rsi
    mov r9, rax
    xor rax, rax
    call printf
    
    inc rsi
    cmp rsi, rbx
    jle .loop


    lea rcx, [rel cmd]
    call system

    add rsp, 40
    xor eax, eax
    ret