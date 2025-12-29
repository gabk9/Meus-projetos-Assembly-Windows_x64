global main
extern printf

section .data
    number dd 12345       ; Número a ser convertido
    buffer times 12 db 0  ; Buffer para a string (máximo 11 dígitos + null terminator)
    msg db "number: %d -> String: '%s'", 10, 0

section .text
main:
    sub rsp, 40
    
    ; Converter número para string
    mov eax, [rel number]  ; Número a converter
    lea rdi, [rel buffer]  ; Buffer de destino
    call int_to_string
    
    ; Imprimir resultado
    lea rcx, [rel msg]
    mov edx, [rel number]
    lea r8, [rel buffer]
    call printf
    
    add rsp, 40
    xor eax, eax
    ret

; Função: int_to_string
; Entrada: EAX = número, RDI = ponteiro para buffer
; Saída: Buffer preenchido com string decimal
int_to_string:
    push rbx
    push rsi
    
    test eax, eax          ; Verificar se é zero
    jz .zero_case
    
    mov ebx, 10            ; Divisor
    lea rsi, [rdi + 11]    ; Começar do final do buffer
    mov byte [rsi], 0      ; Terminador nulo
    
    ; Verificar se é negativo
    test eax, eax
    jns .positive
    neg eax                ; Tornar positivo
    mov byte [rdi], '-'    ; Adicionar sinal de menos
    inc rdi
    
.positive:
    ; Loop de conversão usando divisões por 10
.convert_loop:
    dec rsi                ; Mover para posição anterior
    xor edx, edx           ; Limpar EDX para divisão
    div ebx                ; EDX:EAX / 10 → EAX=quociente, EDX=resto
    add dl, '0'            ; Converter dígito para ASCII
    mov [rsi], dl          ; Armazenar dígito
    test eax, eax          ; Verificar se terminou
    jnz .convert_loop
    
    ; Copiar string para início do buffer (se necessário)
    cmp rsi, rdi
    je .done               ; Já está no início
    
    ; Mover string para início do buffer
.move_to_start:
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    test al, al            ; Verificar terminador nulo
    jnz .move_to_start
    
    jmp .done
    
.zero_case:
    mov word [rdi], '0'    ; String "0"
    jmp .done
    
.done:
    pop rsi
    pop rbx
    ret