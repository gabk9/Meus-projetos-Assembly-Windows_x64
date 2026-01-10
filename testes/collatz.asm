global main

extern printf
extern scanf
extern system

section .data
    input db "Enter a number: ", 0x0
    fmt db "%d", 0x0
    num db "%d ", 0x0 
    newline db 10, 0
    err db "Error: must be at least greater than 1", 0xA, 0x0
    sysPause db "pause", 0x0

section .bss
    n resd 1

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

    cmp eax, 1
    jle is_less0

    mov ebx, eax

    lea rcx, [rel num]
    mov edx, ebx
    xor eax, eax
    call printf

collatz:
    .loop:
        cmp ebx, 1
        je end

        test ebx, 1
        jnz .is_odd

    .is_even:
        mov eax, ebx
        xor edx, edx
        mov ecx, 2
        div ecx
        mov ebx, eax
        jmp .print

    .is_odd:
        imul ebx, ebx, 3
        inc ebx

    .print:
        lea rcx, [rel num]
        mov edx, ebx
        xor eax, eax
        call printf
        jmp .loop

        jmp end

is_less0:
    lea rcx, [rel err]
    xor rax, rax
    call printf

end:
    lea rcx, [rel newline]
    call printf

    lea rcx, [rel sysPause]
    call system

    add rsp, 0x28
    xor eax, eax
    ret
