AS			= nasm
ASFLAGS		= -felf64
AR			= ar
ARFLAGS		= src
RM			= rm -f
SRCD		= ./src/
SRC			= ft_strlen.s ft_strcmp.s ft_strcpy.s ft_write.s ft_read.s ft_strdup.s ft_list_size.s ft_list_push_front.s ft_list_remove_if.s
SRCF		= $(addprefix $(SRCD),$(SRC))
OBJD		= ./obj/
#OBJ			= $(SRC:%.s=%.o)
OBJF 		= $(SRCF:$(SRCD)%.s=$(OBJD)%.o)
NAME		= libasm.a

$(OBJD)%.o: $(SRCD)%.s 
			@mkdir -p $(OBJD)
			${AS} ${ASFLAGS} $< -o $@

$(NAME):	${OBJF}
			${AR} ${ARFLAGS} ${NAME} ${OBJF}

all:		${NAME}

clean:		
			${RM} ${OBJD}*.o

fclean:		clean
			${RM} ${NAME} test *.txt

re:			fclean all

test:		all
			gcc main.c -L. ${NAME} -o test
			@echo "Running libc version..."
			@USE_LIBC=1 ./test
			@echo "Running libasm version..."
			@./test USE_LIBC=0
			@echo "Comparing results..."
			@diff out_libc.txt out_asm.txt > output.txt && \
				(echo "\033[1;32m✅ No differences found! Tests passed.\033[0m") || \
				(echo "\033[1;31m❌ Differences found. Check output.txt for details.\033[0m")

.PHONY:		all clean fclean re test
