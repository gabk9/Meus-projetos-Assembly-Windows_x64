global main

extern printf
extern scanf
extern system

section .data
    input db "Enter a number: ", 0x0
    fmt db "%d", 0x0

    zero db "Zero", 0xA, 0x0
    even db "Even", 0xA, 0x0
    odd db "Odd", 0xA, 0x0

    sysPause db "pause", 0x0

section .bss
    n resd 0

section .text
main:
    sub rsp, 0x28

    lea rcx, [rel input]
    xor rax, rax
    call printf

    lea rcx, [rel fmt]
    lea rdx, [rel n]
    call scanf

    mov eax, dword [rel n]

    test eax, eax
    jz .is_zero

    test eax, 1
    jnz .is_odd

.is_even:
    lea rcx, [rel even]
    xor rax, rax
    call printf
    
    jmp end

.is_odd:
    lea rcx, [rel odd]
    xor rax, rax
    call printf

    jmp end

.is_zero:
    lea rcx, [rel zero]
    xor rax, rax
    call printf

end:

    lea rcx, [rel sysPause]
    call system

    add rsp, 0x28
    xor eax, eax
    ret