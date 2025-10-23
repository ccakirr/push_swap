/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   reverse_r_swap_funcs.c                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/21 19:41:07 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/23 21:02:49 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	rra(t_stack	**stack_a)
{
	t_stack	*tmp;
	t_stack	*last;

	if (!*stack_a || !(*stack_a)->next)
		return ;
	tmp = NULL;
	last = *stack_a;
	while (last->next)
	{
		tmp = last;
		last = last->next;
	}
	tmp->next = NULL;
	last->next = *stack_a;
	*stack_a = last;
	ft_printf("rra\n");
}

void	rrb(t_stack	**stack_b)
{
	t_stack	*tmp;
	t_stack	*last;

	if (!*stack_b || !(*stack_b)->next)
		return ;
	tmp = NULL;
	last = *stack_b;
	while (last->next)
	{
		tmp = last;
		last = last->next;
	}
	tmp->next = NULL;
	last->next = *stack_b;
	*stack_b = last;
	ft_printf("rrb\n");
}

void	rrr(t_stack	**stack_a, t_stack	**stack_b)
{
	t_stack	*tmp;
	t_stack	*last;

	if ((!*stack_a || !(*stack_a)->next) || (!*stack_b || !(*stack_b)->next))
		return ;
	last = *stack_a;
	while (last->next)
	{
		tmp = last;
		last = last->next;
	}
	tmp->next = NULL;
	last->next = *stack_a;
	*stack_a = last;
	tmp = NULL;
	last = *stack_b;
	while (last->next)
	{
		tmp = last;
		last = last->next;
	}
	tmp->next = NULL;
	last->next = *stack_b;
	*stack_b = last;
	ft_printf("rrr\n");
}
