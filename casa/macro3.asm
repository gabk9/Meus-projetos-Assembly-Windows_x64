global main
extern printf

%macro makeSquares 1
    section .data
    %assign i 1
    %rep %1
        dw i*i
        %assign i i+1
    %endrep
%endmacro

section .data
    msg db "%d", 0xA, 0x0
    num equ 10

    squares_data:
        makeSquares num

section .text
main:
    sub rsp, 40
    lea rsi, [rel squares_data]
    mov rbx, num

    .print_loop:
        movzx rdx, word [rsi]

        lea rcx, [rel msg]
        xor rax, rax
        call printf

        add rsi, 2
        dec rbx
        jnz .print_loop

    add rsp, 40
    xor eax, eax
    ret
