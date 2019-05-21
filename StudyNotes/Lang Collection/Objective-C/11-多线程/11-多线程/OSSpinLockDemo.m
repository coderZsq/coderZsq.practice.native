 //
//  OSSpinLockDemo.m
//  11-多线程
//
//  Created by 朱双泉 on 2019/5/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "OSSpinLockDemo.h"
#import <libkern/OSAtomic.h>

@interface OSSpinLockDemo ()
@property (assign, nonatomic) OSSpinLock moneyLock;
@property (assign, nonatomic) OSSpinLock ticketLock;
@end

@implementation OSSpinLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moneyLock = OS_SPINLOCK_INIT;
        self.ticketLock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (void)__drawMoney {
    OSSpinLockLock(&_moneyLock);
    [super __drawMoney];
    OSSpinLockUnlock(&_moneyLock);
}

- (void)__saveMoney {
    OSSpinLockLock(&_moneyLock);
    [super __saveMoney];
    OSSpinLockUnlock(&_moneyLock);
}

- (void)__saleTicket {
    
//    if (OSSpinLockTry(&_lock)) {
//        [super __saleTicket];
//        OSSpinLockUnlock(&_lock);
//    }
    
    OSSpinLockLock(&_ticketLock);
    [super __saleTicket];
    OSSpinLockUnlock(&_ticketLock);
}

@end
