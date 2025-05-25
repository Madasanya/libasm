; ----------------------------------------------------------------------------------------
; int ft_list_size(t_list *begin_list)
;
; @brief Counts the number of elements in a singly linked list.
;
; This NASM-implemented function traverses the list starting from
; `begin_list` and returns the total count of nodes in the list.
;
; @param begin_list Pointer to the first element of the list.
;
; @return The number of elements in the list.
; ----------------------------------------------------------------------------------------

global          ft_list_size

section .text
ft_list_size:
                xor rax, rax        ; fastes way to initialize rax with 0; will be used as counter
.loop:
                test rdi, rdi       ; like AND, but without storing the result, but setting flags like ZF (Zero Flag)
                je .exit            ; if zero flag was set, a a null pointer was detected and we want to terminate
                inc rax             ; number of list size increments
                mov rdi, [rdi+8]    ; rdi is set to the value of next
                jmp .loop
.exit:       
                ret                 ; returns rax

section .note.GNU-stack noalloc noexec nowrite progbits