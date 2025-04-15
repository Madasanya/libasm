; ----------------------------------------------------------------------------------------
; ft_write
; ----------------------------------------------------------------------------------------

          extern __errno_location
          global    ft_write
          section   .text
ft_write:   mov     rax, 1           ; rax is syscall input and 1 the value for write
            syscall		     ; syscall will be called with rax (here set to 1 for write) as parameter
            cmp rax, 0		     ; the return value of the syscall is stored in rax. On success the number of bytes written is returned, -1 otherwise
            jge exit		     
            neg rax		     ; errno is returned as negative value from -1 to -4095 and therefore needs to be negated
            mov rbx, rax	     ; rbx getts the errnos value, as the call of the errno location will be overwritten with this one
            call __errno_location wrt ..plt		; sets a pointer to errno location to rax
            mov [rax], rbx		; sets the value (negated return value of write syscall) to where rax points to (errno location)
            mov rax, -1			; return value of our function for failed write
exit:       ret                           ; returns rax
