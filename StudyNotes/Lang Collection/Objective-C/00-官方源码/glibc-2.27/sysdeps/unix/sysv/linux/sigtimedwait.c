/* Copyright (C) 1997-2018 Free Software Foundation, Inc.
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

#include <errno.h>
#include <signal.h>
#include <string.h>
#include <sysdep-cancel.h>

int
__sigtimedwait (const sigset_t *set, siginfo_t *info,
		const struct timespec *timeout)
{
  sigset_t tmpset;
  if (set != NULL
      && (__builtin_expect (__sigismember (set, SIGCANCEL), 0)
	  || __builtin_expect (__sigismember (set, SIGSETXID), 0)))
    {
      /* Create a temporary mask without the bit for SIGCANCEL set.  */
      // We are not copying more than we have to.
      memcpy (&tmpset, set, _NSIG / 8);
      __sigdelset (&tmpset, SIGCANCEL);
      __sigdelset (&tmpset, SIGSETXID);
      set = &tmpset;
    }

    /* XXX The size argument hopefully will have to be changed to the
       real size of the user-level sigset_t.  */
  int result = SYSCALL_CANCEL (rt_sigtimedwait, set, info, timeout, _NSIG / 8);

  /* The kernel generates a SI_TKILL code in si_code in case tkill is
     used.  tkill is transparently used in raise().  Since having
     SI_TKILL as a code is useful in general we fold the results
     here.  */
  if (result != -1 && info != NULL && info->si_code == SI_TKILL)
    info->si_code = SI_USER;

  return result;
}
libc_hidden_def (__sigtimedwait)
weak_alias (__sigtimedwait, sigtimedwait)
