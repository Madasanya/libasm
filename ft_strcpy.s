; ----------------------------------------------------------------------------------------
; ft_strcpy
; ----------------------------------------------------------------------------------------
%macro  strlen 2
    mov     %2, 0
    jmp %%strlen_loop
    %%strlen_inc: inc %2
    %%strlen_loop:
            cmp byte [%1+%2], 0
            jne %%strlen_inc
%endmacro

%macro smaller 2
    cmp %2, %1
    cmovl %1, %2
%endmacro

          global    ft_strcpy
          section   .text
ft_strcpy:  mov rax, rdi
            strlen rdi, r8
            strlen rsi, r9
            smaller r8, r9
loop:       cmp r8, 0
            je exit
            mov dl, byte [rsi+r8]
            mov byte [rdi+r8], dl
            dec r8
            dec rsi
            dec rdi
            jmp loop
exit:       ret                          ; returns rax