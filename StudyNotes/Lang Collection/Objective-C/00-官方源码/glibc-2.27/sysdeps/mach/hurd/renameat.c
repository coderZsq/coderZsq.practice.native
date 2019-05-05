/* Rename a file using relative source and destination names.  Hurd version.
   Copyright (C) 1991-2018 Free Software Foundation, Inc.
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

#include <stdio.h>
#include <hurd.h>
#include <hurd/fd.h>

/* Rename the file OLD relative to OLDFD to NEW relative to NEWFD.  */
int
renameat (int oldfd, const char *old, int newfd, const char *new)
{
  error_t err;
  file_t olddir, newdir;
  const char *oldname, *newname;

  olddir = __directory_name_split_at (oldfd, old, (char **) &oldname);
  if (olddir == MACH_PORT_NULL)
    return -1;
  newdir = __directory_name_split_at (newfd, new, (char **) &newname);
  if (newdir == MACH_PORT_NULL)
    {
       __mach_port_deallocate (__mach_task_self (), olddir);
      return -1;
    }

  err = __dir_rename (olddir, oldname, newdir, newname, 0);
  __mach_port_deallocate (__mach_task_self (), olddir);
  __mach_port_deallocate (__mach_task_self (), newdir);
  if (err)
    return __hurd_fail (err);
  return 0;
}
