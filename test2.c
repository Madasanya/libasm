#include "libasm.h"

// Helper for ft_list_push_front and ft_list_size
void print_list(t_list *head) {
    while (head) {
        printf("Node: %s\n", (char *)head->data);
        head = head->next;
    }
}

int main(void) {
    // === ft_strlen ===
    const char *str = "Hello, Assembly!";
    printf("[ft_strlen]        : %zu\n", ft_strlen(str));
    printf("[libc strlen]      : %zu\n", strlen(str));

    // === ft_strcmp ===
    printf("[ft_strcmp eq]     : %d\n", ft_strcmp("abc", "abc"));
    printf("[libc strcmp eq]   : %d\n", strcmp("abc", "abc"));

    printf("[ft_strcmp lt]     : %d\n", ft_strcmp("abc", "abd"));
    printf("[libc strcmp lt]   : %d\n", strcmp("abc", "abd"));

    printf("[ft_strcmp gt]     : %d\n", ft_strcmp("abd", "abc"));
    printf("[libc strcmp gt]   : %d\n", strcmp("abd", "abc"));

    // === ft_strcpy ===
    char dst1[50], dst2[50];
    ft_strcpy(dst1, "NASM Copy!");
    strcpy(dst2, "NASM Copy!");
    printf("[ft_strcpy]        : %s\n", dst1);
    printf("[libc strcpy]      : %s\n", dst2);

    // === ft_strdup ===
    char *dup1 = ft_strdup("DUPLICATE!");
    char *dup2 = strdup("DUPLICATE!");
    printf("[ft_strdup]        : %s\n", dup1);
    printf("[libc strdup]      : %s\n", dup2);
    free(dup1);
    free(dup2);

    // === ft_write ===
    ssize_t asm_w = ft_write(STDOUT_FILENO, "[ft_write stdout]\n", 18);
    ssize_t libc_w = write(STDOUT_FILENO, "[libc write stdout]\n", 21);
    printf("Return ft_write: %zd, errno: %d\n", asm_w, errno);
    printf("Return libc write: %zd, errno: %d\n", libc_w, errno);

    // === ft_read ===
    char buf1[32], buf2[32];
    int fd = STDIN_FILENO;
    printf("Type something (ft_read): ");
    ssize_t asm_r = ft_read(fd, buf1, sizeof(buf1)-1);
    buf1[asm_r > 0 ? asm_r : 0] = '\0';

    printf("You typed (ft_read): %s\n", buf1);

    // === Linked List: ft_list_push_front & ft_list_size ===
    t_list *list = NULL;
    ft_list_push_front(&list, strdup("node 3"));
    ft_list_push_front(&list, strdup("node 2"));
    ft_list_push_front(&list, strdup("node 1"));

    printf("List contents:\n");
    print_list(list);
    printf("List size [ft_list_size]: %d\n", ft_list_size(list));

    // Free list manually
    t_list *tmp;
    while (list) {
        tmp = list;
        list = list->next;
        free(tmp->data);
        free(tmp);
    }

    return 0;
}
