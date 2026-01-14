global main

extern printf

%macro makeSeq 1
    section .data
    %assign i 0
    %rep %1
        db i
        %assign i i+1
    %endrep
%endmacro

section .data
    msg db "%d sequential bytes created", 0xA, 0x0 
    nBytes equ 10
    makeSeq nBytes

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