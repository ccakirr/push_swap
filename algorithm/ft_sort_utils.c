/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_sort_utils.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/10/04 14:17:44 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/23 23:08:52 by ccakir           ###   ########.fr       */
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
		while (longed_args[i] != LONG_MAX)
		{
			if (longed_args[i] == tmp->value)
			{
				tmp->index = i;
				break ;
			}
			i++;
		}
		tmp = tmp->next;
	}
}

int	chunk_generator(t_stack **stack)
{
	int		chunk_size;
	int		list_size;
	int		chunk_count;
	t_stack	*tmp;

	list_size = ft_lstsize(*stack);
	if (list_size <= 100)
		chunk_count = 5;
	else
		chunk_count = 11;
	chunk_size = list_size / chunk_count;
	tmp = *stack;
	while (tmp)
	{
		tmp->chunk = tmp->index / chunk_size;
		if (tmp->chunk >= chunk_count)
			tmp->chunk = chunk_count - 1;
		tmp = tmp->next;
	}
	return (chunk_count);
}

int	is_in_chunks(t_stack **a, int current_chunk)
{
	t_stack	*tmp;

	tmp = *a;
	if (!tmp)
		return (0);
	return (tmp->chunk == current_chunk);
}
