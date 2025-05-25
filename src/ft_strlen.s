; ----------------------------------------------------------------------------------------
; size_t ft_strlen(const char *s);
;
; @brief Calculates the length of a null-terminated string.
; This function, implemented in NASM, replicates the behavior of strlen().
; It counts the number of bytes in the string pointed to by `s`,
; excluding the terminating null byte ('\0').
;
; @param s Pointer to the null-terminated string.
;
; @return The number of bytes in the string, excluding the null terminator.
; ----------------------------------------------------------------------------------------

global          ft_strlen

section .text
ft_strlen:  
                xor rax, rax           ; fastes way to initialize rax with 0; also used as string index
.count_loop: 
                cmp byte [rdi+rax], 0
                je .exit
                inc rax
                jmp .count_loop
.exit:       
                ret                     ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits