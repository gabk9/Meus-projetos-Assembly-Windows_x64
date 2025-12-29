global main
extern printf
extern scanf

section .data
    input db "Type-in a number: ", 0
    fmt db "%f", 0
    msg db "%.2f / %.2f = %.2f", 10, 0
    num1 dd 0.0
    num2 dd 0.0

section .text
main:
    sub rsp, 40

    lea rcx, [rel input]
    xor rax, rax
    call printf

    lea rcx, [rel fmt]
    lea rdx, [rel num1]
    xor rax, rax
    call scanf
    
    lea rcx, [rel input]
    xor rax, rax
    call printf

    lea rcx, [rel fmt]
    lea rdx, [rel num2]
    xor rax, rax
    call scanf

    movss xmm0, [rel num1]
    movss xmm1, [rel num2]
    divss xmm0, xmm1

    cvtss2sd xmm0, xmm0
    cvtss2sd xmm1, [rel num1]
    cvtss2sd xmm2, [rel num2]

    lea rcx, [rel msg]
    movq rdx, xmm1
    movq r8, xmm2
    movq r9, xmm0
    mov rax, 3
    call printf 

    add rsp, 40
    xor eax, eax
    ret