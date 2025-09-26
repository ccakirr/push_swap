/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   r_swap_funcs.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/21 19:38:34 by ccakir            #+#    #+#             */
/*   Updated: 2025/09/26 16:30:28 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	ra(t_list	*stack_a)
{
	t_list	*tmp;
	t_list	*last;
	t_list	*current;

	tmp = stack_a;
	current = stack_a;
	while(tmp->next)
	{
		tmp = tmp->next;
	}
	last = tmp;
	tmp->next = stack_a;
	while(current->next != last)
	{
		current = current->next;
	}
	current->next = NULL;
	ft_printf("ra\n");
}

void	rb(t_list	*stack_b)
{
	t_list	*tmp;
	t_list	*last;
	t_list	*current;

	tmp = stack_b;
	current = stack_b;
	while(tmp->next)
	{
		tmp = tmp->next;
	}
	last = tmp;
	tmp->next = stack_b;
	while(current->next != last)
	{
		current = current->next;
	}
	current->next = NULL;
	ft_printf("rb\n");
}

void	rr(t_list	*stack_a, t_list	*stack_a)
{
	rb(stack_b);
	ra(stack_a);
	ft_printf("rr\n");
}