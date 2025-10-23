/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   swap_funcs.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/21 19:35:10 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/23 21:00:56 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	sa(t_stack **stack_a)
{
	int	tmp;

	if (!*stack_a || !(*stack_a)->next)
		return;
	tmp = (*stack_a)->value;
	(*stack_a)->value = (*stack_a)->next->value;
	(*stack_a)->next->value = tmp;
	ft_printf("sa\n");
}


void	sb(t_stack **stack_b)
{
	int	tmp;

	if (!*stack_b || !(*stack_b)->next)
		return;
	tmp = (*stack_b)->value;
	(*stack_b)->value = (*stack_b)->next->value;
	(*stack_b)->next->value = tmp;
	ft_printf("sb\n");
}


void	ss(t_stack	**stack_a, t_stack	**stack_b)
{
	int	tmp;

	if ((!*stack_a || !(*stack_a)->next) && (!*stack_b || !(*stack_b)->next))
		return;
	if (*stack_a && (*stack_a)->next)
	{
		tmp = (*stack_a)->value;
		(*stack_a)->value = (*stack_a)->next->value;
		(*stack_a)->next->value = tmp;
	}
	if (*stack_b && (*stack_b)->next)
	{
		tmp = (*stack_b)->value;
		(*stack_b)->value = (*stack_b)->next->value;
		(*stack_b)->next->value = tmp;
	}
	ft_printf("ss\n");
}

void	pa(t_stack **stack_a, t_stack **stack_b)
{
	t_stack	*tmp;

	if (!*stack_b)
		return ;
	tmp = *stack_b;
	*stack_b = (*stack_b)->next;
	tmp->next = *stack_a;
	*stack_a = tmp;
	ft_printf("pa\n");
}

void	pb(t_stack **stack_a, t_stack **stack_b)
{
	t_stack	*tmp;

	if (!*stack_a)
		return ;
	tmp = *stack_a;
	*stack_a = (*stack_a)->next;
	tmp->next = *stack_b;
	*stack_b = tmp;
	ft_printf("pb\n");
}
