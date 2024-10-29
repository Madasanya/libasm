; ----------------------------------------------------------------------------------------
; ft_list_size
; ----------------------------------------------------------------------------------------

          global    ft_list_size
          section   .text
ft_list_size: mov rax, 0
loop:       cmp byte [rdi+8], 0
            je exit
            inc rax
            mov rdi, [rdi+8]
            jmp loop
exit:       ret                           ; returns rax