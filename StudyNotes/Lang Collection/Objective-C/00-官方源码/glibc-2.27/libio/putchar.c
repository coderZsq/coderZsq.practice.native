/* Copyright (C) 1991-2018 Free Software Foundation, Inc.
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

#include "libioP.h"
#include "stdio.h"

#undef putchar

int
putchar (int c)
{
  int result;
  _IO_acquire_lock (_IO_stdout);
  result = _IO_putc_unlocked (c, _IO_stdout);
  _IO_release_lock (_IO_stdout);
  return result;
}

#if defined weak_alias && !defined _IO_MTSAFE_IO
#undef putchar_unlocked
weak_alias (putchar, putchar_unlocked)
#endif
