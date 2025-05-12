; ----------------------------------------------------------------------------------------
; ft_strlen
; no calle-saved registers used so they don't need to be safed neither
; no call, so caller safed registers doesnt need to be saved 
; ----------------------------------------------------------------------------------------

          global    ft_strlen
          section   .text
ft_strlen:  
            xor rax, rax           ; fastes way to initialize rax with 0; also used as string index
.count_loop: 
            cmp byte [rdi+rax], 0
            je .exit
            inc rax
            jmp .count_loop
.exit:       
            ret                           ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits