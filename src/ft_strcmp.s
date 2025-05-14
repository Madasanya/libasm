; ----------------------------------------------------------------------------------------
; ft_strcmp
; 1. same length (just asking for first string sufficient)
; 2. s1 is longer; termination with first occurence of unequal char
; 3. s2 is longer; termination with first occurence of unequal char
; ----------------------------------------------------------------------------------------

          global    ft_strcmp
          section   .text
ft_strcmp:  
            xor rax, rax           ; init of return value with 0, also used as string index
            ;mov [rdx], rdi
loop:       ;mov dl, byte [rdi+rax]
            ;mov cl, byte [rsi+rax]
            ;cmp dl, 0
            cld
            mov cx, 50
            repe cmpsb
            jne exit
            ;cmp dl, cl
            ;jne exit
            ;inc rax
            ;jmp loop
real:       ret
exit:       ;sub dl, cl
            dec rdi
            dec rsi
            movsx rax, dl
            jmp real              ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits