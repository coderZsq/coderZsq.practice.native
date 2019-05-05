#ifndef M68K_MATH_PRIVATE_H
#define M68K_MATH_PRIVATE_H 1

#define math_opt_barrier(x) \
({ __typeof (x) __x;					\
   __asm ("" : "=f" (__x) : "0" (x));			\
   __x; })
#define math_force_eval(x) \
do							\
  {							\
    __typeof (x) __x = (x);				\
    if (sizeof (x) <= sizeof (double))			\
      __asm __volatile ("" : : "m" (__x));		\
    else						\
      __asm __volatile ("" : : "f" (__x));		\
  }							\
while (0)

#include_next <math_private.h>
#endif
