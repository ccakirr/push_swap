/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_sort_small.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/10/31 18:01:50 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/31 18:10:08 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

void	sort_three(t_stack **a)
{
	int	first = (*a)->index;
	int	second = (*a)->next->index;
	int	third = (*a)->next->next->index;

	if (first > second && second < third && first < third)
		sa(a);
	else if (first > second && second > third)
	{
		sa(a);
		rra(a);
	}
	else if (first > second && second < third && first > third)
		ra(a);
	else if (first < second && second > third && first < third)
	{
		sa(a);
		ra(a);
	}
	else if (first < second && second > third && first > third)
		rra(a);
}

int	find_min_pos(t_stack **a)
{
	t_stack	*tmp = *a;
	int		min = tmp->index;
	int		pos = 0;
	int		i = 0;

	while (tmp)
	{
		if (tmp->index < min)
		{
			min = tmp->index;
			pos = i;
		}
		tmp = tmp->next;
		i++;
	}
	return (pos);
}

void	ft_sort_small(t_stack **a, t_stack **b)
{
	int	size;
	int	pos;

	size = ft_lstsize(*a);
	while (size > 3)
	{
		pos = find_min_pos(a);
		if (pos <= size / 2)
			while (pos-- > 0)
				ra(a);
		else
			while (pos++ < size)
				rra(a);
		pb(a, b);
		size--;
	}
	sort_three(a);
	while (*b)
		pa(a, b);
}
