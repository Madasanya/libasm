; ----------------------------------------------------------------------------------------
; ft_strlen
; no calle-saved registers used so they don't need to be safed neither
; no call, so caller safed registers doesnt need to be saved

; *
;  * @brief Calculates the length of a null-terminated string.
;  *
;  * This function, implemented in NASM, replicates the behavior of strlen().
;  * It counts the number of bytes in the string pointed to by `s`,
;  * excluding the terminating null byte ('\0').
;  *
;  * @param s Pointer to the null-terminated string.
;  * @return The number of bytes in the string, excluding the null terminator.


;  *
;  * @note Like strlen(3) this function is optimized for performance and does not handle
;  *       null pointers. It assumes that the input string is valid and
;  *       properly null-terminated.
;  *
;  * @example
;  * size_t length = ft_strlen("Hello, World!");
;  * // length will be 13
;  *
;  * @see strlen(3) for the standard C library function.
;  */
; SYNOPSIS
;        #include <string.h>
;        size_t strlen(const char *s);

;DESCRIPTION
;	The strlen() function calculates the length of the string pointed to by s,
;	excluding the terminating null byte ('\0').
;RETURN VALUE
;	The strlen() function returns the number of bytes in the string pointed to by s.
;size_t ft_strlen(const char *s)
; ----------------------------------------------------------------------------------------

          global    ft_strlen
          section   .text
ft_strlen:  
            xor rax, rax           ; fastes way to initialize rax with 0; also used as string index
.count_loop: 
            cmp byte [rdi+rax], 0
            je .exit
            inc rax
            jmp .count_loop
.exit:       
            ret                           ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits