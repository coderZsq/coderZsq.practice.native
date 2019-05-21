//
//  NSLockDemo.m
//  11-多线程
//
//  Created by 朱双泉 on 2019/5/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "NSLockDemo.h"

@interface NSLockDemo ()
@property (strong, nonatomic) NSLock *ticketLock;
@property (strong, nonatomic) NSLock *moneyLock;
@end

@implementation NSLockDemo

/*
pthread_mutexattr_init(&attr_normal);
pthread_mutexattr_settype(&attr_normal, PTHREAD_MUTEX_NORMAL);
pthread_mutexattr_init(&attr_reporting);
pthread_mutexattr_settype(&attr_reporting, PTHREAD_MUTEX_ERRORCHECK);
pthread_mutexattr_init(&attr_recursive);
pthread_mutexattr_settype(&attr_recursive, PTHREAD_MUTEX_RECURSIVE);

pthread_mutex_init(&deadlock, &attr_normal);
pthread_mutex_lock(&deadlock);
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ticketLock = [[NSLock alloc] init];
        self.moneyLock = [[NSLock alloc] init];
    }
    return self;
}

- (void)__saleTicket {
    [self.ticketLock lock];
    [super __saleTicket];
    [self.ticketLock unlock];
}

- (void)__saveMoney {
    [self.moneyLock lock];
    [super __saveMoney];
    [self.moneyLock unlock];
}

- (void)__drawMoney {
    [self.moneyLock lock];
    [super __drawMoney];
    [self.moneyLock unlock];
}

@end
