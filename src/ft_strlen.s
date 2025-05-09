; ----------------------------------------------------------------------------------------
; ft_strlen
; no calle-saved registers used so they don't need to be safed neither
; no call, so caller safed registers doesnt need to be saved 
; ----------------------------------------------------------------------------------------

          global    ft_strlen
          section   .text
ft_strlen:  
            mov     rax, 0           ; init of return value with 0, also used as string index
loop:       cmp byte [rdi+rax], 0
            je exit
            inc rax
            jmp loop
exit:       
            ret                           ; returns rax