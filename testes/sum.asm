global main
extern printf

section .data
    fmt db "%d + %d = %d", 10, 0

section .text
main:
    sub rsp, 40         ; allocate 40 bytes

    mov rax, 5          ; rax = 5
    mov rbx, 3          ; rbx = 3
    mov r10, rax        ; r10 = rax
    add rax, rbx        ; rax += rbx

    lea rcx, [rel fmt]  ; rcx = &fmt
    mov rdx, r10        ; rdx = r10
    mov r8, rbx         ; r8 = rbx
    mov r9, rax         ; r9 = rax
    call printf

    add rsp, 40         ; 40 bytes freed
    mov eax, 0          ; same as "xor eax, eax", both means "return 0;" in C
    ret