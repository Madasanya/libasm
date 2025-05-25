; ----------------------------------------------------------------------------------------
; ssize_t ft_write(int fd, const void *buf, size_t count);
;
; @brief Writes data to a file descriptor.
;
; This NASM-implemented function behaves like the standard `write()`.
; It writes up to `count` bytes from the buffer `buf` to the file descriptor `fd`.
; On success, it returns the number of bytes written. On failure, it sets `errno`
; appropriately and returns -1.
;
; This function internally makes a syscall and manually sets `errno` using
; `__errno_location()` if an error occurs, ensuring C compatibility.
;
; @param fd File descriptor to write to.
;
; @param buf Pointer to the buffer containing the data to write.
;
; @param count Number of bytes to write.
;
; @return The number of bytes written on success, or -1 on error with `errno` set.
; ----------------------------------------------------------------------------------------

extern      __errno_location
global      ft_write

section .text
ft_write:   
            ; Arguments: rdi = fd, rsi = buf, rdx = count (as per syscall convention)
            mov     rax, 1                      ; rax is syscall input and 1 the value for write
            syscall		                        ; syscall will be called with rax (here set to 1 for write) as parameter
            test rax, rax		                ; the return value of the syscall is stored in rax. On success the number of bytes written is returned, -1 otherwise
            jge .exit
            ; setting of errno in case of error     
            neg rax		                        ; errno is returned as negative value from -1 to -4095 and therefore needs to be negated
            mov rdi, rax	                    ; rbx gets the errnos value, as the call of the errno location will be overwritten with this one
            call __errno_location wrt ..plt		; sets a pointer to errno location to rax and "wrt ..plt" is used to make this call through procedure linkage table (plt)
            mov [rax], rdi		                ; sets the value (negated return value of write syscall) to where rax points to (errno location); *errno = value
            mov rax, -1			                ; return value of our function for failed write
.exit:       
            ret                                 ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits
