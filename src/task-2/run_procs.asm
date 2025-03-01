%include "../include/io.mac"

    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

struc avg
    .quo resw 1
    .remain resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0
    avgArray: times avg_size * 5 db 0

section .text
    global run_procs
    extern printf

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here

    xor edi, edi ; contor pentru parcurgerea datelor
   
    ; introducere adresa Array de structuri
    xor edx, edx
    mov edx, avgArray 
    mov [eax], edx
    push eax


avg_loop:
    push ebx

    xor eax, eax
    mov eax, dword proc_size
    mul edi

    xor ebx, ebx
    xor edx, edx

    mov bl, byte [ecx + eax + proc.prio]
    mov dx, word [ecx + eax + proc.time]

    ; numarare date cu aceeasi prioritate
    xor eax, eax
    mov ax, word [prio_result + (ebx - 1) * 4]
    inc eax 
    mov word [prio_result + (ebx - 1) * 4], ax

    ; suma timp
    xor eax, eax
    mov eax, [time_result + (ebx - 1) * 4]
    add eax, edx
    mov [time_result + (ebx - 1) * 4], eax

    xor ebx, ebx
    pop ebx
    inc edi
    cmp ebx, edi
    jg avg_loop

    xor edi, edi
    
array_loop:
    push ebx

    xor ebx, ebx
    xor edx, edx

    
    mov bx, word [prio_result + edi * 4]
    mov edx, [time_result + edi * 4]
    cmp ebx, 0
    jz zero

    ; impartire
    xor eax, eax
    mov ax, dx
    shr edx, 16
    div bx
    jmp next

zero:
    xor eax, eax
    xor edx, edx

next:
    xor ecx, ecx
    mov ecx, eax

    ; introducere date in array de struct
    xor eax, eax
    xor ebx, ebx
    pop ebx
    pop eax
    mov word [eax + avg_size * edi + avg.quo], cx
    mov word [eax + avg_size * edi + avg.remain], dx
    push eax
    push ebx

    xor ebx, ebx
    pop ebx

    inc edi
    cmp edi, 5
    jl array_loop

    pop eax

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY