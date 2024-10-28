; ----------------------------------------------------------------------------------------
; ft_read
; ----------------------------------------------------------------------------------------

          extern __errno_location
          global    ft_read
          section   .text
ft_read:   mov     rax, 0           ; init of return value with 0, also used as string index
            syscall
            cmp rax, 0
            jge exit
            neg rax
            mov rbx, rax
            call __errno_location wrt ..plt
            mov [rax], rbx
            mov rax, -1
exit:       ret                           ; returns rax