/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   swap_funcs.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/21 19:35:10 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/09 11:01:09 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	sa(t_stack	**stack_a)
{
	t_stack	*current;
	t_stack	*tmp;

	current = (*stack_a)->next;
	tmp = (*stack_a);
	(*stack_a)->content = current->content;
	current->content = tmp->content;
	ft_printf("sa\n");
}

void	sb(t_stack	**stack_b)
{
	t_stack	*current;
	t_stack	*tmp;

	current = *(stack_b)->next;
	tmp = *(stack_b);
	*(stack_b)->content = current->content;
	current->content = tmp->content;
	ft_printf("sb\n");
}

void	ss(t_stack	**stack_a, t_stack	**stack_b)
{
	t_stack	*current;
	t_stack	*tmp;

	current = (*stack_a)->next;
	tmp = (*stack_a);
	(*stack_a)->content = current->content;
	current->content = tmp->content;
	current = (*stack_b)->next;
	tmp = (*stack_b);
	(*stack_b)->content = current->content;
	current->content = tmp->content;
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
