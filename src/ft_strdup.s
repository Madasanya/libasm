; ----------------------------------------------------------------------------------------
; char *ft_strdup(const char *s);
;
; @brief Duplicates a string using dynamic memory allocation.
;
; This NASM-implemented function behaves like the standard `strdup()`.
; It allocates memory using `malloc()` and copies the null-terminated
; string pointed to by `s` into the newly allocated space.
;
; The returned string must be freed using `free()` to avoid memory leaks.
;
; @param s Pointer to the null-terminated string to duplicate.
;
; @return A pointer to the newly allocated duplicate string, or `NULL` on
;         failure, with `errno` set to indicate the error.
;
; ----------------------------------------------------------------------------------------

global          ft_strdup
extern          malloc

section .text
ft_strdup:  
                push rdi
                mov rcx, 1              ; strlen counter for malloc length (starting with 1 for null terminator)
            
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
                ret                      ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits
