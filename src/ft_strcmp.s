; ----------------------------------------------------------------------------------------
; size_t ft_strcmp(const char *s1, const char *s2);
;
; @brief Compares two null-terminated strings.
;
; This function is implemented in NASM and behaves like the standard strcmp().
; It performs a byte-by-byte comparison of the strings `s1` and `s2` using
; unsigned characters. The comparison stops at the first differing byte or
; at the null terminator.
;
; @param s1 Pointer to the first null-terminated string.

; @param s2 Pointer to the second null-terminated string.

; @return An integer less than, equal to, or greater than zero if `s1` is found,
; respectively, to be less than, to match, or be greater than `s2`.
; ----------------------------------------------------------------------------------------

global          ft_strcmp

section .text
ft_strcmp:  
                xor rax, rax                ; init of return value with 0, also used as string index
.loop:       
                movzx edx, byte [rdi+rax]   ; movzx to set the upper bits between dl and edx also to zero and avoid partial register stalls
                movzx ecx, byte [rsi+rax]
                cmp edx, ecx                ; dl and cl would be sufficient but inconsistent, cause previous operation is performed on edx
                jne .exit                   ; if the character is not the same, jump to end
                test edx, edx               ;  checks if null
                je .exit                    ; end of one of the strings is reached
                inc rax 
                jmp .loop
.exit:       
                sub edx, ecx                ; calculates the difference between the last considered characters
                movsx rax, edx              ; movsx preserves the negative sign in case of negative return value (only using mov eax, edx would be more consistent but would only work for positive return values as the upper bits would be set to zero implicitly and not considering the signed bit, what would lead to a very high positive number)        
                ret                         ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits