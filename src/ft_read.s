; ----------------------------------------------------------------------------------------
; ft_read
; ----------------------------------------------------------------------------------------

          extern __errno_location
          global    ft_read
          section   .text
ft_read:   push rbp    ; Save the stack
            mov  rbp, rsp
            mov     rax, 0           ; rax is syscall input and 1 the value for read
            syscall
            cmp rax, 0
            jge exit
            neg rax
            mov rbx, rax
            call __errno_location wrt ..plt
            mov [rax], rbx
            mov rax, -1
exit:       mov rsp, rbp
            pop rbp
            ret                          ; returns rax