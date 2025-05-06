; ----------------------------------------------------------------------------------------
; ft_list_remove_if
; ----------------------------------------------------------------------------------------

          extern free
          global    ft_list_remove_if
          section   .text
ft_list_remove_if:
                    push rbp    ; Save the stack
                    mov  rbp, rsp
                    push rbx
                    push r12
                    push r13
                    push r14
                    push r15
                    cmp rdi, 0x0
                    je exit
                    cmp rsi, 0x0
                    je exit
                    cmp rdx, 0x0
                    je exit
                    cmp rcx, 0x0
                    je exit
                    mov rbx, rsi        ; copy data_ref to callee-save register
                    mov r12, rdx        ; copy cmp() to callee-save register
                    mov r13, rcx        ; copy free_fct() to callee-save register
                    mov r14, rdi        ; copy begin_list to callee-save register
                    mov r15, [rdi]      ; copy first element to callee-save register
compare:            mov rdi, rbx        ; copy data_ref to 1st argument for cmp() call
                    cmp r15 , 0x0       ; check if element points to Null
                    je exit
                    mov rsi, [r15]      ; copy element->data to 2nd argument for cmp() call
                    call r12            ; call cmp()
                    cmp rax, 0
                    je rm_elem
                    jne next_elem
rm_elem:            mov rdi, [r15]      ; copy element->data to 1st argument for free_fct() call
                    call r13            ; call free_fct()
                    mov r8, [r15+8]     ; copy element->next to temporary register
                    mov [r14], r8       ; update previous element->next to next node in list
                    mov rdi, r15        ; copy element to delete to 1st argument for free() call
                    call free wrt ..plt ; call free()
                    mov r15, [r14]      ; update register with next element to check
                    jmp compare
next_elem:          mov r8, [r15+8]     ; copy element->next to temporary register for last node check
                    cmp r8 , 0x0        ; check if element->next points to Null
                    je exit
                    mov r14, r15        ; copy actual element to register
                    add r14, 8          ; move to the element->next section (for same structure as begin_list)
                    mov r15, [r15+8]    ; copy next element to compare to register
                    jmp compare
exit:               pop r15
                    pop r14
                    pop r13
                    pop r12
                    pop rbx
                    mov rsp, rbp
                    pop rbp
                    ret                          ; returns rax