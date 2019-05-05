/* @(#)s_finite.c 5.1 93/09/24 */
/*
 * ====================================================
 * Copyright (C) 1993 by Sun Microsystems, Inc. All rights reserved.
 *
 * Developed at SunPro, a Sun Microsystems, Inc. business.
 * Permission to use, copy, modify, and distribute this
 * software is freely granted, provided that this notice
 * is preserved.
 * ====================================================
 */

#if defined(LIBM_SCCS) && !defined(lint)
static char rcsid[] = "$NetBSD: s_finite.c,v 1.8 1995/05/10 20:47:17 jtc Exp $";
#endif

/*
 * finite(x) returns 1 is x is finite, else 0;
 * no branching!
 */

#include <math.h>
#include <math_private.h>
#include <shlib-compat.h>

#undef __finite

#ifndef FINITE
# define FINITE __finite
#endif

int FINITE(double x)
{
  int32_t hx;
  GET_HIGH_WORD (hx, x);
  return (int) ((uint32_t) ((hx & 0x7ff00000) - 0x7ff00000) >> 31);
}
hidden_def (__finite)
weak_alias (__finite, finite)
#ifdef NO_LONG_DOUBLE
# ifdef LDBL_CLASSIFY_COMPAT
#  if SHLIB_COMPAT (libc, GLIBC_2_0, GLIBC_2_23)
compat_symbol (libc, __finite, __finitel, GLIBC_2_0);
#  endif
#  if SHLIB_COMPAT (libm, GLIBC_2_1, GLIBC_2_23)
compat_symbol (libm, __finite, __finitel, GLIBC_2_1);
#  endif
# endif
weak_alias (__finite, finitel)
#endif
