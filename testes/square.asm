global main

extern printf

section .data
    star db "*", 0x0
    newline db 10

    height equ 10
    width equ 25

section .text
main:
    sub rsp, 0x28

    mov r12, height
    
    .outer_loop:
        mov r13, width

        .inner_loop:
            lea rcx, [rel star]
            xor rax, rax
            call printf

            dec r13
            
            test r13, r13
            jnz .inner_loop

        lea rcx, [rel newline]
        xor rax, rax
        call printf

        dec r12
        
        test r12, r12
        jnz .outer_loop

        lea rcx, [rel newline]
        xor rax, rax
        call printf

    add rsp, 0x28
    xor eax, eax
    ret    