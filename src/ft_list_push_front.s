; ----------------------------------------------------------------------------------------
; Create the function ft_list_push_front, which adds a new element of type t_list
;to the beginning of the list.
;• It should assign data to the given argument.
;• If necessary, it will update the pointer at the beginning of the list.
; void ft_list_push_front(t_list **begin_list, void *data);
;
;ft_create_elem
;• Create the function ft_create_elem, which creates a new element of t_list type.
;• It should assign data to the given argument and next to NULL.
;
;t_list *ft_create_elem(void *data);
; ----------------------------------------------------------------------------------------

          extern malloc
          global    ft_list_push_front
          section   .text
ft_list_push_front:
            push rbp    ; Save the stack
            mov  rbp, rsp
            push r12
            push r13
            push r14
            cmp rdi, 0x0                ; check if pointer to list is NULL
            je exit
            mov r12, rdi                ; copy pointer to list to callee-save register
            mov r13, rsi                ; copy pointer to data to callee-saved register
            mov rdi, 16                 ; pass element size to malloc calls 1st argument
            call malloc wrt ..plt       ; call malloc to allocate memory for new element
            cmp rax, 0x0                  ; check if malloc was successful
            je exit
            mov [rax+0], r13            ; copy data to element data pointer
            mov r14, [r12]              ; copy list head pointer to register (memory to reg)
            mov [rax+8], r14            ; copy list head pointer to elements next pointer
            mov [r12], rax              ; copy pointer of list head to new element
exit:       pop r14
            pop r13
            pop r12
            mov rsp, rbp
            pop rbp
            ret                          ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits
