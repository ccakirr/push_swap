/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_sort.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/10/08 21:58:05 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/09 13:19:03 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	is_sorted_stack(t_stack **stack)
{
	t_stack	*tmp;

	tmp = *stack;
	while (tmp && tmp->next)
	{
		if (tmp->value > tmp->next->value)
			return (0);
		tmp = tmp->next;
	}
	return (1);
}

void	sort_three(t_stack **a)
{
	int	first;
	int	second;
	int	third;

	first = (*a)->index;
	second = (*a)->next->index;
	third = (*a)->next->next->index;
	if (first > second && second < third && first < third)
		sa(a); // 2 1 3
	else if (first > second && second > third)
	{
		sa(a);
		rra(a);
	} // 3 2 1
	else if (first > second && second < third && first > third)
		ra(a); // 2 3 1
	else if (first < second && second > third && first < third)
	{
		sa(a);
		ra(a);
	} // 1 3 2
	else if (first < second && second > third && first > third)
		rra(a); // 2 3 1
}

t_stack	*find_max_index(t_stack	**b)
{
	t_stack	*tmp;
	t_stack	*max;

	tmp = *b;
	max = *b;
	while (tmp)
	{
		if ((max->index) < (tmp->index))
			max = tmp;
		tmp = tmp->next;
	}
	return (max);
}

void	get_max_to_head(t_stack	**b, t_stack	*max_node)
{
	int	size;

	size = ft_lstsize(*b);
	if (max_node->pos <= (size / 2))
		while ((*b)->index != max_node->index)
			rb(b);
	else
		while ((*b)->index != max_node->index)
			rrb(b);
}

void	ft_sort(t_stack	**a, t_stack **b, long	*longed_args)
{
	t_stack	*max_node;

	bubble_sort(longed_args);
	match_index(a, longed_args);
	if (ft_lstsize(*a) == 1)
		return ;
	else if (ft_lstsize(*a) == 2)
	{
		sa(a);
		exit(0);
	}
	pb_untill_left_max_three(a, b, longed_args);
	sort_three(a);
	while (*b)
	{
		pos_counter(b);
		max_node = find_max_index(b);
		get_max_to_head(b, max_node);
		pa(a, b);
	}
}
