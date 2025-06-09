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
                syscall                             ; syscall will be called with rax (here set to 0 for read) as parameter
                test rax, rax                       ; the return value of the syscall is stored in rax. On success the number of bytes written is returned, -1 otherwise
                jns .exit                           ; if rax >= 0, no error; jump if not sign
                ; setting of errno in case of error     
                neg rax		                        ; errno is returned as negative value from -1 to -4095 and therefore needs to be negated
                mov rdi, rax	                    ; rbx gets the errnos value, as the call of the errno location will be overwritten with this one
                call __errno_location wrt ..plt		; sets a pointer to errno location to rax and "wrt ..plt" is used to make this call through procedure linkage table (plt)
                mov [rax], rdi		                ; sets the value (negated return value of write syscall) to where rax points to (errno location); *errno = value
                mov rax, -1			                ; return value of our function for failed write
.exit:       
                ret                                 ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits