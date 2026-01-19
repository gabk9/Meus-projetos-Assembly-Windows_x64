global main

extern printf
extern scanf


section .data
    input db "Enter a number: ", 0x0
    fmt db "%lld", 0x0

    err db "The number must be greater or equal 0", 0xA, 0xA, 0x0
    msg db "%d factorial: %llu", 0xA, 0x0
    num dq 0

section .text
factorial:
    mov rax, 1
    cmp rcx, 1
    jle .done

    mov rsi, 2

    .loop:
        imul rax, rsi
        inc rsi
        cmp rsi, rcx
        jle .loop

    .done:
        ret

main:
    sub rsp, 0x28

start:
    lea rcx, [rel input]
    xor rax, rax
    call printf

    lea rcx, [rel fmt]
    lea rdx, [rel num]
    call scanf

    cmp qword [rel num], 0
    jl .isnegative

    mov rcx, [rel num]
    call factorial

    lea rcx, [rel msg]
    mov rdx, [rel num]
    mov r8, rax
    xor rax, rax
    call printf

    jmp end

.isnegative:
    lea rcx, [rel err]
    xor rax, rax
    call printf
    jmp start

end:
    add rsp, 0x28
    xor eax, eax
    ret
