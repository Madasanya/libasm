; ----------------------------------------------------------------------------------------
; char *ft_strcpy(char *dst, const char *src);
;
; @brief Copies a null-terminated string to a destination buffer.
;
; This NASM-implemented function behaves like the standard `strcpy()`.
; It copies the string pointed to by `src`, including the null terminator,
; into the buffer pointed to by `dst`. The caller must ensure that the
; destination buffer is large enough to hold the source string.
;
; @param dst Pointer to the destination buffer.
;
; @param src Pointer to the null-terminated source string.
;
; @return A pointer to the destination buffer `dst`.
; ----------------------------------------------------------------------------------------

global          ft_strcpy
section .text
ft_strcpy:  
                mov rax, rdi
.src_end:    
                mov dl, byte [rsi]
                push rdx                ; stack usage, so that memory overlapping is not affecting the function
                cmp byte [rsi], 0
                je .loop
                inc rsi
                inc rdi
                jmp .src_end

.loop:      
                pop rdx
                mov byte [rdi], dl
                cmp rax, rdi
                je .exit
                dec rsi
                dec rdi
                jmp .loop
.exit:       
                ret                      ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits