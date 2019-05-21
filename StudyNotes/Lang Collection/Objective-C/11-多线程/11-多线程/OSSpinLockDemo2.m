//
//  OSSpinLockDemo2.m
//  11-多线程
//
//  Created by 朱双泉 on 2019/5/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "OSSpinLockDemo2.h"
#import <libkern/OSAtomic.h>

@interface OSSpinLockDemo2 ()

@end

@implementation OSSpinLockDemo2

static OSSpinLock moneyLock_;

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        moneyLock_ = OS_SPINLOCK_INIT;
    });
}

- (void)__drawMoney {
    OSSpinLockLock(&moneyLock_);
    [super __drawMoney];
    OSSpinLockUnlock(&moneyLock_);
}

- (void)__saveMoney {
    OSSpinLockLock(&moneyLock_);
    [super __saveMoney];
    OSSpinLockUnlock(&moneyLock_);
}

- (void)__saleTicket {

    static OSSpinLock ticketLock = OS_SPINLOCK_INIT;

    OSSpinLockLock(&ticketLock);
    [super __saleTicket];
    OSSpinLockUnlock(&ticketLock);
}

@end

