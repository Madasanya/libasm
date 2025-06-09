; ----------------------------------------------------------------------------------------
; void ft_list_push_front(t_list **begin_list, void *data);
;
; @brief Adds a new element at the beginning of a singly linked list.
;
; This NASM-implemented function behaves like a typical push-front
; operation for singly linked lists. It creates a new list node,
; assigns the provided `data` to it, and inserts it at the beginning
; of the list pointed to by `begin_list`.
;
; The function uses `malloc()` to allocate memory for the new node and
; does nothing if allocation fails.
;
; @param begin_list A pointer to the pointer to the first element of the list.
;
; @param data Pointer to the data to store in the new list node.
;
; @return None.
; ----------------------------------------------------------------------------------------

extern              malloc
global              ft_list_push_front

section   .text
ft_list_push_front:
                    push rbp                    ; Save the stack
                    mov  rbp, rsp
                    test rdi, rdi               ; check if pointer to list is NULL; (*head == NULL)?
                    je .error
                    push rdi                    ; copy pointer to list to stack
                    push rsi                    ; copy pointer to data to stack
                    mov rdi, 16                 ; pass element size to malloc calls 1st argument
                    call malloc wrt ..plt       ; call malloc to allocate memory for new element
                    test rax, rax               ; check if malloc was successful
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
                    ret                         ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits