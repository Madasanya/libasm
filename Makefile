AS			= nasm
ASFLAGS		= -felf64
AR			= ar
ARFLAGS		= src
RM			= rm -f
SRCD		= ./src/
SRC			= ft_strlen.s ft_strcmp.s ft_strcpy.s ft_write.s ft_read.s ft_strdup.s hello_world.s
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
			${RM} ${NAME}

re:			fclean all

.PHONY:		all clean fclean re
