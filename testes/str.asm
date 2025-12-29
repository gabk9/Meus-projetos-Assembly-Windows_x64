global main
extern printf
extern scanf
extern fgets
extern __acrt_iob_func
extern putchar

section .data
    prompt db "Enter a string: ", 0
    echo_msg db 10, "You typed: ", 0
    fmt db "%[^\n]", 0
    newline db 10, 0
    MAX_CHAR equ 256
        
section .bss
    buffer resb MAX_CHAR

section .text
main:
    sub rsp, 40

    sub rsp, 32
    lea rcx, [rel prompt]
    call printf
    add rsp, 32

    mov ecx, 0
    call __acrt_iob_func
    mov r8, rax 
    
    sub rsp, 32
    lea rcx, [rel buffer]
    mov rdx, MAX_CHAR
    call fgets
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel echo_msg]
    call printf
    add rsp, 32

    lea rsi, [rel buffer]

print_loop:
    mov al, [rsi]
    test al, al
    jz end_print
    
    sub rsp, 32
    movzx ecx, al 
    call putchar
    add rsp, 32
    
    inc rsi
    jmp print_loop

end_print:
    sub rsp, 32
    lea rcx, [rel newline]
    call printf
    add rsp, 32

    add rsp, 40
    xor eax, eax
    ret