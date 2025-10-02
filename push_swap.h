/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/20 20:16:18 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/02 13:23:55 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PUSH_SWAP_H
# define PUSH_SWAP_H
# define INT_MAX 2147483647
# define INT_MIN -2147483648
# define LONG_MAX 9223372036854775807L
# define LONG_MIN -9223372036854775808L
# include <stddef.h>
# include "libft/libft_h"

typedef struct s_node
{
	int	value;
	int	index;// sıralı konum (rank)
	int	pos;// şu anki pozisyon
	int	target_pos;// gitmesi gereken pozisyon
	int	cost_a;// A stack'i için maliyet
	int	cost_b;// B stack'i için maliyet
	struct s_node  *next;
}	t_stack;

char 	**merge_args(int argc, char **argv)
long 	*args_to_long(char **args)
void 	free_stack(t_stack *a)
t_stack	*args_to_stack(char	**merged_args)
void	sa(t_list	**stack_a)
void	sb(t_list	**stack_b);
void	ss(t_list	**stack_a, t_list	**stack_b);
void	pa(t_list **stack_a, t_list **stack_b);
void	pb(t_list **stack_a, t_list **stack_b);

#endif