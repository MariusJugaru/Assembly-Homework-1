%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here


copy:
    ; se introduc elementele din string intr-un registru, incepand de la final
    mov al, [esi + ecx - 1] 
    add al, dl
    
    ; se compara al - Z (132) si daca rezultatul este pozitiv, al a depasit Z
    cmp al, 'Z'
    jle next

    ; se readuce caracterul in intervalul [A; Z]
    sub al, 26

next:
    mov [edi + ecx - 1], al
    loop copy

    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
