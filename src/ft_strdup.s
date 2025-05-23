; ----------------------------------------------------------------------------------------
; ft_strdup
; ----------------------------------------------------------------------------------------

global    ft_strdup
extern malloc

section   .text

ft_strdup:  
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
.copy_loop:       
            mov dl, byte [rdi]
            mov byte [rsi], dl
            inc rsi
            inc rdi
            test dl, dl
            jne .copy_loop
.exit:      
            ret                          ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits
