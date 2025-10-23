NAME		= push_swap

CC			= cc

CFLAGS		= -Wall -Wextra -Werror -I.

SRCS =  main.c \
		parser.c\
		algorithm/ft_sort.c \
		algorithm/ft_sort_utils.c \
		ops/swap_funcs.c \
		ops/r_swap_funcs.c \
		ops/reverse_r_swap_funcs.c \
		libft/ft_split.c \
		libft/libft_func.c \
		libft/ft_printf.c\
		libft/ft_printf_utils.c
OBJS		= $(SRCS:.c=.o)

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

test100: fclean all
	@ARG="$(shell shuf -i 1-100 -n 100)"; ./push_swap $$ARG | ./checker_linux $$ARG

test500: fclean all
	@ARG="$(shell shuf -i 1-500 -n 500)"; ./push_swap $$ARG | ./checker_linux $$ARG

lc100: fclean all
	@ARG="$(shell shuf -i 1-100 -n 100)"; ./push_swap $$ARG | wc -l

lc500: fclean all
	@ARG="$(shell shuf -i 1-500 -n 500)"; ./push_swap $$ARG | wc -l