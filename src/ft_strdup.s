; ----------------------------------------------------------------------------------------
; ft_strdup
; ----------------------------------------------------------------------------------------

global    ft_strdup
extern malloc

section   .text

ft_strdup:  push rbp    ; Save the stack
            mov  rbp, rsp
            push rbx
            push r12
            mov rbx, 1 ; strlen counter for malloc length (starting with 1 for null terminator)
            mov r12, rdi
src_len:    cmp byte [rdi], 0
            je alloc_call
            inc rdi
            inc rbx
            jmp src_len
alloc_call: mov rdi, rbx
            call malloc wrt ..plt
	        cmp rax, 0x0
	        je exit
            mov rsi, rax
            mov rdi, r12     
loop:       mov dl, byte [rdi]
            mov byte [rsi], dl
            cmp byte [rdi], 0
            je exit
            inc rsi
            inc rdi
            jmp loop
exit:       pop r12
            pop rbx
            mov rsp, rbp
            pop rbp
            ret                          ; returns rax
