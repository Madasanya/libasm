; ----------------------------------------------------------------------------------------
; ft_strcpy
; no calle-saved registers used so they don't need to be safed neither
; no call, so caller safed registers doesnt need to be saved 
;
; SYNOPSIS         top
;        #include <string.h>

;        char *strcpy(char *restrict dst, const char *restrict src);

; DESCRIPTION
;        strcpy()
;               These functions copy the string pointed to by src, into a
;               string at the buffer pointed to by dst.  The programmer is
;               responsible for allocating a destination buffer large
;               enough, that is, strlen(src) + 1.  For the difference
;               between the two functions, see RETURN VALUE.

; RETURN VALUE

;        strcpy()
;               These functions return dst.
; ----------------------------------------------------------------------------------------

          global    ft_strcpy
          section   .text
ft_strcpy:  
            mov rax, rdi
.src_end:    
            mov dl, byte [rsi]
            push rdx ; stack usage, so that memory overlapping is not affecting the function
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
            ret                          ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits