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

global          ft_strdup               ; Makes the symbol ft_strdup globally available
extern          malloc                  ; Declares malloc as an external function

section .text
ft_strdup:  
                push rdi                ; Save the original pointer to the source string on the stack
                mov rcx, 1              ; Initialize counter (rcx) to 1 for null terminator (needed for malloc)
            
.count_loop:    
                cmp byte [rdi], 0       ; Check if current byte is null terminator
                je .alloc_call          ; If yes, stop counting
                inc rdi                 ; Move to next byte
                inc rcx                 ; Increment counter (length)
                jmp .count_loop         ; Repeat until end of string

.alloc_call:
                mov rdi, rcx            ; Pass the total length (including null terminator) to malloc
                call malloc wrt ..plt   ; Call malloc to allocate memory
                test rax, rax           ; Check if malloc returned NULL (allocation failed)
                je .exit                ; If NULL, return (rax will be 0)
                mov rsi, rax            ; Save the malloc return pointer (destination) in rsi
                pop rdi                 ; Restore original source string pointer

.copy_loop:       
                mov dl, byte [rdi]      ; Load byte from source string
                mov byte [rsi], dl      ; Store it in allocated destination
                inc rsi                 ; Move destination pointer forward
                inc rdi                 ; Move source pointer forward
                test dl, dl             ; Check if byte was null terminator
                jne .copy_loop          ; If not, continue copying

.exit:      
                ret                     ; Return pointer to duplicated string (rax)

section .note.GNU-stack noalloc noexec nowrite progbits ; Required by linker to indicate no executable stack

