/* Multiple versions of copysign.
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

/* Redefine copysign so that the compiler won't complain about the type
   mismatch with the IFUNC selector in strong_alias below.  */
#undef __copysign
#define __copysign __redirect_copysign
#include <math.h>
#include <math_ldbl_opt.h>
#undef __copysign
#include <shlib-compat.h>
#include "init-arch.h"
#include <libm-alias-double.h>

extern __typeof (__redirect_copysign) __copysign_ppc32 attribute_hidden;
extern __typeof (__redirect_copysign) __copysign_power6 attribute_hidden;

extern __typeof (__redirect_copysign) __libm_copysign;
libc_ifunc (__libm_copysign,
	    (hwcap & PPC_FEATURE_ARCH_2_05)
	    ? __copysign_power6
            : __copysign_ppc32);

strong_alias (__libm_copysign, __copysign)
libm_alias_double (__copysign, copysign)

#if LONG_DOUBLE_COMPAT (libc, GLIBC_2_0)
compat_symbol (libc, __copysign, copysignl, GLIBC_2_0);
#endif
