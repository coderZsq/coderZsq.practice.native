/* @(#)s_isnan.c 5.1 93/09/24 */
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
static char rcsid[] = "$NetBSD: s_isnan.c,v 1.8 1995/05/10 20:47:36 jtc Exp $";
#endif

/*
 * isnan(x) returns 1 is x is nan, else 0;
 * no branching!
 */

#include <math.h>
#include <math_private.h>
#include <shlib-compat.h>

#undef __isnan
int
__isnan (double x)
{
  int32_t hx, lx;
  EXTRACT_WORDS (hx, lx, x);
  hx &= 0x7fffffff;
  hx |= (uint32_t) (lx | (-lx)) >> 31;
  hx = 0x7ff00000 - hx;
  return (int) (((uint32_t) hx) >> 31);
}
hidden_def (__isnan)
weak_alias (__isnan, isnan)
#ifdef NO_LONG_DOUBLE
# if defined LDBL_CLASSIFY_COMPAT && SHLIB_COMPAT (libc, GLIBC_2_0, GLIBC_2_23)
compat_symbol (libc, __isnan, __isnanl, GLIBC_2_0);
# endif
weak_alias (__isnan, isnanl)
#endif
