/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_printf_utils                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/06/05 15:37:59 by ccakir            #+#    #+#             */
/*   Updated: 2025/10/09 12:18:24 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	ft_putchar_printf(unsigned char c, int fd)
{
	write (fd, &c, 1);
	return (1);
}

int	ft_putnbr_printf(int n, int fd)
{
	long	nbr;
	char	c;
	int		count;

	nbr = n;
	count = 0;
	if (nbr < 0)
	{
		write(fd, "-", 1);
		count++;
		nbr *= -1;
	}
	if (nbr >= 10)
		count += ft_putnbr_printf(nbr / 10, fd);
	c = (nbr % 10) + '0';
	write(fd, &c, 1);
	return (count + 1);
}

int	ft_putstr_printf(char *str, int fd)
{
	int	i;

	i = 0;
	if (!str)
	{
		i += ft_putstr_printf("(null)", 1);
		return (i);
	}
	while (str[i])
	{
		write (fd, &str[i], 1);
		i++;
	}
	return (i);
}

int	lower_hexa_printer(unsigned long long n)
{
	char	*hex;
	int		i;
	char	buffer[32];
	int		j;

	hex = "0123456789abcdef";
	if (n == 0)
		return (ft_putchar_printf('0', 1));
	i = 0;
	while (n)
	{
		buffer[i++] = hex[n % 16];
		n /= 16;
	}
	j = i;
	while (j--)
		ft_putchar_printf(buffer[j], 1);
	return (i);
}

int	higher_hexa_printer(unsigned long long n)
{
	char	*hex;
	int		i;
	char	buffer[32];
	int		j;

	hex = "0123456789ABCDEF";
	if (n == 0)
		return (ft_putchar_printf('0', 1));
	i = 0;
	while (n)
	{
		buffer[i++] = hex[n % 16];
		n /= 16;
	}
	j = i;
	while (j--)
		ft_putchar_printf(buffer[j], 1);
	return (i);
}