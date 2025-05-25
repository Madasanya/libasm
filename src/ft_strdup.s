; ----------------------------------------------------------------------------------------
; ft_strdup
;DESCRIPTION
;	The strdup() function returns a pointer to a new string which is a
;	duplicate of the string s. Memory for the new string is obtained with
;	malloc(3), and can be freed with free(3).
;RETURN VALUE
;	On success, the strdup() function returns a pointer to the duplicated
;	string. It returns NULL if insufficient memory was available, with errno
;	set to indicate the cause of the error.
;*ft_strdup(const char *s)
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
