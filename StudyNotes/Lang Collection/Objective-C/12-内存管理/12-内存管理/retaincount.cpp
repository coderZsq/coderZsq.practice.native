//
//  retaincount.cpp
//  12-内存管理
//
//  Created by 朱双泉 on 2019/5/23.
//  Copyright © 2019 Castie!. All rights reserved.
//

#include <stdio.h>

size_t
objc_object::sidetable_getExtraRC_nolock()
{
    assert(isa.nonpointer);
    SideTable& table = SideTables()[this];
    RefcountMap::iterator it = table.refcnts.find(this);
    if (it == table.refcnts.end()) return 0;
    else return it->second >> SIDE_TABLE_RC_SHIFT;
}

inline uintptr_t
objc_object::rootRetainCount()
{
    if (isTaggedPointer()) return (uintptr_t)this;
    
    sidetable_lock();
    isa_t bits = LoadExclusive(&isa.bits);
    ClearExclusive(&isa.bits);
    if (bits.nonpointer) { // 优化过的isa
        uintptr_t rc = 1 + bits.extra_rc;
        if (bits.has_sidetable_rc) { // 引用计数不是存储在isa中, 而是存储在sidetable中
            rc += sidetable_getExtraRC_nolock();
        }
        sidetable_unlock();
        return rc;
    }
    
    sidetable_unlock();
    return sidetable_retainCount();
}

- (NSUInteger)retainCount {
    return ((id)self)->rootRetainCount();
}
