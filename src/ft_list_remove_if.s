; ----------------------------------------------------------------------------------------
; Create the function ft_list_remove_if which removes from the list all elements
; whose data, when compared to data_ref using cmp, causes cmp to return 0.
; The data from an element to be erased should be freed using free_fct.
; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
;
;The functions pointed to by cmp and free_fct will be used as follows:
;(*cmp)(list_ptr->data, data_ref);
;(*free_fct)(list_ptr->data);
; ----------------------------------------------------------------------------------------

          extern free
          global    ft_list_remove_if
          section   .text
ft_list_remove_if:
                    ; rdi = begin_list; rsi = data_ref; rdx = cmp(); rcx = free_fct()
                    xor rax, rax        ; clear rax register
                    push rbp    ; Save the stack
                    mov  rbp, rsp
                    push rbx
                    push r12
                    push r13
                    push r14
                    push r15                  
                    test rdi, rdi
                    je .exit
                    test rsi, rsi
                    je .exit
                    test rdx, rdx
                    je .exit
                    test rcx, rcx
                    je .exit
                    mov rbx, rsi        ; copy data_ref to callee-save register
                    mov r12, rdx        ; copy cmp() to callee-save register
                    mov r13, rcx        ; copy free_fct() to callee-save register
                    mov r14, rdi        ; copy begin_list to callee-save register
                    mov r15, [r14]
.compare:           
                    ;mov r15, [r14]      ; copy first element to r15
                    test r15, r15       ; check if begin_list points to Null
                    je .exit
                    mov rsi, rbx        ; copy data_ref to 2st argument for cmp() call
                    mov rdi, [r15]      ; copy element->data to 1nd argument for cmp() call
                    call r12            ; call cmp()
                    test rax, rax
                    je .rm_elem
                    mov r15, [r15+8]     ; update r14 to point to the next field of current node
                    mov [r14], r15
                    jmp .compare
.rm_elem:           
                    ;mov rdi, [r15]      ; copy element->data to 1nd argument for cmp() call
                    ;call r13            ; call cmp()
                    ;mov r8, [r15+8]     ; copy element->next to temporary register
                    ;mov [r14], r8       ; update previous element->next to next node in list
                    ;mov rdi, r8       ; copy element to delete to 1st argument for free() call
                    ;call free wrt ..plt ; call free() to free the element
                    ;jmp .compare
                    mov rax, 5          
.exit:              
                    ;xor rax, rax        ; clear rax register before returning
                    pop r15
                    pop r14
                    pop r13
                    pop r12
                    pop rbx
                    mov rsp, rbp
                    pop rbp
                    ret                          ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits