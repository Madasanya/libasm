; ----------------------------------------------------------------------------------------
; ft_list_push_front
; ----------------------------------------------------------------------------------------

          extern malloc
          global    ft_list_push_front
          section   .text
ft_list_push_front:
            cmp rdi, 0x0                ; check if pointer to list is NULL
            je exit
            mov r12, rdi                ; copy pointer to list to callee-save regeister
            mov r13, rsi                ; copy pointer to data to callee-saved register
            mov rdi, 16                 ; pass element size to malloc calls 1st argument
            call malloc wrt ..plt       ; call malloc to allocate memory for new element
            cmp rax, 0                  ; check if malloc was successful
            je exit
            mov [rax+0], r13            ; copy data to element data pointer
            mov r14, [r12]              ; copy list head pointer to register (memory to reg)
            mov [rax+8], r14            ; copy list head pointer to elements next pointer
            mov [r12], rax              ; copy pointer of list head to new element
exit:       ret                         ; returns rax