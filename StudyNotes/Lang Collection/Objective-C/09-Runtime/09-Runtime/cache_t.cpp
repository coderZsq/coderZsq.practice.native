//
//  cache_t.cpp
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#include <stdio.h>

void cache_t::reallocate(mask_t oldCapacity, mask_t newCapacity)
{
    bool freeOld = canBeFreed();
    
    bucket_t *oldBuckets = buckets();
    bucket_t *newBuckets = allocateBuckets(newCapacity);
    
    // Cache's old contents are not propagated.
    // This is thought to save cache memory at the cost of extra cache fills.
    // fixme re-measure this
    
    assert(newCapacity > 0);
    assert((uintptr_t)(mask_t)(newCapacity-1) == newCapacity-1);
    
    setBucketsAndMask(newBuckets, newCapacity - 1);
    
    if (freeOld) {
        cache_collect_free(oldBuckets, oldCapacity);
        cache_collect(false);
    }
}

void cache_t::expand()
{
    cacheUpdateLock.assertLocked();
    
    uint32_t oldCapacity = capacity();
    uint32_t newCapacity = oldCapacity ? oldCapacity*2 : INIT_CACHE_SIZE;
    
    if ((uint32_t)(mask_t)newCapacity != newCapacity) {
        // mask overflow - can't grow further
        // fixme this wastes one bit of mask
        newCapacity = oldCapacity;
    }
    
    reallocate(oldCapacity, newCapacity);
}

#if __arm__  ||  __x86_64__  ||  __i386__
// objc_msgSend has few registers available.
// Cache scan increments and wraps at special end-marking bucket.
#define CACHE_END_MARKER 1
static inline mask_t cache_next(mask_t i, mask_t mask) {
    return (i+1) & mask;
}

#elif __arm64__
// objc_msgSend has lots of registers available.
// Cache scan decrements. No end marker needed.
#define CACHE_END_MARKER 0
static inline mask_t cache_next(mask_t i, mask_t mask) {
    return i ? i-1 :  mask;
}

#else
#error unknown architecture
#endif

static inline mask_t cache_hash(cache_key_t key, mask_t mask)
{
    return (mask_t)(key & mask);
}

bucket_t * cache_t::find(cache_key_t k, id receiver)
{
    assert(k != 0);
    
    bucket_t *b = buckets();
    mask_t m = mask();
    mask_t begin = cache_hash(k, m);
    mask_t i = begin;
    do {
        if (b[i].key() == 0  ||  b[i].key() == k) {
            return &b[i];
        }
    } while ((i = cache_next(i, m)) != begin);
    
    // hack
    Class cls = (Class)((uintptr_t)this - offsetof(objc_class, cache));
    cache_t::bad_cache(receiver, (SEL)k, cls);
}
