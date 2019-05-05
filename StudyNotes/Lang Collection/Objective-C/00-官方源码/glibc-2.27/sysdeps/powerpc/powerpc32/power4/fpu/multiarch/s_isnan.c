/* Multiple versions of isnan.
   Copyright (C) 2013-2018 Free Software Foundation, Inc.
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

#define __isnan __redirect___isnan
#define __isnanf __redirect___isnanf
#define __isnanl __redirect___isnanl
#include <math.h>
#include <math_ldbl_opt.h>
#include <shlib-compat.h>
#include "init-arch.h"

extern __typeof (__isnan) __isnan_ppc32 attribute_hidden;
extern __typeof (__isnan) __isnan_power5 attribute_hidden;
extern __typeof (__isnan) __isnan_power6 attribute_hidden;
extern __typeof (__isnan) __isnan_power7 attribute_hidden;
#undef __isnan
#undef __isnanf
#undef __isnanl

libc_ifunc_redirected (__redirect___isnan, __isnan,
		       (hwcap & PPC_FEATURE_ARCH_2_06)
		       ? __isnan_power7
		       : (hwcap & PPC_FEATURE_ARCH_2_05)
			 ? __isnan_power6
			 : (hwcap & PPC_FEATURE_POWER5)
			   ? __isnan_power5
			   : __isnan_ppc32);

weak_alias (__isnan, isnan)

#ifdef NO_LONG_DOUBLE
strong_alias (__isnan, __isnanl)
weak_alias (__isnan, isnanl)
#endif

#if !IS_IN (libm)
# if LONG_DOUBLE_COMPAT(libc, GLIBC_2_0)
compat_symbol (libc, __isnan, __isnanl, GLIBC_2_0);
compat_symbol (libc, isnan, isnanl, GLIBC_2_0);
# endif
#endif
