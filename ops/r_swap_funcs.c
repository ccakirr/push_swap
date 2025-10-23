/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   r_swap_funcs.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/21 19:38:34 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/09 13:25:12 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	ra(t_stack	**stack_a)
{
	t_stack	*tmp;
	t_stack	*last;

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

void	rb(t_stack	**stack_b)
{
	t_stack	*tmp;
	t_stack	*last;

	if (!*stack_b || !(*stack_b)->next)
		return ;
	tmp = *stack_b;
	*stack_b = (*stack_b)->next;
	last = *stack_b;
	while (last->next)
		last = last->next;
	last->next = tmp;
	tmp->next = NULL;
	ft_printf("rb\n");
}

void	rr(t_stack	**stack_a, t_stack	**stack_b)
{
	t_stack	*tmp;
	t_stack	*last;

	if ((!*stack_a || !(*stack_a)->next) || (!*stack_b || !(*stack_b)->next))
		return ;
	tmp = *stack_a;
	*stack_a = (*stack_a)->next;
	last = *stack_a;
	while (last->next)
		last = last->next;
	last->next = tmp;
	tmp->next = NULL;
	tmp = *stack_b;
	*stack_b = (*stack_b)->next;
	last = *stack_b;
	while (last->next)
		last = last->next;
	last->next = tmp;
	tmp->next = NULL;
	ft_printf("rr\n");
}
