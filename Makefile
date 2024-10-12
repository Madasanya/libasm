AS			= nasm
ASFLAGS		= -felf64
AR			= ar
ARFLAGS		= src
RM			= rm -f
SRC			= ft_strlen.s ft_strcmp.s ft_strcpy.s hello_world.s
OBJ			= $(SRC:%.s=%.o)
NAME		= libasm.a

.s.o:
			${AS} ${ASFLAGS} $< -o ${<:.s=.o}

$(NAME):	${OBJ}
			${AR} ${ARFLAGS} ${NAME} ${OBJ}

all:		${NAME}

clean:		
			${RM} ${OBJ}

fclean:		clean
			${RM} ${NAME}

re:			fclean all

.PHONY:		all clean fclean re
