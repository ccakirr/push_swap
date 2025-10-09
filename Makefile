# **************************************************************************** #
#                                   Makefile                                   #
# **************************************************************************** #

NAME		= push_swap

CC			= cc
CFLAGS		= -Wall -Wextra -Werror
SRCS		= main.c parser.c ft_sort.c alghorithm_utils.c \
			  r_swap_funcs.c reverse_r_swap_funcs.c swap_funcs.c ft_printf.c \
			  ft_printf_utils.c ft_split.c libft_func.c
OBJS		= $(SRCS:.c=.o)

# -----------------------------------------
#                RULES
# -----------------------------------------

all: $(NAME)

$(NAME): $(OBJS)
	@$(CC) $(CFLAGS) $(OBJS) -o $(NAME)
	@echo "✅ push_swap built successfully!"

%.o: %.c
	@$(CC) $(CFLAGS)  -c $< -o $@

clean:
	@rm -rf $(OBJS)

fclean: clean
	@rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
