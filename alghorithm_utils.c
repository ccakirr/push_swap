/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   alghorithm_utils.c                                 :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/10/04 14:17:44 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/09 13:09:59 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	is_sorted(long	*longed_args)
{
	int	i;
	int	j;

	i = 0;
	while (longed_args[i] != LONG_MAX)
	{
		j = i + 1;
		while (longed_args[j] != LONG_MAX)
		{
			if (longed_args[i] > longed_args[j])
				return (0);
			j++;
		}
		i++;
	}
	return (1);
}

void	bubble_sort(long *arr)
{
	int		i;
	int		j;
	long	tmp;

	i = 0;
	while (arr[i + 1] != LONG_MAX)
	{
		j = 0;
		while (arr[j + 1] != LONG_MAX)
		{
			if (arr[j] > arr[j + 1])
			{
				tmp = arr[j];
				arr[j] = arr[j + 1];
				arr[j + 1] = tmp;
			}
			j++;
		}
		i++;
	}
}

void	match_index(t_stack	**a, long	*longed_args)
{
	int		i;
	t_stack	*tmp;

	tmp = *a;
	while (tmp)
	{
		i = 0;
		while (longed_args[i] != tmp->value)
			i++;
		tmp->index = i;
		tmp = tmp->next;
	}
}

void	pos_counter(t_stack	**stack)
{
	int		pos_counter;
	t_stack	*tmp;

	tmp = *stack;
	pos_counter = 0;
	while (tmp)
	{
		tmp->pos = pos_counter++;
		tmp = tmp->next;
	}
}

void	pb_untill_left_max_three(t_stack **a, t_stack **b, long *longed_args)
{
	int	size;
	int	i;
	int	arr_size;

	arr_size = ft_long_array_size(longed_args);
	size = ft_lstsize(*a);
	i = 0;
	while (i < size && ft_lstsize(*a) > 3)
	{
		if ((*a)->value != longed_args[arr_size - 1]
			&& (*a)->value != longed_args[arr_size - 2]
			&& (*a)->value != longed_args[arr_size - 3])
			pb(a, b);
		else
			ra(a);
		i++;
	}
}

