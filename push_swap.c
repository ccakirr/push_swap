/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/20 20:16:13 by ccakir            #+#    #+#             */
/*   Updated: 2025/09/22 19:44:30 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	main(int ac, char **av[])
{
	t_list	stack_a;
	t_list	stack_b;

	(void *)ac;
	stack_a = array_to_list(av);
	error(stack_a);
}
