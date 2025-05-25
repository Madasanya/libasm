#ifndef LIBASM_H
 #define LIBASM_H

#include <string.h>
#include <stdio.h>
#include <inttypes.h>
#include <unistd.h>
#include <errno.h>
#include <stdlib.h>

typedef struct 	s_list
{
	void* 			data;
	struct s_list* 	next;
}				t_list;

/**
 * @brief Calculates the length of a null-terminated string.
 *
 * This function, implemented in NASM, replicates the behavior of strlen().
 * It counts the number of bytes in the string pointed to by `s`,
 * excluding the terminating null byte ('\0').
 *
 * @param s Pointer to the null-terminated string.
 * @return The number of bytes in the string, excluding the null terminator.
 */
size_t ft_strlen(const char *s);

/**
 * @brief Compares two null-terminated strings.
 *
 * This function is implemented in NASM and behaves like the standard strcmp().
 * It performs a byte-by-byte comparison of the strings `s1` and `s2` using
 * unsigned characters. The comparison stops at the first differing byte or
 * at the null terminator.
 *
 * @param s1 Pointer to the first null-terminated string.
 * @param s2 Pointer to the second null-terminated string.
 * @return An integer less than, equal to, or greater than zero if `s1` is found,
 * respectively, to be less than, to match, or be greater than `s2`.
 */
size_t ft_strcmp(const char *s1, const char *s2);

/**
 * @brief Copies a null-terminated string to a destination buffer.
 *
 * This NASM-implemented function behaves like the standard `strcpy()`.
 * It copies the string pointed to by `src`, including the null terminator,
 * into the buffer pointed to by `dst`. The caller must ensure that the
 * destination buffer is large enough to hold the source string.
 *
 * @param dst Pointer to the destination buffer.
 * @param src Pointer to the null-terminated source string.
 * @return A pointer to the destination buffer `dst`.
 */
char *ft_strcpy(char *dst, const char *src);

/**
 * @brief Writes data to a file descriptor.
 *
 * This NASM-implemented function behaves like the standard `write()`.
 * It writes up to `count` bytes from the buffer `buf` to the file descriptor `fd`.
 * On success, it returns the number of bytes written. On failure, it sets `errno`
 * appropriately and returns -1.
 *
 * This function internally makes a syscall and manually sets `errno` using
 * `__errno_location()` if an error occurs, ensuring C compatibility.
 *
 * @param fd File descriptor to write to.
 * @param buf Pointer to the buffer containing the data to write.
 * @param count Number of bytes to write.
 * @return The number of bytes written on success, or -1 on error with `errno` set.
 */
ssize_t ft_write(int fd, const void *buf, size_t count);

/**
 * @brief Reads data from a file descriptor into a buffer.
 *
 * This NASM-implemented function behaves like the standard `read()`.
 * It attempts to read up to `count` bytes from the file descriptor `fd`
 * into the buffer pointed to by `buf`. On success, the number of bytes read
 * is returned. On failure, `-1` is returned and `errno` is set appropriately.
 *
 * Internally, this function makes a syscall and manually sets `errno` using
 * `__errno_location()` to ensure compatibility with standard C error handling.
 *
 * @param fd File descriptor to read from.
 * @param buf Pointer to the buffer where the read data will be stored.
 * @param count Maximum number of bytes to read.
 * @return The number of bytes read on success, 0 on EOF, or -1 on error with `errno` set.
 */
ssize_t ft_read(int fd, void *buf, size_t count);

/**
 * @brief Duplicates a string using dynamic memory allocation.
 *
 * This NASM-implemented function behaves like the standard `strdup()`.
 * It allocates memory using `malloc()` and copies the null-terminated
 * string pointed to by `s` into the newly allocated space.
 *
 * The returned string must be freed using `free()` to avoid memory leaks.
 *
 * @param s Pointer to the null-terminated string to duplicate.
 * @return A pointer to the newly allocated duplicate string, or `NULL` on
 *         failure, with `errno` set to indicate the error.
 */
char *ft_strdup(const char *s);

/**
 * @brief Adds a new element at the beginning of a singly linked list.
 *
 * This NASM-implemented function behaves like a typical push-front
 * operation for singly linked lists. It creates a new list node,
 * assigns the provided `data` to it, and inserts it at the beginning
 * of the list pointed to by `begin_list`.
 *
 * The function uses `malloc()` to allocate memory for the new node and
 * does nothing if allocation fails.
 *
 * @param begin_list A pointer to the pointer to the first element of the list.
 * @param data Pointer to the data to store in the new list node.
 * @return None.
 */
void ft_list_push_front(t_list **begin_list, void *data);

/**
 * @brief Adds a new element at the beginning of a singly linked list.
 *
 * This NASM-implemented function behaves like a typical push-front
 * operation for singly linked lists. It creates a new list node,
 * assigns the provided `data` to it, and inserts it at the beginning
 * of the list pointed to by `begin_list`.
 *
 * The function uses `malloc()` to allocate memory for the new node and
 * does nothing if allocation fails.
 *
 * @param begin_list A pointer to the pointer to the first element of the list.
 * @param data Pointer to the data to store in the new list node.
 * @return None.
 */
void ft_list_push_front(t_list **begin_list, void *data);


/**
 * @brief Counts the number of elements in a singly linked list.
 *
 * This NASM-implemented function traverses the list starting from
 * `begin_list` and returns the total count of nodes in the list.
 *
 * @param begin_list Pointer to the first element of the list.
 * @return The number of elements in the list.
 */
int ft_list_size(t_list *begin_list);

#endif //LIBASM_H
