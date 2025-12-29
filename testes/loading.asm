global main
extern putchar
extern Sleep

section .data
    ms dd 80
    lc dd 100

    ASCII:
        dq str1, str2, str3, str4

    str1 db 0x0D, '\\', 0x00    
    str2 db 0x0D, '|', 0x00
    str3 db 0x0D, '/', 0x00
    str4 db 0x0D, '-', 0x00

section .text
main:
    push rbp
    mov rbp, rsp

    lea rbx, [rel ASCII]
    xor rsi, rsi
    xor rdi, rdi

.loop:
    cmp esi, [rel lc]
    jge .end

    sub rsp, 0x20
    mov rcx, [rbx + rdi*0x08]
    movzx rcx, byte [rcx]
    call putchar
        
    mov rcx, [rbx + rdi*0x08]
    movzx rcx, byte [rcx + 0x01]
    call putchar
    add rsp, 0x20

    sub rsp, 0x20
    mov ecx, [rel ms]
    call Sleep
    add rsp, 0x20

    inc rdi
    and edi, 0x03

    inc esi
    jmp .loop

.end:
    sub rsp, 0x20
    mov rcx, 0x0A
    call putchar
    add rsp, 0x20

    pop rbp
    xor eax, eax
    ret