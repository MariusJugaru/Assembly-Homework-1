%include "../include/io.mac"

section .data

section .text
	global checkers
    extern printf

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    
    push eax

    ; se calculeaza pozitia in matrice/ sir vector
    xor edx, edx
    mov edx, 8
    mul edx
    add eax, ebx

    xor esi, esi
    mov esi, eax

    pop eax

    ; se verifica daca x este pe prima linie
    cmp eax, 0
    jz next_first

    ; se verifica daca y este pe prima coloana
    cmp ebx, 0
    jz check_right

    mov word [ecx + esi - 9], 1

check_right:
    ; se verifica daca y este pe ultima coloana
    cmp ebx, 7
    jz next_first

    mov word [ecx + esi - 7], 1

next_first:
    ; se verifica daca x este pe ultima linie
    cmp eax, 7
    jz end
    
    cmp ebx, 7
    jz check_left

    mov word [ecx + esi + 9], 1

check_left:
    ; se verifica daca y este pe prima coloana
    cmp ebx, 0
    jz end

    mov word [ecx + esi + 7], 1

end:

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY