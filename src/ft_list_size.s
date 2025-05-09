; ----------------------------------------------------------------------------------------
; Create the function ft_list_size, which returns the number of elements in the
;list.
;int ft_list_size(t_list *begin_list);
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