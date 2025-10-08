/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_sort.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/10/08 21:58:05 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/08 22:31:38 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

static int	is_sorted_stack(t_stack **stack)
{
	t_stack *tmp;
	t_stack *current;

	tmp = *stack;
	while(tmp)
	{
		current = tmp->next;
		if (current > tmp)
			return (0);
		tmp = tmp->next;
	}
	return (1);
}

void	sort_three(t_stack	**a, t_stack **b) //güncellenecek
{
	t_stack	*tmp;
	int		count;

	count = 3;
	tmp = *a;
	while(count)
	{
		while(!(tmp->index == (count-1)))
		{
			ra(a);
			tmp = *a;
		}
		pb(a, b);
		count--;
	}
}

void	ft_sort(t_stack	**a, t_stack **b, long	*longed_args)
{
	bubble_sort(longed_args);
	if (ft_lstsize(&a) == 1)
		return;
	else if(ft_lstsize(&a) == 2)
		sa(&a);
	pb_untill_left_min_three(&a, &b, longed_args);
	sort_three(a, b);
	
}
