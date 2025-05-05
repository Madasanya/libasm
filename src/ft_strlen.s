; ----------------------------------------------------------------------------------------
; ft_strlen
; ----------------------------------------------------------------------------------------

          global    ft_strlen
          section   .text
ft_strlen:  push rbp    ; Save the stack
            mov  rbp, rsp
            mov     rax, 0           ; init of return value with 0, also used as string index
loop:       cmp byte [rdi+rax], 0
            je exit
            inc rax
            jmp loop
exit:       mov rsp, rbp
            pop rbp
            ret                           ; returns rax