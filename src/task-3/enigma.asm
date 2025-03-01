%include "../include/io.mac"

;; defining constants, you can use these as immediate values in your code
LETTERS_COUNT EQU 26

section .data
    extern len_plain
    word_aux_first db 0
    word_aux_second db 0

section .text
    global rotate_x_positions
    global enigma
    extern printf

; void rotate_x_positions(int x, int rotor, char config[10][26], int forward);
rotate_x_positions:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; x
    mov ebx, [ebp + 12] ; rotor
    mov ecx, [ebp + 16] ; config (address of first element in matrix)
    mov edx, [ebp + 20] ; forward
    ;; DO NOT MODIFY
    ;; TODO: Implement rotate_x_positions
    ;; FREESTYLE STARTS HERE

    push edx
    cmp eax, 0
    jz end

    xor esi, esi
    cmp edx, 0
    jz rotate_left
    jnz rotate_right

rotate_left: ; introducere prima litera din linie intr-un auxiliar
    push edx
    xor edi, edi
    push eax
    xor eax, eax

    mov eax, LETTERS_COUNT * 2
    mul ebx

    xor edx, edx
    mov dl, byte [ecx + eax]
    mov byte [word_aux_first], dl

    add eax, LETTERS_COUNT

    xor edx, edx
    mov dl, byte [ecx + eax]
    mov byte [word_aux_second], dl

rotate_loop_left: ; shiftare toate element spre stanga
    xor eax, eax

    mov eax, LETTERS_COUNT * 2
    mul ebx
    add eax, edi

    xor edx, edx
    mov dl, byte [ecx + eax + 1]
    mov byte [ecx + eax], dl

    add eax, LETTERS_COUNT

    xor edx, edx
    mov dl, byte [ecx + eax + 1]
    mov byte [ecx + eax], dl

    inc edi
    cmp edi, LETTERS_COUNT - 1
    jl rotate_loop_left

    sub eax, LETTERS_COUNT
    xor edx, edx
    mov dl, byte [word_aux_first]
    mov byte [ecx + eax + 1], dl

    add eax, LETTERS_COUNT
    xor edx, edx
    mov dl, byte [word_aux_second]
    mov byte [ecx + eax + 1], dl
    

    pop eax
    pop edx
    inc esi
    cmp eax, esi
    jg rotate_left

    jmp end


rotate_right: ; introducere ultima litera din linie intr-un auxiliar
    push edx
    xor edi, edi
    push eax
    xor eax, eax

    mov eax, LETTERS_COUNT * 2
    mul ebx
    add eax, LETTERS_COUNT - 1

    xor edx, edx
    mov dl, byte [ecx + eax]
    mov byte [word_aux_first], dl

    add eax, LETTERS_COUNT

    xor edx, edx
    mov dl, byte [ecx + eax]
    mov byte [word_aux_second], dl

rotate_loop_right: ; shiftare toate element spre dreapta
    xor eax, eax

    mov eax, LETTERS_COUNT * 2
    mul ebx
    add eax, LETTERS_COUNT - 1
    sub eax, edi

    xor edx, edx
    mov dl, byte [ecx + eax - 1]
    mov byte [ecx + eax], dl

    add eax, LETTERS_COUNT

    xor edx, edx
    mov dl, byte [ecx + eax - 1]
    mov byte [ecx + eax], dl

    inc edi
    cmp edi, LETTERS_COUNT - 1
    jl rotate_loop_right

    sub eax, LETTERS_COUNT
    xor edx, edx
    mov dl, byte [word_aux_first]
    mov byte [ecx + eax - 1], dl

    add eax, LETTERS_COUNT
    xor edx, edx
    mov dl, byte [word_aux_second]
    mov byte [ecx + eax - 1], dl
    
    pop eax
    pop edx
    inc esi
    cmp eax, esi
    jg rotate_right

end:

    pop edx

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

; void enigma(char *plain, char key[3], char notches[3], char config[10][26], char *enc);
enigma:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; plain (address of first element in string)
    mov ebx, [ebp + 12] ; key
    mov ecx, [ebp + 16] ; notches
    mov edx, [ebp + 20] ; config (address of first element in matrix)
    mov edi, [ebp + 24] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement enigma
    ;; FREESTYLE STARTS HERE

    PRINTF32 `%c \x0`, [ecx + 2]


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY