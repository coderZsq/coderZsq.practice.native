/* Copyright (C) 2011-2018 Free Software Foundation, Inc.
   This file is part of the GNU C Library.
   Contributed by Chris Metcalf <cmetcalf@tilera.com>, 2011.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library.  If not, see
   <http://www.gnu.org/licenses/>.  */

#include <string.h>
#include <stdint.h>
#include "string-endian.h"

#undef strchr

char *
strchr (const char *s, int c)
{
  int z, g;

  /* Get an aligned pointer. */
  const uintptr_t s_int = (uintptr_t) s;
  const uint64_t *p = (const uint64_t *) (s_int & -8);

  /* Create eight copies of the byte for which we are looking. */
  const uint64_t goal = copy_byte(c);

  /* Read the first aligned word, but force bytes before the string to
     match neither zero nor goal (we make sure the high bit of each byte
     is 1, and the low 7 bits are all the opposite of the goal byte).  */
  const uint64_t before_mask = MASK (s_int);
  uint64_t v = (*p | before_mask) ^ (goal & v1shrui (before_mask, 1));

  uint64_t zero_matches, goal_matches;
  while (1)
    {
      /* Look for a terminating '\0'. */
      zero_matches = v1cmpeqi (v, 0);

      /* Look for the goal byte. */
      goal_matches = v1cmpeq (v, goal);

      if (__builtin_expect ((zero_matches | goal_matches) != 0, 0))
        break;

      v = *++p;
    }

  z = CFZ (zero_matches);
  g = CFZ (goal_matches);

  /* If we found c before '\0' we got a match. Note that if c == '\0'
     then g == z, and we correctly return the address of the '\0'
     rather than NULL.  */
  return (g <= z) ? ((char *) p) + (g >> 3) : NULL;
}
weak_alias (strchr, index)
libc_hidden_builtin_def (strchr)
