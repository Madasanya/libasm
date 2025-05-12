; ----------------------------------------------------------------------------------------
; ft_read
; ----------------------------------------------------------------------------------------

          extern __errno_location
          global    ft_read
          section   .text
ft_read:   
            xor     rax, rax           ; rax is syscall input and 0 the value for read; fastes way to set rax = 0
            syscall
            test rax, rax
            jns .exit    ; if rax >= 0, no error; jump if not sign
            ; setting of errno in case of error 
            neg rax
            mov rdi, rax
            call __errno_location wrt ..plt
            mov [rax], rdi
            mov rax, -1
.exit:       
            ret                          ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits