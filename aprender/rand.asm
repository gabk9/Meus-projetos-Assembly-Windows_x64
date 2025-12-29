global main
extern printf, time

section .data
    fmt db "Random number (1-100): %d", 10, 0

section .bss
    seed resd 1     ; armazenar a semente atual

section .text
main:
    ; inicializar a semente com o tempo atual
    sub rsp, 32                 ; alinhamento da stack
    xor rcx, rcx                ; time(NULL)
    call time
    mov [rel seed], eax         ; seed = tempo

    ; gerar um número pseudoaleatório
    mov eax, [rel seed]         ; eax = seed
    imul eax, eax, 1103515245   ; eax = seed * a
    add eax, 12345              ; eax = eax + c
    and eax, 0x7FFFFFFF         ; aplica mod 2^31
    mov [rel seed], eax         ; atualiza seed

    ; limitar para 1..100
    cdq                         ; estende sinal p/ edx
    mov ecx, 100                ; divisor = 100
    idiv ecx                    ; eax/ecx -> eax=quociente, edx=resto
    mov eax, edx                ; eax = resto
    add eax, 1                  ; deixa no intervalo 1..100

    ; preparar para printf
    lea rcx, [rel fmt]
    mov edx, eax                ; argumento = número aleatório
    xor rax, rax
    call printf

    add rsp, 32
    xor eax, eax
    ret
