/*
 * Copyright (c) 2015 Apple Inc. All rights reserved.
 *
 * @APPLE_LICENSE_HEADER_START@
 *
 * This file contains Original Code and/or Modifications of Original Code
 * as defined in and that are subject to the Apple Public Source License
 * Version 2.0 (the 'License'). You may not use this file except in
 * compliance with the License. Please obtain a copy of the License at
 * http://www.opensource.apple.com/apsl/ and read it before using this
 * file.
 *
 * The Original Code and all software distributed under the License are
 * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
 * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
 * Please see the License for the specific language governing rights and
 * limitations under the License.
 *
 * @APPLE_LICENSE_HEADER_END@
 */

#ifndef __NANO_MALLOC_H
#define __NANO_MALLOC_H

#define MALLOC_HELPER_ZONE_STRING "MallocHelperZone"

// Forward decl for the nanozone.
typedef struct nanozone_s nanozone_t;

// Nano malloc enabled flag
MALLOC_NOEXPORT
extern boolean_t _malloc_engaged_nano;

MALLOC_NOEXPORT
malloc_zone_t *
create_nano_zone(size_t initial_size, malloc_zone_t *helper_zone, unsigned debug_flags);

MALLOC_NOEXPORT
void
nano_forked_zone(nanozone_t *nanozone);

MALLOC_NOEXPORT
void
nano_init(const char *envp[], const char *apple[]);

#endif // __NANO_MALLOC_H
