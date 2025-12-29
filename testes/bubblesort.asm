global main
extern printf
extern scanf
extern system

section .data
    input db "Type in a number: ", 0
    fmt db "%d", 0
    msg db "Array in ascending order:", 10, 0
    arr db "%d ", 0
    newline db 10, 0
    cmd db "pause", 0
    numbers times 5 dd 0

section .text
main:
    sub rsp, 40
    mov rbx, 5
    xor rsi, rsi
    
.read_loop:
    sub rsp, 32
    lea rcx, [rel input]
    call printf
    add rsp, 32

    sub rsp, 32
    mov rax, rsi
    imul rax, 4
    lea rdx, [rel numbers]
    add rdx, rax
    lea rcx, [rel fmt]  
    call scanf
    add rsp, 32

    inc rsi
    cmp rsi, rbx
    jl .read_loop

    mov rcx, rbx
    dec rcx
    jz .print

.outer_loop:
    xor rsi, rsi
    mov rdx, rcx

.inner_loop:
    lea rax, [rel numbers]
    mov edi, [rax + rsi*4]
    mov r8d, [rax + rsi*4 + 4]
    cmp edi, r8d        ; ascending order
    jle .no_swap
    
    mov [rax + rsi*4], r8d
    mov [rax + rsi*4 + 4], edi

.no_swap:
    inc rsi
    cmp rsi, rdx
    jl .inner_loop
    
    loop .outer_loop

.print:
    sub rsp, 32
    lea rcx, [rel msg]
    call printf
    add rsp, 32

    xor rsi, rsi

.print_loop:
    lea rax, [rel numbers]
    mov edx, [rax + rsi*4]
    
    sub rsp, 32
    lea rcx, [rel arr]
    call printf
    add rsp, 32

    inc rsi
    cmp rsi, rbx
    jl .print_loop

    sub rsp, 32
    lea rcx, [rel newline]
    xor rax, rax
    call printf
    sub rsp, 32

    sub rsp, 32
    lea rcx, [rel cmd]
    call system
    add rsp, 32


    add rsp, 40
    xor eax, eax
    ret