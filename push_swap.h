/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/20 20:16:18 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/23 22:56:32 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PUSH_SWAP_H
# define PUSH_SWAP_H
# define INT_MAX 2147483647 
# define INT_MIN -2147483648 
# define LONG_MAX 9223372036854775807L 
# define LONG_MIN -9223372036854775808L

# include <stddef.h>
# include <stdlib.h>
# include <unistd.h>
# include <stdarg.h>

typedef struct s_node
{
	int				value;
	int				index;
	int				chunk;
	int				pos;
	int				cost_a;
	int				cost_b;
	struct s_node	*next;
}	t_stack;

int		ft_lstsize(t_stack *lst);
char	*ft_strdup(const char *s);
char	*ft_strjoin(char const *s1, char const *s2);
char	**ft_split(char *str, char c);
size_t	ft_strlen(const char *s);
int		ft_printf(const char *format, ...);
int		ft_putchar_printf(unsigned char c, int fd);
int		ft_putnbr_printf(int n, int fd);
int		ft_putstr_printf(char *str, int fd);
int		lower_hexa_printer(unsigned long long n);
int		higher_hexa_printer(unsigned long long n);
int		ft_long_array_size(long *longed_args);
char	**merge_args(int argc, char **argv);
long	*args_to_long(char **args);
t_stack	*args_to_stack(long *longed_args);
void	free_stack(t_stack *a);
int		is_sorted(long *longed_args);
void	bubble_sort(long *arr);
void	match_index(t_stack **a, long *longed_args);
int		chunk_generator(t_stack **stack);
int		is_in_chunks(t_stack **a, int current_chunk);
int		has_chunk(t_stack **a, int chunk_number);
void	update_positions(t_stack **stack);
void	ft_sort(t_stack **a, t_stack **b, long *longed_args);
t_stack	*find_max_index(t_stack *b);
void	get_max_to_head(t_stack	**b, t_stack	**a);
void	ra(t_stack **stack_a);
void	rb(t_stack **stack_b);
void	rr(t_stack **stack_a, t_stack **stack_b);
void	rra(t_stack **stack_a);
void	rrb(t_stack **stack_b);
void	rrr(t_stack **stack_a, t_stack **stack_b);
void	sa(t_stack **stack_a);
void	sb(t_stack **stack_b);
void	ss(t_stack **stack_a, t_stack **stack_b);
void	pa(t_stack **stack_a, t_stack **stack_b);
void	pb(t_stack **stack_a, t_stack **stack_b);

#endif
