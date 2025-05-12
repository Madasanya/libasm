; ----------------------------------------------------------------------------------------
; ft_strcmp
; 1. same length (just asking for first string sufficient)
; 2. s1 is longer; termination with first occurence of unequal char
; 3. s2 is longer; termination with first occurence of unequal char
; ----------------------------------------------------------------------------------------

          global    ft_strcmp
          section   .text
ft_strcmp:  push rbp    ; Save the stack
            mov  rbp, rsp
            mov rax, 0           ; init of return value with 0, also used as string index
loop:       mov dl, byte [rdi+rax]
            mov cl, byte [rsi+rax]
            cmp dl, 0
            ;cmpsb rdi+rax, rsi+rax
            je exit
            cmp dl, cl
            jne exit
            inc rax
            jmp loop
exit:       sub dl, cl
            movsx rax, dl
            mov rsp, rbp
            pop rbp
            ret                          ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits