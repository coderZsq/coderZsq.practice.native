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

#include <stdint.h>
#include <arch/spr_def.h>

#define GETSP() ({ register uintptr_t stack_ptr asm ("sp"); stack_ptr; })

#define GETTIME(low,high)                       \
  {                                             \
    uint64_t cycles = __insn_mfspr (SPR_CYCLE); \
    low = cycles & 0xffffffff;                  \
    high = cycles >> 32;                        \
  }

#include <sysdeps/generic/memusage.h>
