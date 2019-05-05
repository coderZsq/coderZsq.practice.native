/* Copyright (C) 2007-2018 Free Software Foundation, Inc.
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

#include <errno.h>
#include <sched.h>
#include <sysdep.h>

#ifdef HAVE_GETCPU_VSYSCALL
# define HAVE_VSYSCALL
#endif
#include <sysdep-vdso.h>

int
sched_getcpu (void)
{
#ifdef __NR_getcpu
  unsigned int cpu;
  int r = INLINE_VSYSCALL (getcpu, 3, &cpu, NULL, NULL);

  return r == -1 ? r : cpu;
#else
  __set_errno (ENOSYS);
  return -1;
#endif
}
