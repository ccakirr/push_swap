/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/20 20:16:18 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/09 11:08:50 by ccakir           ###   ########.fr       */
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
# include "libft/libft.h"

typedef struct s_node
{
	int				value;
	int				index;
	int				pos;
	int				target_pos;
	int				cost_a;
	int				cost_b;
	struct s_node	*next;
}	t_stack;

int		ft_long_array_size(long *longed_args);
char	**merge_args(int argc, char **argv);
long	*args_to_long(char **args);
t_stack	*args_to_stack(long *longed_args);
void	free_stack(t_stack *a);
int		is_sorted(long *longed_args);
void	bubble_sort(long *arr);
void	match_index(t_stack **a, long *longed_args);
void	pos_counter(t_stack **stack);
void	sort_three(t_stack **a);
void	ft_sort(t_stack **a, t_stack **b, long *longed_args);
void	pb_until_left_min_three(t_stack **a, t_stack **b, long *longed_args);
t_stack	*find_max_index(t_stack **b);
void	get_max_to_head(t_stack **b, t_stack *max_node);
int		is_sorted_stack(t_stack **stack);
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
