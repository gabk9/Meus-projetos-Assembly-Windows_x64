global main
extern printf
extern scanf
extern system

section .data
    msg db "[1] Addition", 0x0A, "[2] Subtraction", 0x0A, "[3] Multiplication", 0x0A,"[4] division", 0x0A,"[0] Exit", 0x0A,"Choose an option: ", 0x00
    fmt db "%d", 0x00
    error1 db "Invalid option!!", 0x00
    cmd db "pause", 0x00
    newline db 0x0A, 0x00
    leaving db 0x0A, "Leaving...", 0x0A, 0x00
    input db "Enter a number: ", 0x00
    numFmt db "%f", 0x00
    addRes db 0x0A, "%.2f + %.2f = %.2f", 0x0A, 0x00
    op dd 0x00
    num1 dd 0x00
    num2 dd 0x00

section .text
main:
    sub rsp, 0x28

main_loop:
    lea rcx, [rel msg]
    xor rax, rax
    call printf

    lea rcx, [rel fmt]
    lea rdx, [rel op]
    call scanf

    mov eax, dword [rel op]

    cmp eax, 1
    je addition_menu
    cmp eax, 0
    je end

    jmp main_loop

addition_menu:
    sub rsp, 0x08
    call ask_num
    add rsp, 0x08

    movq xmm0, [rel num1]
    movq xmm1, [rel num2]
    addss xmm0, xmm1

    cvtss2sd xmm0, xmm0
    cvtss2sd xmm1, [rel num1]
    cvtss2sd xmm2, [rel num2]

    sub rsp, 0x20
    lea rcx, [rel addRes]
    movq rdx, xmm1
    movq r8, xmm2
    movq r9, xmm0
    mov rax, 3
    call printf
    add rsp, 0x20

    jmp main_loop

ask_num:
    lea rcx, [rel newline]
    xor rax, rax
    call printf

    lea rcx, [rel input]
    xor rax, rax
    call printf

    lea rcx, [rel numFmt]
    lea rdx, [rel num1]
    call scanf

    lea rcx, [rel input]
    xor rax, rax
    call printf

    lea rcx, [rel numFmt]
    lea rdx, [rel num2]
    call scanf
    ret
    
end:
    lea rcx, [rel leaving]
    xor rax, rax
    call printf

    lea rcx, [rel cmd]
    call system

    add rsp, 0x28
    xor eax, eax
    ret