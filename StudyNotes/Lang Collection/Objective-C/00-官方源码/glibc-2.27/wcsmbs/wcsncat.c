/* Copyright (C) 1995-2018 Free Software Foundation, Inc.
   This file is part of the GNU C Library.
   Contributed by Ulrich Drepper <drepper@gnu.ai.mit.edu>, 1995.

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

#include <wchar.h>

#ifndef WCSNCAT
# define WCSNCAT wcsncat
#endif

/* Append no more than N wide-character of SRC onto DEST.  */
wchar_t *
WCSNCAT (wchar_t *dest, const wchar_t *src, size_t n)
{
  wchar_t c;
  wchar_t * const s = dest;

  /* Find the end of DEST.  */
  do
    c = *dest++;
  while (c != L'\0');

  /* Make DEST point before next character, so we can increment
     it while memory is read (wins on pipelined cpus).	*/
  dest -= 2;

  if (n >= 4)
    {
      size_t n4 = n >> 2;
      do
	{
	  c = *src++;
	  *++dest = c;
	  if (c == L'\0')
	    return s;
	  c = *src++;
	  *++dest = c;
	  if (c == L'\0')
	    return s;
	  c = *src++;
	  *++dest = c;
	  if (c == L'\0')
	    return s;
	  c = *src++;
	  *++dest = c;
	  if (c == L'\0')
	    return s;
	} while (--n4 > 0);
      n &= 3;
    }

  while (n > 0)
    {
      c = *src++;
      *++dest = c;
      if (c == L'\0')
	return s;
      n--;
    }

  if (c != L'\0')
    *++dest = L'\0';

  return s;
}
