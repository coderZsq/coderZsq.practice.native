/* Inline floating-point environment handling functions for powerpc.
   Copyright (C) 1995-2018 Free Software Foundation, Inc.
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

#if defined __GNUC__ && !defined _SOFT_FLOAT && !defined __NO_FPRS__

/* Inline definition for fegetround.  */
# define __fegetround() \
  (__extension__  ({ int __fegetround_result;				      \
		     __asm__ __volatile__				      \
		       ("mcrfs 7,7 ; mfcr %0"				      \
			: "=r"(__fegetround_result) : : "cr7");		      \
		     __fegetround_result & 3; }))
# define fegetround() __fegetround ()

# ifndef __NO_MATH_INLINES
/* The weird 'i#*X' constraints on the following suppress a gcc
   warning when __excepts is not a constant.  Otherwise, they mean the
   same as just plain 'i'.  */

#  if __GNUC_PREREQ(3, 4)

/* Inline definition for feraiseexcept.  */
#   define feraiseexcept(__excepts) \
  (__extension__  ({ 							      \
    int __e = __excepts;						      \
    int __ret;								      \
    if (__builtin_constant_p (__e)					      \
        && (__e & (__e - 1)) == 0					      \
        && __e != FE_INVALID)						      \
      {									      \
	if (__e != 0)							      \
	  __asm__ __volatile__ ("mtfsb1 %0"				      \
				: : "i#*X" (__builtin_clz (__e)));	      \
        __ret = 0;							      \
      }									      \
    else								      \
      __ret = feraiseexcept (__e);					      \
    __ret;								      \
  }))

/* Inline definition for feclearexcept.  */
#   define feclearexcept(__excepts) \
  (__extension__  ({ 							      \
    int __e = __excepts;						      \
    int __ret;								      \
    if (__builtin_constant_p (__e)					      \
        && (__e & (__e - 1)) == 0					      \
        && __e != FE_INVALID)						      \
      {									      \
	if (__e != 0)							      \
	  __asm__ __volatile__ ("mtfsb0 %0"				      \
				: : "i#*X" (__builtin_clz (__e)));	      \
        __ret = 0;							      \
      }									      \
    else								      \
      __ret = feclearexcept (__e);					      \
    __ret;								      \
  }))

#  endif /* __GNUC_PREREQ(3, 4).  */

# endif /* !__NO_MATH_INLINES.  */

#endif /* __GNUC__ && !_SOFT_FLOAT && !__NO_FPRS__ */
