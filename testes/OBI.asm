global main

extern printf
extern scanf

default rel

section .data
    fmt1 db "%d%d", 0
    fmt2 db "%d", 0x0A, 0

    maior_chegada dd 0
    menor_partida dd 0

section .bss
    chegada resd 1
    partida resd 1

section .text
main:
    sub rsp, 0x28

    lea rcx, [rel fmt1]
    lea rdx, [rel chegada]
    lea r8, [rel partida]
    call scanf

    mov eax, [chegada]
    mov [maior_chegada], eax

    mov eax, [partida]
    mov [menor_partida], eax

    xor rdi, rdi
    .loop:
        lea rcx, [rel fmt1]
        lea rdx, [rel chegada]
        lea r8, [rel partida]
        call scanf

        mov eax, [chegada]
        cmp eax, [maior_chegada]
        jg .cond1

        jmp .skip

        .cond1:
            mov eax, [chegada]
            mov [maior_chegada], eax

        .skip:
            mov eax, [menor_partida]
            cmp dword [partida], eax
            jl .cond2

            jmp .end

        .cond2:
            mov eax, [partida]
            mov [menor_partida], eax

        .end:
            inc rdi

            cmp rdi, 2
            jl .loop

    mov eax, [maior_chegada]
    cmp eax, [menor_partida]
    jg .zero

    mov eax, [menor_partida]
    sub eax, [maior_chegada]
    inc eax
    jmp .print

    .zero:
        xor eax, eax

    .print:
        sub rsp, 0x20
        lea rcx, [rel fmt2]
        mov edx, eax
        call printf
        add rsp, 0x20


    add rsp, 0x28
    xor eax, eax
    ret