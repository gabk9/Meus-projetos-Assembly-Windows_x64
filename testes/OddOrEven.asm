global main
extern printf
extern scanf
extern system

section .data
    prompt db "Type-in a number, type 0 to exit: ", 0
    prompt_in db "%d", 0

    odd db "%lld is an odd number", 10, 0
    evn db "%lld is an even number", 10, 0
    zer db "the number %lld is neutral, btw terminating program...", 10, 0

    cmd db "pause", 0

section .bss
    number resq 1

section .text
main:
    sub rsp, 40

start_loop:
    lea rcx, [rel prompt]
    call printf

    lea rcx, [rel prompt_in]
    lea rdx, [rel number]
    call scanf

    mov rax, [rel number]
    test rax, rax
    jz is_zero

    test rax, 1
    jnz is_odd
    jmp is_even

is_odd:
    lea rcx, [rel odd]
    mov rdx, rax
    call printf
    jmp start_loop

is_even:
    lea rcx, [rel evn]
    mov rdx, rax
    call printf
    jmp start_loop

is_zero:
    lea rcx, [rel zer]
    mov rdx, rax
    call printf
    jmp endif

endif:
    lea rcx, [rel cmd]
    xor rax, rax
    call system
    
    add rsp, 40
    xor eax, eax
    ret
