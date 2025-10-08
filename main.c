/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/20 20:16:13 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/08 22:03:38 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

static void	free_split(char	**merged_args)
{
	int	i;

	i = 0;
	while(merged_args[i])
	{
		free(merged_args[i]);
		i++;
	}
	free(merged_args);
}

static void free_all(long *longed_args, t_stack	stack_a, t_stack	stack_b, char	**merged_args)
{
	free(longed_args);
	free_split(merged_args);
	free_stack(a);
	free_stack(b);
}

static int	is_duplicated(long	*arr)
{
	int	i;
	int	j;

	i = 0;
	while(arr[i] != LONG_MAX)
	{
		j = i + 1;
		while(arr[j] != LONG_MAX)
		{
			if(arr[i] == arr[j])
				return (1);
			j++;
		}
		i++;
	}
	return (0);
}

int	main(int ac, char **av)
{
	t_stack	*a;
	t_stack	*b;
	char	**merged_args;
	long	*longed_args;

	b = NULL;
	if(ac >= 2)
		merged_args = merge_args(ac, av);
	else
		return(0);
	longed_args = args_to_long(merged_args);
	if (is_duplicated(longed_args))
	{
		free_all(longed_args, a, b, merged_args);
		ft_printf("Error\n");
		return (0);
	}
	if(is_sorted(longed_args))
	{
		free_all(longed_args, a, b, merged_args);
		return (0);
	}
	a = args_to_stack(longed_args);
	ft_sort(&a, &b);
	free_all(longed_args, a, b, merged_args);
}
