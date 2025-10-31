/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_sort_chunks.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/10/31 18:08:17 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/31 18:14:14 by ccakir           ###   ########.fr       */
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

void	ft_sort_chunks(t_stack **a, t_stack **b, int chunk_count)
{
	int	current_chunk;

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
}
