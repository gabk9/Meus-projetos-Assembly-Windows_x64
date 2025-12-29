global main
extern printf
extern scanf

section .data
    msg db "%.2f x %.2f = %.2f", 0x0A, 0x00
    input db "Enter a number: ", 0x00
    fmt db "%f", 0x00
    num1 dd 0.0
    num2 dd 0.0

section .text
main:
    sub rsp, 0x28
    
    sub rsp, 0x20
    lea rcx, [rel input]
    xor rax, rax
    call printf
    add rsp, 0x20

    sub rsp, 0x20
    lea rcx, [rel fmt]
    lea rdx, [rel num1]
    call scanf
    add rsp, 0x20
    
    sub rsp, 0x20
    lea rcx, [rel input]
    xor rax, rax
    call printf
    add rsp, 0x20

    sub rsp, 0x20
    lea rcx, [rel fmt]
    lea rdx, [rel num2]
    call scanf
    add rsp, 0x20

    movq xmm0, [rel num1]
    movq xmm1, [rel num2]
    mulss xmm0, xmm1

    cvtss2sd xmm0, xmm0
    cvtss2sd xmm1, [rel num1]
    cvtss2sd xmm2, [rel num2]

    sub rsp, 0x20
    lea rcx, [rel msg]
    movq rdx, xmm1
    movq r8, xmm2
    movq r9, xmm0
    mov rax, 3
    call printf
    add rsp, 0x20

    add rsp, 0x28
    xor eax, eax
    ret