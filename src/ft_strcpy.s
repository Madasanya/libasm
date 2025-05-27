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

global          ft_strcpy              ; Makes the symbol ft_strcpy globally available

section .text
ft_strcpy:  
                mov rax, rdi           ; Save destination pointer (rdi) in rax to return it later
.src_end:    
                mov dl, byte [rsi]     ; Load the current byte from source (rsi) into dl
                push rdx               ; Push the 64-bit rdx (upper bits unused) to preserve the byte (dl) on the stack
                cmp byte [rsi], 0      ; Check if the current byte is null terminator
                je .loop               ; If it is, jump to the copy loop
                inc rsi                ; Move to next byte in source
                inc rdi                ; Move to next byte in destination
                jmp .src_end           ; Repeat the process until null terminator is found

.loop:      
                pop rdx                ; Pop the previously pushed byte (dl) from the stack
                mov byte [rdi], dl     ; Write the byte to the destination
                cmp rax, rdi           ; Check if we've returned to the original destination pointer
                je .exit               ; If yes, all bytes copied, exit
                dec rsi                ; Move back in source to next byte to write
                dec rdi                ; Move back in destination
                jmp .loop              ; Repeat copying bytes in reverse order

.exit:       
                ret                    ; Return the original destination pointer (in rax)

section .note.GNU-stack noalloc noexec nowrite progbits ; Required by linker to indicate no executable stack