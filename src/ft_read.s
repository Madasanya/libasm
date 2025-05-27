; ----------------------------------------------------------------------------------------
; ssize_t ft_read(int fd, void *buf, size_t count);
;
; @brief Reads data from a file descriptor into a buffer.
;
; This NASM-implemented function behaves like the standard `read()`.
; It attempts to read up to `count` bytes from the file descriptor `fd`
; into the buffer pointed to by `buf`. On success, the number of bytes read
; is returned. On failure, `-1` is returned and `errno` is set appropriately.
;
; Internally, this function makes a syscall and manually sets `errno` using
; `__errno_location()` to ensure compatibility with standard C error handling.
;
; @param fd File descriptor to read from.
;
; @param buf Pointer to the buffer where the read data will be stored.
;
; @param count Maximum number of bytes to read.
;
; @return The number of bytes read on success, 0 on EOF, or -1 on error with `errno` set.
; ----------------------------------------------------------------------------------------

global          ft_read
extern          __errno_location

section .text
ft_read:   
                xor     rax, rax                    ; rax is syscall input and 0 the value for read; fastes way to set rax = 0
                syscall
                test rax, rax
                jns .exit                           ; if rax >= 0, no error; jump if not sign
                ; setting of errno in case of error 
                neg rax
                mov rdi, rax
                call __errno_location wrt ..plt
                mov [rax], rdi
                mov rax, -1
.exit:       
                ret                                 ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits