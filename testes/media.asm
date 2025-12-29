global main
extern printf
extern scanf

section .data
    input db "Enter a number: ", 0
    fmt db "%f", 0
    msg db "Arithmetic Mean: %.2f", 10, 0
    num times 3 dd 0

section .text
main:
    sub rsp, 40
    mov rbx, 3
    xor rsi, rsi

.read_loop:
    sub rsp, 32
    lea rcx, [rel input]
    xor rax, rax
    call printf
    add rsp, 32

    sub rsp, 32
    mov rax, rsi
    imul rax, 4
    lea rdx, [rel num]
    add rdx, rax
    lea rcx, [rel fmt]
    call scanf
    add rsp, 32

    inc rsi 
    cmp rsi, rbx
    jl .read_loop

    lea rax, [rel num]
    movq xmm0, [rax]
    movq xmm1, [rax+4]
    movq xmm2, [rax+8]

    addss xmm0, xmm1
    addss xmm0, xmm2
    
    cvtsi2ss xmm3, rbx
    divss xmm0, xmm3
    cvtss2sd xmm0, xmm0
    
    lea rcx, [rel msg]
    movq rdx, xmm0
    mov rax, 1
    call printf

    add rsp, 40
    xor eax, eax
    ret