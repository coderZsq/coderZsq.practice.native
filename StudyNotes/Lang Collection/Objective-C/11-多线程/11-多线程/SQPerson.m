//
//  SQPerson.m
//  11-多线程
//
//  Created by 朱双泉 on 2019/5/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson.h"


/*
 nonatomic 和 atomic
 atom: 原子, 不可再分割单位
 atomic: 原子性
 
 给属性加上atomic修饰, 可以保证属性的setter和getter都是原子性操作, 也就是保证setter和getter内部是线程同步的
 
 // 加锁
 int a = 10;
 int b = 20;
 int c = a + b;
 // 解锁
 
 */
@implementation SQPerson

//- (void)setName:(NSString *)name {
//    // 加锁
//    _name = name;
//    // 解锁
//}

//- (NSString *)name {
//    // 加锁
//    return _name;
//    // 解锁
//}

#if 0
id objc_getProperty(id self, SEL _cmd, ptrdiff_t offset, BOOL atomic) {
    if (offset == 0) {
        return object_getClass(self);
    }
    
    // Retain release world
    id *slot = (id*) ((char*)self + offset);
    if (!atomic) return *slot;
    
    // Atomic retain release world
    spinlock_t& slotlock = PropertyLocks[slot];
    slotlock.lock();
    id value = objc_retain(*slot);
    slotlock.unlock();
    
    // for performance, we (safely) issue the autorelease OUTSIDE of the spinlock.
    return objc_autoreleaseReturnValue(value);
}

static inline void reallySetProperty(id self, SEL _cmd, id newValue, ptrdiff_t offset, bool atomic, bool copy, bool mutableCopy)
{
    if (offset == 0) {
        object_setClass(self, newValue);
        return;
    }
    
    id oldValue;
    id *slot = (id*) ((char*)self + offset);
    
    if (copy) {
        newValue = [newValue copyWithZone:nil];
    } else if (mutableCopy) {
        newValue = [newValue mutableCopyWithZone:nil];
    } else {
        if (*slot == newValue) return;
        newValue = objc_retain(newValue);
    }
    
    if (!atomic) {
        oldValue = *slot;
        *slot = newValue;
    } else {
        spinlock_t& slotlock = PropertyLocks[slot];
        slotlock.lock();
        oldValue = *slot;
        *slot = newValue;
        slotlock.unlock();
    }
    
    objc_release(oldValue);
}

void objc_setProperty(id self, SEL _cmd, ptrdiff_t offset, id newValue, BOOL atomic, signed char shouldCopy)
{
    bool copy = (shouldCopy && shouldCopy != MUTABLE_COPY);
    bool mutableCopy = (shouldCopy == MUTABLE_COPY);
    reallySetProperty(self, _cmd, newValue, offset, atomic, copy, mutableCopy);
}
#endif

@end
