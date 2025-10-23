/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_sort.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/10/08 21:58:05 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/23 23:10:13 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	has_chunk(t_stack **a, int chunk_number)
{
	t_stack	*tmp;

	tmp = *a;
	while (tmp)
	{
		if (tmp->chunk == chunk_number)
			return (1);
		tmp = tmp->next;
	}
	return (0);
}

t_stack	*find_max_index(t_stack	*b)
{
	t_stack	*tmp;
	t_stack	*max;

	tmp = b;
	max = b;
	while (tmp)
	{
		if ((max->index) < (tmp->index))
			max = tmp;
		tmp = tmp->next;
	}
	return (max);
}

void	update_positions(t_stack **stack)
{
	t_stack	*tmp;
	int		i;

	tmp = *stack;
	i = 0;
	while (tmp)
	{
		tmp->pos = i;
		tmp = tmp->next;
		i++;
	}
}

void	get_max_to_head(t_stack	**b, t_stack	**a)
{
	int		size;
	t_stack	*max_node;

	update_positions(b);
	max_node = find_max_index(*b);
	size = ft_lstsize(*b);
	if (max_node->pos <= (size / 2))
		while ((*b)->index != max_node->index)
			rb(b);
	else
		while ((*b)->index != max_node->index)
			rrb(b);
	pa(a, b);
}

void	ft_sort(t_stack	**a, t_stack **b, long	*longed_args)
{
	int	chunk_count;
	int	current_chunk;

	bubble_sort(longed_args);
	match_index(a, longed_args);
	if (ft_lstsize(*a) == 1)
		return ;
	else if (ft_lstsize(*a) == 2)
	{
		sa(a);
		return ;
	}
	chunk_count = chunk_generator(a);
	current_chunk = 0;
	while (current_chunk < chunk_count && *a)
	{
		if (is_in_chunks(a, current_chunk))
			pb(a, b);
		else if (has_chunk(a, current_chunk))
			ra(a);
		else
			current_chunk++;
	}
	while (*b)
		get_max_to_head(b, a);
}
