/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/20 20:16:18 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/02 10:11:49 by ccakir           ###   ########.fr       */
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


void	error(t_list	*a);
t_list	*array_to_list(char **array);
void	sa(t_list	**stack_a)
void	sb(t_list	**stack_b);
void	ss(t_list	**stack_a, t_list	**stack_b);
void	pa(t_list **stack_a, t_list **stack_b);
void	pb(t_list **stack_a, t_list **stack_b);
t_list	*array_to_list_for_multistr(char **array)

#endif