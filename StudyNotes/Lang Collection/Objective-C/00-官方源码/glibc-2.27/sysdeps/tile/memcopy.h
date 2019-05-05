/* memcopy.h -- definitions for memory copy functions.  Tile version.
   Copyright (C) 2012-2018 Free Software Foundation, Inc.
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

#include <sysdeps/generic/memcopy.h>
#include <bits/wordsize.h>

/* The tilegx implementation of memcpy is safe to use for memmove.  */
#undef MEMCPY_OK_FOR_FWD_MEMMOVE
#define MEMCPY_OK_FOR_FWD_MEMMOVE 1

/* Support more efficient copying on tilegx32, which supports
   long long as a native 64-bit type.  */
#if __WORDSIZE == 32
# undef op_t
# define op_t	unsigned long long int
#endif
