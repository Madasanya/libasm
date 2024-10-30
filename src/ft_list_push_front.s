; ----------------------------------------------------------------------------------------
; ft_list_push_front
; ----------------------------------------------------------------------------------------

          global    ft_list_push_front
          section   .text
ft_list_push_front:
            xor rax, rax                ; initialize return value with 0 (fastest way)
            cmp rdi, 0x0                ; check if pointer to list is NULL
            je exit
            cmp rsi, 0x0                ; check if pointer to element to be added is NULL
            je exit
            mov rdx, [rdi]              ; copy the pointer of list head to register
            mov [rsi+8], rdx            ; copy new elements next pointer to pointer of list (NULL for first element)
            mov rcx, rsi                ; copy pointer of new element to register
            mov [rdi], rcx              ; copy pointer of list head to new element
exit:       ret                         ; returns rax