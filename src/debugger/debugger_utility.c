/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   debugger_utility.c                                 :+:    :+:            */
/*                                                     +:+                    */
/*   By: sverschu <sverschu@student.codam.n>          +#+                     */
/*                                                   +#+                      */
/*   Created: 2021/04/13 20:58:06 by sverschu      #+#    #+#                 */
/*   Updated: 2021/04/13 20:58:07 by sverschu      ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include <assert.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

#include "debugger.h"

extern int	g_dbg_fd__;

static void	__debug_print_banner(void)
{
	dprintf(g_dbg_fd__, "%-*s%*s%*s%s\n\n",
		DBG_FILENAME_LEN, "Filename",
		DBG_LINE_LEN, "LINE",
		DBG_FUNCNAME_LEN + 3, "Function",
		" Output");
}

bool	debug_init_tofile(const char *filename)
{
	int				fd;

	fd = open(filename, O_WRONLY | O_TRUNC | O_APPEND | O_CREAT, 0644);
	if (fd > 0)
	{
		g_dbg_fd__ = fd;
		__debug_print_banner();
		return (true);
	}
	return (false);
}

bool	debug_init_tofd(int fd)
{
	if (fd > 0)
	{
		g_dbg_fd__ = fd;
		__debug_print_banner();
		return (true);
	}
	return (false);
}
