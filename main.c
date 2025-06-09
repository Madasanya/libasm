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
void libc_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *)) {
    t_list *curr;
    t_list *temp;

    while (*begin_list && cmp((*begin_list)->data, data_ref) == 0) {
        temp = *begin_list;
        *begin_list = temp->next;
        free_fct(temp->data);
        free(temp);
    }

    curr = *begin_list;
    while (curr && curr->next) {
        if (cmp(curr->next->data, data_ref) == 0) {
            temp = curr->next;
            curr->next = temp->next;
            free_fct(temp->data);
            free(temp);
        } else {
            curr = curr->next;
        }
    }
}

int libc_list_size(t_list *l) {
    int count = 0;
    while (l) {
        count++;
        l = l->next;
    }
    return count;
}

int cmp_str(void *a, void *b) {
    return strcmp((char *)a, (char *)b);
}

void free_str(void *data) {
    free(data);
}

void print_list(t_list *head) {
    while (head) {
        printf("Node: %s\n", (char *)head->data);
        head = head->next;
    }
}

void populate_list(t_list **head, const char **data, int use_libc) {
    for (int i = 0; data[i]; i++) {
        USE(list_push_front, head, strdup(data[i]));
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
    const char *str = "Assembly FTW!\0";
    const char *str_empty = "";
    const char *str_null_termminator = "\0";

    // *** STRLEN ***
    printf("\n *** STRLEN *** \n");
    printf("[strlen]  %zu\n", USE(strlen, str));
    printf("[strlen with empty string]  %zu\n", USE(strlen, str_empty));
    printf("[strlen with only null terminator]  %zu\n", USE(strlen, str_null_termminator));

    // *** STRCMP ***
    printf("\n *** STRCMP *** \n");
    printf("[strcmp same]  %ld\n", USE(strcmp, "abc", "abc"));
    printf("[strcmp different]  %ld\n", USE(strcmp, "abc", "abde"));

    // *** STRCPY ***
    printf("\n *** STRCPY *** \n");
    char dst1[50];
    char src[15]= "Hello World!\n";
    printf("[strcpy]  %s\n", USE(strcpy, dst1, "copied!"));
    printf("[strcpy]  %s\n", USE(strcpy, dst1, src));
    printf("[strcpy no source corruption]  %s\n", src);
    char dst2[50] = "overlapping!";
    printf("[strcpy overlapping]  %s\n", USE(strcpy, dst2+2, dst2));
    printf("[strcpy with empty string]  %s\n", USE(strcpy, dst1, str_empty));


    // *** STRDUP ***
    printf("\n *** STRDUP *** \n");
    char *dup = USE(strdup, "duplicate!");
    printf("[strdup]  %s\n", dup);
    char *dup_empty = USE(strdup, "");
    printf("[strdup empty]  %s\n", dup_empty);
    if (dup)
        free(dup);
    if (dup_empty)
        free(dup_empty);

    // === I/O ===
    // *** WRITE ***
    printf("\n *** WRITE *** \n");
    fflush(stdout);
    printf("[write full] return value = %ld, errno = %d\n",USE(write, STDOUT_FILENO, "Writing test successfull\n", strlen("Writing test successfull\n")), errno);
    fflush(stdout);
    USE(write, -2, "\nWriting test successfull\n", 5);
    printf("\n[write invalid fd] with error text = %s, errno = %d\n", strerror(errno), errno);
    errno = 0; // Reset errno for next test
    fflush(stdout);
    printf("\n[write size < buffer] return value= %ld, errno: %d\n",USE(write, STDOUT_FILENO, "\nWriting test successfull\n", 5), errno);

    // *** READ ***
    printf("\n *** READ *** \n");
    char buffer[100];
    int fd = open("Makefile", O_RDONLY);
    if (fd < 0) {
        fprintf(f, "Failed to open file: %s\n", "Makefile");
        return -1;
    }
    memset(buffer, 0, sizeof(buffer)); //make sure buffer is empty
    errno = 0;
    fflush(stdout);
    fprintf(f, "[read 11 bytes] return value = %zd, errno = %d\n", USE(read, fd, buffer, 11), errno);
    lseek(fd, 0, SEEK_SET);
    fflush(stdout);
    fprintf(f, "[read 11 bytes] output = \"%.*s\"\n", (int)USE(read, fd, buffer, 11), buffer);
    // Test zero-byte read
    memset(buffer, 0, sizeof(buffer));
    errno = 0;
    fprintf(f, "[read zero-byte] return value = %zd, errno = %d\n", USE(read, fd, buffer, 0), errno);
    // Read past EOF
    lseek(fd, 10000, SEEK_SET); // skip far past EOF
    errno = 0;
    fprintf(f, "[read past eof] return value = %zd, errno = %d\n", USE(read, fd, buffer, 10), errno);
    fprintf(f, "[read past eof] output = \"%.*s\"\n", (int)USE(read, fd, buffer, 10), buffer);
    
    USE(read, -2, buffer, 10);
    fprintf(f, "[read invalid fd] with error text = %s with errno %d\n", strerror(errno), errno);
    errno = 0; // Reset errno for next test

    // === LIST ===
    // *** LIST_PUSH_FRONT ***
    printf("\n *** LIST_PUSH_FRONT *** \n");
    t_list *list = NULL;
    printf("[list_push_front 1]:\n");
    USE(list_push_front, &list, strdup("node 3"));
    USE(list_push_front, &list, strdup("node 2"));
    USE(list_push_front, &list, strdup("node 1"));
    print_list(list);

    const char *items[] = {"two", "one", "two", "three", "two", "four", "two", NULL};
    t_list *list2 = NULL;
    populate_list(&list2, items, use_libc);
    printf("\n[list_push_front 2]:\n");
    print_list(list2);
    
    // *** LIST_SIZE ***
    printf("\n *** LIST_SIZE *** \n");
    printf("[list_size 1] %d\n", USE(list_size, list));
    printf("[list_size 2] %d\n", USE(list_size, list2));

    // *** LIST_REMOVE_IF ***
    printf("\n *** LIST_REMOVE_IF *** \n");
    const char *to_remove = "two";

    USE(list_remove_if, &list2, (void *)to_remove, cmp_str, free_str);
    printf("[list_remove_if] after removing '%s':\n", to_remove);
    print_list(list2);

    // Cleanup
    t_list *tmp;
    while (list) {
        tmp = list;
        list = list->next;
        free(tmp->data);
        free(tmp);
    }

    while (list2) {
        tmp = list2;
        list2 = list2->next;
        free(tmp->data);
        free(tmp);
    }

    fclose(f);
    return 0;
}