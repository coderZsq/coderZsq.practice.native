/* Common definitions for preadv and pwritev.
   Copyright (C) 2016-2018 Free Software Foundation, Inc.
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

#include <stdio.h>
#include <stdint.h>
#include <errno.h>
#include <string.h>
#include <sys/uio.h>
#include <sys/stat.h>

#include <support/check.h>
#include <support/temp_file.h>

static char *temp_filename;
static int temp_fd;

static int do_test (void);

static void
do_prepare (int argc, char **argv)
{
  temp_fd = create_temp_file ("tst-preadvwritev.", &temp_filename);
  if (temp_fd == -1)
    FAIL_EXIT1 ("cannot create temporary file");
}
#define PREPARE do_prepare

#ifndef PREADV
# define PREADV(__fd, __iov, __iovcnt, __offset) \
  preadv (__fd, __iov, __iovcnt, __offset)
#endif

#ifndef PWRITEV
# define PWRITEV(__fd, __iov, __iovcnt, __offset) \
  pwritev (__fd, __iov, __iovcnt, __offset)
#endif

static int
do_test_with_offset (off_t offset)
{
  struct iovec iov[2];
  ssize_t ret;

  char buf1[32];
  char buf2[64];

  memset (buf1, 0xf0, sizeof buf1);
  memset (buf2, 0x0f, sizeof buf2);

  /* Write two buffer with 32 and 64 bytes respectively.  */
  memset (iov, 0, sizeof iov);
  iov[0].iov_base = buf1;
  iov[0].iov_len = sizeof buf1;
  iov[1].iov_base = buf2;
  iov[1].iov_len = sizeof buf2;

  ret = PWRITEV (temp_fd, iov, 2, offset);
  if (ret == -1)
    FAIL_RET ("first pwritev returned -1");
  if (ret != (sizeof buf1 + sizeof buf2))
    FAIL_RET ("first pwritev returned an unexpected value");

  ret = PWRITEV (temp_fd, iov, 2, sizeof buf1 + sizeof buf2 + offset);
  if (ret == -1)
    FAIL_RET ("second pwritev returned -1");
  if (ret != (sizeof buf1 + sizeof buf2))
    FAIL_RET ("second pwritev returned an unexpected value");

  char buf3[32];
  char buf4[64];

  memset (buf3, 0x0f, sizeof buf3);
  memset (buf4, 0xf0, sizeof buf4);

  iov[0].iov_base = buf3;
  iov[0].iov_len = sizeof buf3;
  iov[1].iov_base = buf4;
  iov[1].iov_len = sizeof buf4;

  /* Now read two buffer with 32 and 64 bytes respectively.  */
  ret = PREADV (temp_fd, iov, 2, offset);
  if (ret == -1)
    FAIL_RET ("first preadv returned -1");
  if (ret != (sizeof buf3 + sizeof buf4))
    FAIL_RET ("first preadv returned an unexpected value");

  if (memcmp (buf1, buf3, sizeof buf1) != 0)
    FAIL_RET ("first buffer from first preadv different than expected");
  if (memcmp (buf2, buf4, sizeof buf2) != 0)
    FAIL_RET ("second buffer from first preadv different than expected");

  ret = PREADV (temp_fd, iov, 2, sizeof buf3 + sizeof buf4 + offset);
  if (ret == -1)
    FAIL_RET ("second preadv returned -1");
  if (ret != (sizeof buf3 + sizeof buf4))
    FAIL_RET ("second preadv returned an unexpected value");

  /* And compare the buffers read and written to check if there are equal.  */
  if (memcmp (buf1, buf3, sizeof buf1) != 0)
    FAIL_RET ("first buffer from second preadv different than expected");
  if (memcmp (buf2, buf4, sizeof buf2) != 0)
    FAIL_RET ("second buffer from second preadv different than expected");

  return 0;
}

#include <support/test-driver.c>
