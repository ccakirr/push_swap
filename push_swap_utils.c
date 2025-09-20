/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap_utils.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/20 23:06:10 by ccakir            #+#    #+#             */
/*   Updated: 2025/09/21 00:24:01 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	is_sorted(t_stack b)
{
	t_stack	*tmp;
	
	tmp = *b;
	while((tmp -> next > tmp -> number) || (tmp -> next))
	{
		tmp = tmp -> next;
	}
	if(!(tmp->next))
		return (1);
	return (0);
}