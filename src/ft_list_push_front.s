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
            test rdi, rdi                ; check if pointer to list is NULL; is *head NULL?
            je .error
            push rdi                    ; copy pointer to list to stack
            push rsi                    ; copy pointer to data to stack
            mov rdi, 16                 ; pass element size to malloc calls 1st argument
            call malloc wrt ..plt       ; call malloc to allocate memory for new element
            test rax, rax                  ; check if malloc was successful
            je .error
            pop r11                     ; take pointer to data from stack to caller-save register
            mov [rax+0], r11            ; copy data to element data pointer; new_node->data = data
            pop r9                      ; take pointer to list from stack to caller-save register
            mov r8, [r9]                ; copy list head pointer to caller-save register (memory to reg)
            mov [rax+8], r8             ; copy list head pointer to elements next pointer; new_node->next = *head
            mov [r9], rax               ; copy pointer of list head to new element; *head = new_node
            jmp .exit
.error:
            xor rax, rax
.exit:      
            mov rsp, rbp
            pop rbp
            ret                          ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits