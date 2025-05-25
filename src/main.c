#include "libasm.h"

// Fallback to libc
#define USE(func, ...) (use_libc ? libc_##func(__VA_ARGS__) : ft_##func(__VA_ARGS__))

// Wrappers to allow toggling
size_t libc_strlen(const char *s) { return strlen(s); }
int libc_strcmp(const char *a, const char *b) { return strcmp(a, b); }
char *libc_strcpy(char *a, const char *b) { return strcpy(a, b); }
char *libc_strdup(const char *a) { return strdup(a); }
ssize_t libc_write(int fd, const void *b, size_t c) { return write(fd, b, c); }
ssize_t libc_read(int fd, void *b, size_t c) { return read(fd, b, c); }
void libc_list_push_front(t_list **l, void *d) {
    t_list *new = malloc(sizeof(t_list));
    new->data = d;
    new->next = *l;
    *l = new;
}
int libc_list_size(t_list *l) {
    int count = 0;
    while (l) {
        count++;
        l = l->next;
    }
    return count;
}

void print_list(t_list *head) {
    while (head) {
        printf("Node: %s\n", (char *)head->data);
        head = head->next;
    }
}

int main(void) {
    int use_libc = !!getenv("USE_LIBC");

    // Redirect all output to file
    FILE *f = fopen(use_libc ? "out_libc.txt" : "out_asm.txt", "w");
    if (!f) return 1;
    dup2(fileno(f), STDOUT_FILENO);
    dup2(fileno(f), STDERR_FILENO);

    // === STRING FUNCTIONS ===
    const char *str = "Assembly FTW!";
    printf("[strlen]  %zu\n", USE(strlen, str));
    printf("[strcmp]  %d\n", USE(strcmp, "abc", "abd"));

    char dst1[50];
    printf("[strcpy]  %s\n", USE(strcpy, dst1, "copied!"));

    char *dup = USE(strdup, "duplicate!");
    printf("[strdup]  %s\n", dup);
    free(dup);

    // === I/O ===
    USE(write, STDOUT_FILENO, "Writing test\n", 13);

    // === LIST ===
    t_list *list = NULL;
    USE(list_push_front, &list, strdup("node 3"));
    USE(list_push_front, &list, strdup("node 2"));
    USE(list_push_front, &list, strdup("node 1"));

    print_list(list);
    printf("[list size] %d\n", USE(list_size, list));

    // Cleanup
    t_list *tmp;
    while (list) {
        tmp = list;
        list = list->next;
        free(tmp->data);
        free(tmp);
    }

    fclose(f);
    return 0;
}