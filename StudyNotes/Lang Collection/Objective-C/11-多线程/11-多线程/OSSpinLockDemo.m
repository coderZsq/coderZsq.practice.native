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
// High-level lock
@property (assign, nonatomic) OSSpinLock moneyLock;
@property (assign, nonatomic) OSSpinLock ticketLock;
@end

@implementation OSSpinLockDemo

/*
 0x10ca420a1 <+33>:  callq  0x10ca432be               ; symbol stub for: OSSpinLockLock
 ->  0x10ca432be <+0>: jmpq   *0x1d94(%rip)             ; (void *)0x000000010fa8b06f: OSSpinLockLock
 libsystem_platform.dylib`OSSpinLockLock:
 ->  0x10fa8b06f <+0>:  movl   $0xffffffff, %ecx         ; imm = 0xFFFFFFFF
 0x10fa8b074 <+5>:  xorl   %eax, %eax
 0x10fa8b076 <+7>:  lock
 0x10fa8b077 <+8>:  cmpxchgl %ecx, (%rdi)
 0x10fa8b07a <+11>: jne    0x10fa8b8c5               ; _OSSpinLockLockSlow
 0x10fa8b080 <+17>: retq
 libsystem_platform.dylib`_OSSpinLockLockSlow:
 ->  0x10fa8b8c5 <+0>:  movl   $0xfffffc18, %ecx         ; imm = 0xFFFFFC18
 0x10fa8b8ca <+5>:  movl   $0xffffffff, %edx         ; imm = 0xFFFFFFFF
 0x10fa8b8cf <+10>: jmp    0x10fa8b8e2               ; <+29>
 0x10fa8b8d1 <+12>: cmpl   $-0x1, %eax
 0x10fa8b8d4 <+15>: jne    0x10fa8b8f1               ; <+44>
 0x10fa8b8d6 <+17>: testl  %ecx, %ecx
 0x10fa8b8d8 <+19>: je     0x10fa8d0f9               ; _OSSpinLockLockYield
 0x10fa8b8de <+25>: pause
 0x10fa8b8e0 <+27>: incl   %ecx
 0x10fa8b8e2 <+29>: movl   (%rdi), %eax
 0x10fa8b8e4 <+31>: testl  %eax, %eax
 0x10fa8b8e6 <+33>: jne    0x10fa8b8d1               ; <+12>
 0x10fa8b8e8 <+35>: xorl   %eax, %eax
 0x10fa8b8ea <+37>: lock
 0x10fa8b8eb <+38>: cmpxchgl %edx, (%rdi)
 0x10fa8b8ee <+41>: jne    0x10fa8b8d1               ; <+12>
 0x10fa8b8f0 <+43>: retq
 0x10fa8b8f1 <+44>: pushq  %rbp
 0x10fa8b8f2 <+45>: movq   %rsp, %rbp
 0x10fa8b8f5 <+48>: movslq %eax, %rsi
 0x10fa8b8f8 <+51>: callq  0x10fa8d0df               ; _os_lock_corruption_abort
 */

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
