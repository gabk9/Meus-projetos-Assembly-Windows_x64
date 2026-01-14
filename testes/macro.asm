global main
extern printf

%macro intDiv 4
    mov rax, %1
    cqo
    idiv %2
    mov %3, rax      ; quotient
    mov %4, rdx      ; remainder
%endmacro

section .data
    msg db "%d / %d = %d", 10, "Remainder: %d", 10, 0

section .text
main:
    sub rsp, 40

    mov r10, 20          ; dividend
    mov r11, 3           ; divisor

    intDiv r10, r11, rax, r12

    lea rcx, [rel msg]
    mov rdx, r10         ; dividend
    mov r8,  r11         ; divisor
    mov r9,  rax         ; quotient
    mov [rsp + 32], r12  ; remainder

    call printf

    add rsp, 40
    xor eax, eax
    ret
