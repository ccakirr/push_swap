/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.h                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ccakir <ccakir@student.42istanbul.com.t    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/09/20 20:16:18 by ccakir            #+#    #+#             */
/*   Updated: 2025/09/21 00:21:11 by ccakir           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PUSH_SWAP_H
# define PUSH_SWAP_H
# include <stddef.h>
# include "libft.h"

typedef struct stack
{
	int				number;
	struct stack	*next;
}					t_stack;

typedef struct	infstack
{
	int		max;
	int		min;
	size_t	len;
}			t_stack_info;

#endif