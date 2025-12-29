global main
extern printf

section .data
    msg db "%d / %d = %d"
        db 10, "Remainder: %d", 10, 0

section .text
main:
    sub rsp, 40

    mov rax, 20 
    xor rdx, rdx
    mov rbx, 3
    mov r10, rax      ; r10 = dividend
    mov r11, rbx      ; r11 = divisor
    idiv rbx          ; rax = quotient, rdx = remainder

    mov r12, rdx      ; r12 = remainder 
    
    lea rcx, [rel msg] 
    mov rdx, r10      ; dividend
    mov r8,  r11      ; divisor
    mov r9,  rax      ; quotient
    mov [rsp + 32], r12   ; remainder

    call printf

    add rsp, 40
    xor eax, eax
    ret
