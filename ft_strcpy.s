; ----------------------------------------------------------------------------------------
; ft_strcmp
; 1. same length (just asking for first string sufficient)
; 2. s1 is longer; termination with first occurence of unequal char
; 3. s2 is longer; termination with first occurence of unequal char
; ----------------------------------------------------------------------------------------

          global    ft_strcpy
          section   .text
ft_strcpy:  mov rax, 0           ; init of return value with 0, also used as string index
loop:       cmp rdi, 0
            je exit
            cmp rsi, 0
            je exit
            mov rsi, rdi
            inc rdi
            inc rsi
exit:       ret                          ; returns rax