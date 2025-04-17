; ----------------------------------------------------------------------------------------
; ft_strdup
; ----------------------------------------------------------------------------------------

	  extern __errno_location
          extern malloc
          global    ft_strdup
          section   .text
ft_strdup:  mov rbx, 0 ; strlen counter for malloc length
            mov r12, rdi
src_end:    cmp byte [rdi], 0
            je malloc_call
            inc rdi
            inc rbx
            jmp src_end
malloc_call:mov rdi, rbx
            call malloc wrt ..plt
	    cmp rax, 0
	    jl malloc_fail
            mov rsi, rax
            mov rdi, r12     
loop:       mov dl, byte [rdi]
            mov byte [rsi], dl
            cmp byte [rdi], 0
            je exit
            inc rsi
            inc rdi
            jmp loop
exit:       ret                          ; returns rax
malloc_fail:neg rax
	    mov rbx, rax
	    call __errno_location wrt ..plt
	    mov [rax], rbx
	    mov rax, -1
	    ret
