global main
extern printf
extern scanf
extern fgets
extern __acrt_iob_func
extern putchar

section .data
    prompt db "Enter a string: ", 0
    echo_msg db "You entered: %s", 10, 0
    msg db "This string has vowels", 10, 0
    msg2 db "This string doesn't have any vowels", 10, 0
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
    mov r9, r8
    call fgets
    add rsp, 32

    sub rsp, 32
    lea rcx, [rel echo_msg]
    lea rdx, [rel buffer]
    call printf
    add rsp, 32

    lea rsi, [rel buffer]
    xor rdi, rdi

check_syllables:
    mov al, [rsi]
    cmp al, 0
    je check_result
    
    cmp al, 'a'
    je found_vowel
    cmp al, 'A'
    je found_vowel
    cmp al, 'e'
    je found_vowel
    cmp al, 'E'
    je found_vowel
    cmp al, 'i'
    je found_vowel
    cmp al, 'I'
    je found_vowel
    cmp al, 'o'
    je found_vowel
    cmp al, 'O'
    je found_vowel
    cmp al, 'u'
    je found_vowel
    cmp al, 'U'
    je found_vowel

    inc rsi
    jmp check_syllables

found_vowel:
    inc rdi
    inc rsi
    jmp check_syllables

check_result:
    cmp rdi, 0
    jg has_vowels
    
no_vowels:
    sub rsp, 32
    lea rcx, [rel msg2]
    xor rax, rax
    call printf
    add rsp, 32
    jmp end

has_vowels:
    sub rsp, 32
    lea rcx, [rel msg]
    xor rax, rax
    call printf
    add rsp, 32

end:
    sub rsp, 32
    lea rcx, [rel newline]
    call printf
    add rsp, 32

    add rsp, 40
    xor eax, eax
    ret