global main

extern printf

%macro makeZeros 1
    section .data
    times %1 db 0
%endmacro

section .data
    msg db "%d bytes created", 0xA, 0x0 
    nBytes equ 10
    makeZeros nBytes

section .text
main:
    sub rsp, 40

    lea rcx, [rel msg]
    mov rdx, nBytes
    xor rax, rax
    call printf

    add rsp, 40
    xor eax, eax
    ret