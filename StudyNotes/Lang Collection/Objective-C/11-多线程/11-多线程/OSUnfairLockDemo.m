//
//  OSUnfairLockDemo.m
//  11-多线程
//
//  Created by 朱双泉 on 2019/5/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>

@interface OSUnfairLockDemo ()
// Low-level lock
// ll lock
// lll
// Low-level lock的特点等不到锁就休眠
@property (assign, nonatomic) os_unfair_lock moneyLock;
@property (assign, nonatomic) os_unfair_lock ticketLock;
@end

@implementation OSUnfairLockDemo

/*
 0x10d012061 <+33>:  callq  0x10d014330               ; symbol stub for: os_unfair_lock_lock
 11-多线程`os_unfair_lock_lock:
 ->  0x10d014330 <+0>: jmpq   *0x1dba(%rip)             ; (void *)0x000000010ff8d46e: os_unfair_lock_lock
 libsystem_platform.dylib`os_unfair_lock_lock:
 ->  0x10ff8d481 <+19>: jmp    0x10ff8dbcb               ; _os_unfair_lock_lock_slow
 0x10ff8dc4f <+132>: callq  0x10ff925a6               ; symbol stub for: __ulock_wait
 libsystem_platform.dylib`__ulock_wait:
 ->  0x10ff925a6 <+0>: jmpq   *0x2ac4(%rip)             ; (void *)0x000000010ff4b9d4: __ulock_wait
 libsystem_kernel.dylib`__ulock_wait:
 ->  0x10ff4b9d4 <+0>:  movl   $0x2000203, %eax          ; imm = 0x2000203
 0x10ff4b9d9 <+5>:  movq   %rcx, %r10
 0x10ff4b9dc <+8>:  syscall
 0x10ff4b9de <+10>: jae    0x10ff4b9e8               ; <+20>
 0x10ff4b9e0 <+12>: movq   %rax, %rdi
 0x10ff4b9e3 <+15>: jmp    0x10ff49457               ; cerror_nocancel
 0x10ff4b9e8 <+20>: retq
 0x10ff4b9e9 <+21>: nop
 0x10ff4b9ea <+22>: nop
 0x10ff4b9eb <+23>: nop
 */

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moneyLock = OS_UNFAIR_LOCK_INIT;
        self.ticketLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

// 死锁: 永远拿不到锁
- (void)__saleTicket {
    os_unfair_lock_lock(&_ticketLock);
    [super __saleTicket];
    os_unfair_lock_unlock(&_ticketLock);
}

- (void)__saveMoney {
    os_unfair_lock_lock(&_moneyLock);
    [super __saveMoney];
    os_unfair_lock_unlock(&_moneyLock);
}

- (void)__drawMoney {
    os_unfair_lock_lock(&_moneyLock);
    [super __drawMoney];
    os_unfair_lock_unlock(&_moneyLock);
}

@end
