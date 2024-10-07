; ----------------------------------------------------------------------------------------
; ft_strlen
; ----------------------------------------------------------------------------------------

          global    ft_strlen
          section   .text
ft_strlen:  mov     rax, -1           ; init of return value with -1, also used as string index
loop:       inc rax
            cmp byte [rdi+rax], 0
            jne loop
            ret                           ; returns rax