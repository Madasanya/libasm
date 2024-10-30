#include <string.h>
#include <stdio.h>
#include <inttypes.h>
#include <unistd.h>
#include <errno.h>

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
void ft_list_push_front(t_list **, t_list *);
//void hello_world();

int main()
{
	char s1[8] = "Mim\0";
	//char s11[4]= "hjiu";
	char s2[5] = "Test";
	char dest[3];
	dest[1] = 0;
	char src[] = "see_you_next_time";
	
	t_list elem1;
	elem1.data = (void*)s2;
	elem1.next = NULL;
	
	t_list elem2;
	elem2.data = (void*)src;
	elem2.next = NULL;

	t_list elem3;
	elem3.data = (void*)s1;
	elem3.next = NULL;

	//elem1.next = &elem2;
	//elem2.next = &elem3;
	//t_list* head = &elem1;
	t_list* head = NULL;
	//printf("The length is %d\n", strlen(s1));
	//printf("The length is %d\n", ft_strlen(s1));
	//printf("The comparison is %d\n", strcmp(s1, s2));
	//printf("The comparison is %d\n", ft_strcmp(s1, s2));
	//printf("src is %s and dst is %s\n", src, dest);
	//printf("\nReturn of write is: %d\n", write(4, s1, 5));
	//printf("\nError is: %s with errno: %d\n", strerror(errno), errno);
	//printf("\nReturn of ft_write is: %d\n", read(0, s1, 5));
	//printf("\nError is: %s with errno %d\n", strerror(errno), errno);
	char * duplicate = ft_strdup(s2);
	printf("Original:\t\t\t%s\nDuplicate:\t\t\t%s\n", s2, duplicate);
	//printf("src is %s and dst is %s\n", src, dest);
	//hello_world();
	printf("Head points to %s\n", head);
	ft_list_push_front(&head, &elem1);
	ft_list_push_front(&head, &elem2);
	//ft_list_push_front(&head, &elem3);
	printf("Elem1 data %s\n", head->data);
	printf("Elem2 data %s\n", head->next->data);
	//printf("Elem3 data %s\n", head->next->next->data);
	//printf("Elem3 end %s\n", head->next->next->next);
	printf("List size is %d\n", ft_list_size(head));
	//printf("Node size is\n\tdata:%d\n\tnext:%d\n\ttotal:%d\n", sizeof(elem1.data), sizeof(elem1.next), sizeof(elem1));
	return 0;
}
