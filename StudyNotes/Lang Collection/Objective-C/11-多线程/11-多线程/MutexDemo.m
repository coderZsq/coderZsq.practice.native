//
//  MutexDemo.m
//  11-多线程
//
//  Created by 朱双泉 on 2019/5/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "MutexDemo.h"
#import <pthread.h>

@interface MutexDemo ()
@property (assign, nonatomic) pthread_mutex_t ticketMutex;
@property (assign, nonatomic) pthread_mutex_t moneyMutex;
@end

@implementation MutexDemo

/*
 0x100d24a21 <+33>:  callq  0x100d25348               ; symbol stub for: pthread_mutex_lock
 11-多线程`pthread_mutex_lock:
 ->  0x100d25348 <+0>: jmpq   *0x1dc2(%rip)             ; (void *)0x0000000103caf137: pthread_mutex_lock
 libsystem_pthread.dylib`pthread_mutex_lock:
 ->  0x103caf1aa <+115>: jmp    0x103caf3ef               ; _pthread_mutex_firstfit_lock_slow
 0x103caf4c8 <+217>: callq  0x103cb1cf2               ; _pthread_mutex_firstfit_lock_wait
 0x103cb1d4d <+91>:  callq  0x103cb6b40               ; symbol stub for: __psynch_mutexwait
 libsystem_pthread.dylib`__psynch_mutexwait:
 ->  0x103cb6b40 <+0>: jmpq   *0x257a(%rip)             ; (void *)0x0000000103c5cefc: __psynch_mutexwait
 libsystem_kernel.dylib`__psynch_mutexwait:
 ->  0x103c5cefc <+0>:  movl   $0x200012d, %eax          ; imm = 0x200012D
 0x103c5cf01 <+5>:  movq   %rcx, %r10
 0x103c5cf04 <+8>:  syscall
 0x103c5cf06 <+10>: jae    0x103c5cf10               ; <+20>
 0x103c5cf08 <+12>: movq   %rax, %rdi
 0x103c5cf0b <+15>: jmp    0x103c5a457               ; cerror_nocancel
 0x103c5cf10 <+20>: retq
 0x103c5cf11 <+21>: nop
 0x103c5cf12 <+22>: nop
 0x103c5cf13 <+23>: nop
 */

- (void)__initMutex:(pthread_mutex_t *)mutex {
    // 静态初始化
    //        pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    
    // 初始化属性
//    pthread_mutexattr_t attr;
//    pthread_mutexattr_init(&attr);
//    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    // 初始化锁
//    pthread_mutex_init(mutex, &attr);
    // 销毁属性
//    pthread_mutexattr_destroy(&attr);
    
    pthread_mutex_init(mutex, NULL);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __initMutex:&_ticketMutex];
        [self __initMutex:&_moneyMutex];
    }
    return self;
}

- (void)__saleTicket {
    pthread_mutex_lock(&_ticketMutex);
    [super __saleTicket];
    pthread_mutex_unlock(&_ticketMutex);
}

- (void)__saveMoney {
    pthread_mutex_lock(&_moneyMutex);
    [super __saveMoney];
    pthread_mutex_unlock(&_moneyMutex);
}

- (void)__drawMoney {
    pthread_mutex_lock(&_moneyMutex);
    [super __drawMoney];
    pthread_mutex_unlock(&_moneyMutex);
}

- (void)dealloc {
    pthread_mutex_destroy(&_moneyMutex);
    pthread_mutex_destroy(&_ticketMutex);
}

@end
