/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   error.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/21 23:04:32 by ccakir            #+#    #+#             */
/*   Updated: 2025/09/25 08:34:17 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft/libft.h"
#include "push_swap.h"

static int	is_space(char c)
{
	return ((c == ' ') || (c >= 9 && c <= 13));
}

static int	is_number_str(char *s)
{
	int	i = 0;

	if (s[i] == '+' || s[i] == '-')
		i++;
	if (s[i] == '\0')
		return (0);
	while (s[i])
	{
		if (s[i] < '0' || s[i] > '9')
			return (0);
		i++;
	}
	return (1);
}

static long	ft_atol(const char *num)
{
	long	res = 0;
	int		sign = 1;
	int		i = 0;
	long	digit;

	while (is_space(num[i]))
		i++;
	if (num[i] == '-' || num[i] == '+')
	{
		if (num[i] == '-')
			sign = -1;
		i++;
	}
	while (num[i] >= '0' && num[i] <= '9')
	{
		digit = num[i] - '0';
		if ((sign == 1 && res > (LONG_MAX - digit) / 10)
		 || (sign == -1 && res > (-(LONG_MIN + digit)) / 10))
			return (LONG_MAX);
		res = res * 10 + digit;
		i++;
	}
	return (res * sign);
}

static int	str_is_int(char *s)
{
	long	res;

	if (!is_number_str(s))
		return (0);
	res = ft_atol(s);
	if (res < INT_MIN || res > INT_MAX)
		return (0);
	return (1);
}

void	error(t_list *a)
{
	t_list	*temp;
	t_list	*check;

	temp = a;
	while (temp)
	{
		if (!str_is_int((char *)temp -> content))
		{
			write(2, "Error\n", 6);
			free(a);
			exit(EXIT_FAILURE);
		}
		check = temp -> next;
		while (check)
		{
			if(ft_atol((char *)check -> content) == ft_atol((char *)temp -> content))
			{
				write(2, "Error\n", 6);
				free(a);
				exit(EXIT_FAILURE);
			}
			check = check -> next;
		}
		temp = temp -> next;
	}
}
