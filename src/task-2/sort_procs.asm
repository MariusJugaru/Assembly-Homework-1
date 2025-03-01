%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

section .text
    global sort_procs
    extern printf

sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY


    ;; Your code starts here

    
    sub eax, 1
    xor esi, esi

first_loop:
    xor edi, edi
    mov esi, 0

second_loop:
    push eax
    push edx

    xor eax, eax
    mov eax, dword proc_size
    mul edi

    pop edx

    xor ebx, ebx
    xor ecx, ecx

    mov bl, byte [edx + eax + proc.prio]
    mov cl, byte [edx + eax + 5 + proc.prio]


    cmp ebx, ecx ; verificare conditie prioritate
    jl next ; ebx.prio < ecx.prio
    jg swap
    je equal_prio

equal_prio:
    xor ebx, ebx
    xor ecx, ecx

    mov bx, word [edx + eax + proc.time]
    mov cx, word [edx + eax + 5 + proc.time]

    cmp ebx, ecx ; verificare conditie timp
    jl next ; ebx.timp < ecx.timp
    jg swap
    je equal_time


equal_time:
    xor ebx, ebx
    xor ecx, ecx

    mov bx, word [edx + eax + proc.pid]
    mov cx, word [edx + eax + 5 + proc.pid]

    cmp ebx, ecx
    jle next
    jg swap

swap:
    xor ebx, ebx
    xor ecx, ecx

    mov bx, word [edx + eax + proc.pid]
    mov cx, word [edx + eax + 5 + proc.pid]
    mov word [edx + eax + proc.pid], cx
    mov word [edx + eax + 5 + proc.pid], bx

    xor ebx, ebx
    xor ecx, ecx

    mov bl, byte [edx + eax + proc.prio]
    mov cl, byte [edx + eax + 5 + proc.prio]
    mov byte [edx + eax + proc.prio], cl
    mov byte [edx + eax + 5 + proc.prio], bl

    xor ebx, ebx
    xor ecx, ecx

    mov bx, word [edx + eax + proc.time]
    mov cx, word [edx + eax + 5 + proc.time]
    mov word [edx + eax + proc.time], cx
    mov word [edx + eax + 5 + proc.time], bx

    mov esi, 1

next:
    xor eax, eax
    pop eax

    inc edi
    cmp eax, edi

    jg second_loop

    cmp esi, 0
    jnz first_loop

    add eax, 1
    


    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY