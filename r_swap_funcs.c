/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   r_swap_funcs.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/21 19:38:34 by ccakir            #+#    #+#             */
/*   Updated: 2025/09/29 14:09:24 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	ra(t_list	**stack_a)
{
	t_list	*tmp;
	t_list	*last;

	if (!*stack_a || !(*stack_a)->next)
		return ;
	tmp = *stack_a;
	*stack_a = (*stack_a)->next;
	last = *stack_a;
	while (last->next)
		last = last->next;
	last->next = tmp;
	tmp->next = NULL;
	ft_printf("ra\n");
}

void	rb(t_list	**stack_b)
{
	t_list	*tmp;
	t_list	*last;

	if (!*stack_a || !(*stack_a)->next)
		return ;
	tmp = *stack_a;
	*stack_a = (*stack_a)->next;
	last = *stack_a;
	while (last->next)
		last = last->next;
	last->next = tmp;
	tmp->next = NULL;
	ft_printf("ra\n");
}

void	rr(t_list	**stack_a, t_list	**stack_a)
{
	t_list	*tmp;
	t_list	*last;

	if ((!*stack_a || !(*stack_a)->next) || (!*stack_a || !(*stack_a)->next))
		return ;
	tmp = *stack_a;
	*stack_a = (*stack_a)->next;
	last = *stack_a;
	while (last->next)
		last = last->next;
	last->next = tmp;
	tmp->next = NULL;
	tmp = *stack_a;
	*stack_a = (*stack_a)->next;
	last = *stack_a;
	while (last->next)
		last = last->next;
	last->next = tmp;
	tmp->next = NULL;
	ft_printf("rr\n");
}
