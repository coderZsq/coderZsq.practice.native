//
//  release.cpp
//  12-内存管理
//
//  Created by 朱双泉 on 2019/5/23.
//  Copyright © 2019 Castie!. All rights reserved.
//

#include <stdio.h>

#define SIDE_TABLE_RC_ONE            (1UL<<2)  // MSB-ward of deallocating bit

uintptr_t
objc_object::sidetable_release(bool performDealloc)
{
#if SUPPORT_NONPOINTER_ISA
    assert(!isa.nonpointer);
#endif
    SideTable& table = SideTables()[this];
    
    bool do_dealloc = false;
    
    table.lock();
    RefcountMap::iterator it = table.refcnts.find(this);
    if (it == table.refcnts.end()) {
        do_dealloc = true;
        table.refcnts[this] = SIDE_TABLE_DEALLOCATING;
    } else if (it->second < SIDE_TABLE_DEALLOCATING) {
        // SIDE_TABLE_WEAKLY_REFERENCED may be set. Don't change it.
        do_dealloc = true;
        it->second |= SIDE_TABLE_DEALLOCATING;
    } else if (! (it->second & SIDE_TABLE_RC_PINNED)) {
        it->second -= SIDE_TABLE_RC_ONE;
    }
    table.unlock();
    if (do_dealloc  &&  performDealloc) {
        ((void(*)(objc_object *, SEL))objc_msgSend)(this, SEL_dealloc);
    }
    return do_dealloc;
}

ALWAYS_INLINE bool
objc_object::rootRelease(bool performDealloc, bool handleUnderflow)
{
    if (isTaggedPointer()) return false;
    
    bool sideTableLocked = false;
    
    isa_t oldisa;
    isa_t newisa;
    
retry:
    do {
        oldisa = LoadExclusive(&isa.bits);
        newisa = oldisa;
        if (slowpath(!newisa.nonpointer)) {
            ClearExclusive(&isa.bits);
            if (sideTableLocked) sidetable_unlock();
            return sidetable_release(performDealloc);
        }
        // don't check newisa.fast_rr; we already called any RR overrides
        uintptr_t carry;
        newisa.bits = subc(newisa.bits, RC_ONE, 0, &carry);  // extra_rc--
        if (slowpath(carry)) {
            // don't ClearExclusive()
            goto underflow;
        }
    } while (slowpath(!StoreReleaseExclusive(&isa.bits,
                                             oldisa.bits, newisa.bits)));
    
    if (slowpath(sideTableLocked)) sidetable_unlock();
    return false;
    
underflow:
    // newisa.extra_rc-- underflowed: borrow from side table or deallocate
    
    // abandon newisa to undo the decrement
    newisa = oldisa;
    
    if (slowpath(newisa.has_sidetable_rc)) {
        if (!handleUnderflow) {
            ClearExclusive(&isa.bits);
            return rootRelease_underflow(performDealloc);
        }
        
        // Transfer retain count from side table to inline storage.
        
        if (!sideTableLocked) {
            ClearExclusive(&isa.bits);
            sidetable_lock();
            sideTableLocked = true;
            // Need to start over to avoid a race against
            // the nonpointer -> raw pointer transition.
            goto retry;
        }
        
        // Try to remove some retain counts from the side table.
        size_t borrowed = sidetable_subExtraRC_nolock(RC_HALF);
        
        // To avoid races, has_sidetable_rc must remain set
        // even if the side table count is now zero.
        
        if (borrowed > 0) {
            // Side table retain count decreased.
            // Try to add them to the inline count.
            newisa.extra_rc = borrowed - 1;  // redo the original decrement too
            bool stored = StoreReleaseExclusive(&isa.bits,
                                                oldisa.bits, newisa.bits);
            if (!stored) {
                // Inline update failed.
                // Try it again right now. This prevents livelock on LL/SC
                // architectures where the side table access itself may have
                // dropped the reservation.
                isa_t oldisa2 = LoadExclusive(&isa.bits);
                isa_t newisa2 = oldisa2;
                if (newisa2.nonpointer) {
                    uintptr_t overflow;
                    newisa2.bits =
                    addc(newisa2.bits, RC_ONE * (borrowed-1), 0, &overflow);
                    if (!overflow) {
                        stored = StoreReleaseExclusive(&isa.bits, oldisa2.bits,
                                                       newisa2.bits);
                    }
                }
            }
            
            if (!stored) {
                // Inline update failed.
                // Put the retains back in the side table.
                sidetable_addExtraRC_nolock(borrowed);
                goto retry;
            }
            
            // Decrement successful after borrowing from side table.
            // This decrement cannot be the deallocating decrement - the side
            // table lock and has_sidetable_rc bit ensure that if everyone
            // else tried to -release while we worked, the last one would block.
            sidetable_unlock();
            return false;
        }
        else {
            // Side table is empty after all. Fall-through to the dealloc path.
        }
    }
    
    // Really deallocate.
    
    if (slowpath(newisa.deallocating)) {
        ClearExclusive(&isa.bits);
        if (sideTableLocked) sidetable_unlock();
        return overrelease_error();
        // does not actually return
    }
    newisa.deallocating = true;
    if (!StoreExclusive(&isa.bits, oldisa.bits, newisa.bits)) goto retry;
    
    if (slowpath(sideTableLocked)) sidetable_unlock();
    
    __sync_synchronize();
    if (performDealloc) {
        ((void(*)(objc_object *, SEL))objc_msgSend)(this, SEL_dealloc);
    }
    return true;
}


ALWAYS_INLINE bool
objc_object::rootRelease()
{
    return rootRelease(true, false);
}

- (oneway void)release {
    ((id)self)->rootRelease();
}
