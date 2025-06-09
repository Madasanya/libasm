; ----------------------------------------------------------------------------------------
; ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
;
; @brief
; Removes from the list all elements whose data matches data_ref,
; based on a comparison function cmp. The data of each removed
; element is freed using the free_fct function.
;
; The comparison function cmp should return 0 when the two elements
; are considered equal (i.e., when an element should be removed).
;
; Elements are removed in-place and memory is freed using free_fct
; and free() for the node itself.
;
; @param t_list **begin_list   → A pointer to the pointer to the beginning of the list.
;
; @param void *data_ref        → The data reference to compare each element's data to.
;
; @param int (*cmp)()          → A function that compares list data to data_ref.
;                           Should return 0 when the data matches (i.e., should be removed).
; @param void (*free_fct)()    → A function used to free the data of removed elements.
;
; @return None. The list is modified in-place.
;
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
                    mov r15, [rdi]      ; copy first element to callee-save register
.compare:           mov rdi, rbx        ; copy data_ref to 1st argument for cmp() call
                    test r15, r15        ; check if element points to Null
                    je .exit
                    mov rsi, [r15]      ; copy element->data to 2nd argument for cmp() call
                    call r12            ; call cmp()
                    test rax, rax
                    je .rm_elem
                    jne .next_elem
.rm_elem:           mov rdi, [r15]      ; copy element->data to 1st argument for free_fct() call
                    call r13            ; call free_fct()
                    mov r8, [r15+8]     ; copy element->next to temporary register
                    mov [r14], r8       ; update previous element->next to next node in list
                    mov rdi, r15        ; copy element to delete to 1st argument for free() call
                    call free wrt ..plt ; call free()
                    mov r15, [r14]      ; update register with next element to check
                    jmp .compare
.next_elem:         mov r8, [r15+8]     ; copy element->next to temporary register for last node check
                    test r8, r8         ; check if element->next points to Null
                    je .exit
                    mov r14, r15        ; copy actual element to register
                    add r14, 8          ; move to the element->next section (for same structure as begin_list)
                    mov r15, [r15+8]    ; copy next element to compare to register
                    jmp .compare
.exit:              pop r15
                    pop r14
                    pop r13
                    pop r12
                    pop rbx
                    mov rsp, rbp
                    pop rbp
                    ret                          ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits