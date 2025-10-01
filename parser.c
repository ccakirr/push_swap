/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   parser.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/10/01 17:09:18 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/01 18:50:50 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

t_list	*array_to_list(char **array)
{
	t_list	*head;
	t_list	*current;
	int		i;

	head = NULL;
	current = NULL;
	i = 0;
	while(array[i])
	{
		t_list	*new;
		new = malloc((sizeof(t_list)));
		new -> content = array[i];
		new -> next = NULL;
		if (!(head))
			head = new;
		else
			current -> next = new;
		current = new;
		i++;
	}
	return (head);
}