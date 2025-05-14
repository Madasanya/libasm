; ----------------------------------------------------------------------------------------
; ft_strdup
; ----------------------------------------------------------------------------------------

global    ft_strdup
extern malloc

section   .text

ft_strdup:  
            ;push r12 ; not possible to switch to caller saved register without the need to preserve before malloc
            ;mov r12, rdi
            push rdi
            mov rcx, 1 ; strlen counter for malloc length (starting with 1 for null terminator)
            
.count_loop:    
            cmp byte [rdi], 0
            je .alloc_call
            inc rdi
            inc rcx
            jmp .count_loop
.alloc_call:
            mov rdi, rcx
            call malloc wrt ..plt
	        test rax, rax
	        je .exit

            mov rsi, rax
            pop rdi
            ;mov rdi, r12     
.copy_loop:       
            mov dl, byte [rdi]
            mov byte [rsi], dl
            inc rsi
            inc rdi
            test dl, dl
            jne .copy_loop
.exit:      
            ;pop r12
            ret                          ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits
