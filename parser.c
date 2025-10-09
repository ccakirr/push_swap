/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   parser.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/10/02 10:43:51 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/09 11:49:30 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

static long	ft_atol(char *str)
{
	int		sign;
	long	res;
	int		i;

	i = 0;
	sign = 1;
	res = 0;
	if (str[i] == '+' || str[i] == '-')
	{
		if (str[i] == '-')
			sign = -1;
		if (str[++i] < '0' || str[i] > '9')
			return (LONG_MAX);
	}
	if (str[i] == '\0')
		return (LONG_MAX);
	while (str[i] >= '0' && str[i] <= '9')
	{
		if ((sign == 1 && res > (INT_MAX - (str[i] - '0')) / 10) || (sign == -1 && -res < (INT_MIN + (str[i] - '0')) / 10))
			return (LONG_MAX);
		res = res * 10 + (str[i] - '0');
		i++;
	}
	if (str[i] != '\0')
		return (LONG_MAX);
	return (sign * res);
}

char	**merge_args(int argc, char **argv)
{
	char	*joined;
	char	*tmp;
	char	**res;
	int		i;

	i = 1;
	joined = ft_strdup("");
	while (i < argc)
	{
		tmp = ft_strjoin(joined, argv[i]);
		free(joined);
		joined = ft_strjoin(tmp, " ");
		free(tmp);
		i++;
	}
	res = ft_split(joined, ' ');
	free(joined);
	if (!res[0])
	{
		ft_printf("Error\n");
		free(res);
		exit(0);
	}
	return (res);
}

long	*args_to_long(char **args)
{
	int		i;
	int		count;
	long	*long_array;

	count = 0;
	while (args[count])
		count++;
	long_array = malloc(sizeof(long) * (count + 1));
	if (!long_array)
		exit(EXIT_FAILURE);
	i = 0;
	while (args[i])
	{
		long_array[i] = ft_atol(args[i]);
		if (long_array[i] == LONG_MAX)
		{
			write(2, "Error\n", 6);
			free(long_array);
			exit(EXIT_FAILURE);
		}
		i++;
	}
	long_array[i] = LONG_MAX;
	return (long_array);
}

void	free_stack(t_stack *a)
{
	t_stack	*tmp;

	while (a)
	{
		tmp = a->next;
		free(a);
		a = tmp;
	}
}

t_stack	*args_to_stack(long	*longed_args)
{
	int		i;
	t_stack	*head;
	t_stack	*last;
	t_stack	*new;

	i = 0;
	head = NULL;
	last = NULL;
	while (longed_args[i] != LONG_MAX)
	{
		new = malloc(sizeof(t_stack));
		if (!new)
			exit(0);
		new->value = (int)longed_args[i];
		new->next = NULL;
		if (!head)
			head = new;
		else
			last->next = new;
		last = new;
		i++;
	}
	return (head);
}
