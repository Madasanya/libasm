; ----------------------------------------------------------------------------------------
; ft_list_size
; ----------------------------------------------------------------------------------------

          global    ft_list_size
          section   .text
ft_list_size: push rbp    ; Save the stack
            mov  rbp, rsp
            mov rax, 0
            cmp rdi, 0x0
            je exit
loop:       inc rax
            cmp byte [rdi+8], 0
            je exit
            mov rdi, [rdi+8]
            jmp loop
exit:       mov rsp, rbp
            pop rbp
            ret                          ; returns rax