/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   swap_funcs.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/21 19:35:10 by ccakir            #+#    #+#             */
/*   Updated: 2025/09/25 10:04:32 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include	"push_swap.h"

void	sa(t_list	*stack_a)
{
	t_list	*current;
	t_list	*tmp;

	current = malloc(sizeof(t_list));
	tmp = malloc(sizeof(t_list));
	current = stack_a->next;
	tmp = stack_a;
	stack_a->content = current->content;
	current->content = tmp->content;
	ft_printf("sa\n");
}

void sb(t_list	*stack_b)
{
	t_list	*current;
	t_list	*tmp;

	current = malloc(sizeof(t_list));
	tmp = malloc(sizeof(t_list));
	current = stack_b->next;
	tmp = stack_b;
	stack_b->content = current->content;
	current->content = tmp->content;
	ft_printf("sa\n");
}

void ss()
{
	t_list	*current;
	t_list	*tmp;

	current = malloc(sizeof(t_list));
	tmp = malloc(sizeof(t_list));
	current = stack_a->next;
	tmp = stack_a;
	stack_a->content = current->content;
	current->content = tmp->content;
	current = stack_b->next;
	tmp = stack_b;
	stack_b->content = current->content;
	current->content = tmp->content;
	ft_printf("ss\n");
}

void	pa(t_list	*stack_a, t_list	*stack_b)
{
	ft_lstadd_front(stack_b, stack_a);
	ft_printf("pa\n");
}

void	pb(t_list	*stack_a,	t_list	*stack_b)
{
	ft_lstadd_front(stack_a, stack_b);
	ft_printf("pb\n");
}