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

int64_t ft_strlen(char *);
int64_t ft_strcmp(char *, char *);
char * ft_strcpy(char *, char *);
int64_t ft_write(int64_t, char *, int64_t);
int64_t ft_read(int64_t, char *, int64_t);
char * ft_strdup(char *);

int64_t ft_list_size(t_list *);
void ft_list_push_front(t_list **, void *);
void ft_list_remove_if(t_list **begin_list, void* data_ref, int (*cmp)(), void (*free_fct)(void*));

int compare_int(void* data_ref, void *data_elem)
{
	return (*((int *)data_ref) - *((int *)data_elem));
}

int main()
{
	char s1[8] = "First";
	// char s11[4]= "hjiu";
	char s2[8] = "Second";
	char dest[3];
	dest[1] = 0;
	char src[] = "see_you_next_time";
	
	t_list elem1;
	elem1.data = (void*)src;
	elem1.next = NULL;
	
	t_list elem2;
	elem2.data = (void*)s2;
	elem2.next = NULL;

	t_list elem3;
	elem3.data = (void*)s1;
	elem3.next = NULL;

	//elem1.next = &elem2;
	//elem2.next = &elem3;
	//t_list* head = &elem1;
	t_list* head = NULL;
	char *m1 = ft_strdup(s1); //First
	char *m2 = ft_strdup(s2); //Second
	char *m3 = ft_strdup("Third");
	printf("The length is %ld\n", strlen(s1));
	printf("The length is %ld\n", ft_strlen(s1));
	printf("The comparison is %d\n", strcmp(s1, s2));
	printf("The comparison is %ld\n", ft_strcmp(s1, s2));
	printf("src is %s and dest is %s\n", src, dest);
	printf("\nReturn of ft_read is: %ld\n", ft_read(-1, s1, 5));
	printf("\nError is: %s with errno %d\n", strerror(errno), errno);
	errno = 0;
	printf("\nReturn of write is: %ld\n", ft_write(1, s1, 5));
	printf("\nError is: %s with errno: %d\n", strerror(errno), errno);
	char * duplicate = ft_strdup(s2);
	printf("Original:\t\t\t%s\nDuplicate:\t\t\t%s\n", s2, duplicate);
	printf("src is %s and dst is %s\n", src, dest);
	//hello_world();
	printf("List size is %ld\n", ft_list_size(head));
	printf("Head points to %p\n", head);
	ft_list_push_front(&head, (void*)m3);
	// //printf("Head points to %s\n", *head);
	ft_list_push_front(&head, (void*)m2);
	// //printf("Head points to %s\n", *head);
	ft_list_push_front(&head, (void*)m1);
	// //printf("Head points to %s\n", *head);
	printf("Elem1 data %s\n", (char *)head->data);
	printf("Elem2 data %s\n", (char *)head->next->data);
	printf("Elem3 data %s\n", (char *)head->next->next->data);
	printf("Last elem->next %p\n", head->next->next->next);
	printf("List size is %ld\n", ft_list_size(head));
	printf("Node size is\n\tdata:%ld\n\tnext:%ld\n\ttotal:%ld\n", sizeof(elem1.data), sizeof(elem1.next), sizeof(elem1));
	ft_list_remove_if(&head, (void*)m2, strcmp, free);
	printf("List size is %ld\n", ft_list_size(head));
	printf("Elem1 data %s\n", (char *)head->data);
	printf("Elem2 data %s\n", (char *)head->next->data);
	printf("Last elem->next %p\n", head->next->next);
	return 0;
}
