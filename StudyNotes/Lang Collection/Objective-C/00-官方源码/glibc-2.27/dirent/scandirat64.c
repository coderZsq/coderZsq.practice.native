/* Copyright (C) 2000-2018 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

#include <dirent.h>

/* scandirat.c defines scandirat64 as an alias if _DIRENT_MATCHES_DIRENT64.  */
#ifndef _DIRENT_MATCHES_DIRENT64

# define SCANDIRAT      scandirat64
# define SCANDIR_TAIL   __scandir64_tail
# define DIRENT_TYPE    struct dirent64

# include <scandirat.c>

#endif
