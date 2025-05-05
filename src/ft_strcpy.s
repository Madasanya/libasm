; ----------------------------------------------------------------------------------------
; ft_strcpy
; ----------------------------------------------------------------------------------------

          global    ft_strcpy
          section   .text
ft_strcpy:  push rbp    ; Save the stack
            mov  rbp, rsp
            mov rax, rdi
src_end:    mov dl, byte [rsi]
            push rdx ; stack usage, so that memory overlapping is not affecting the function
            cmp byte [rsi], 0
            je loop
            inc rsi
            inc rdi
            jmp src_end
loop:       pop rdx
            mov byte [rdi], dl
            cmp rax, rdi
            je exit
            dec rsi
            dec rdi
            jmp loop
exit:       mov rsp, rbp
            pop rbp
            ret                          ; returns rax