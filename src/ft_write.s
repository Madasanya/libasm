; ----------------------------------------------------------------------------------------
; ft_write
; ----------------------------------------------------------------------------------------

          extern __errno_location
          global    ft_write
          section   .text
ft_write:   mov     rax, 1           ; init of return value with 0, also used as string index
            syscall
            cmp rax, 0
            jge exit
            neg rax
            mov rbx, rax
            call __errno_location wrt ..plt
            mov [rax], rbx
            mov rax, -1
exit:       ret                           ; returns rax