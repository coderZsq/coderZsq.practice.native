//
//  SQPermenantThread.m
//  10-RunLoop
//
//  Created by 朱双泉 on 2019/5/17.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPermenantThread.h"

@interface SQPermenantThread ()
@property (strong, nonatomic) NSThread *innerThread;
//@property (nonatomic, assign, getter=isStopped) BOOL stopped;
@end

@implementation SQPermenantThread

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.stopped = NO;
//        __weak typeof(self) weakSelf = self;
        self.innerThread = [[NSThread alloc] initWithBlock:^{
            NSLog(@"---BEGIN---");
            
            // 创建上下文 (要初始化一下结构体)
            CFRunLoopSourceContext context = {0};
            
            // 创建Source
            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
            
            // 往Runloop中添加source
            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
            
            //启动
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
//            while (weakSelf && !weakSelf.isStopped) {
//                // 第3个参数: returnAfterSourceHandled, 设置为true, 代表执行完source后就会退出当前loop
//                CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
//            }
            
            // 销毁source
            CFRelease(source);
            
            NSLog(@"----END----");
#if 0
            [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
            while (weakSelf && !weakSelf.isStopped) {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
#endif
        }];
        [self.innerThread start];
    }
    return self;
}

- (void)run {
    [self.innerThread start];
}

- (void)executeTask:(SQPermenantThreadTask)task {
    if (!self.innerThread || !task) return;
//    if (!self.innerThread.isExecuting) {
//        [self.innerThread start];
//    }
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)executeTaskWithTarget:(id)target action:(SEL)action object:(id)object {
    if (!self.innerThread) return;
    [target performSelector:action onThread:self.innerThread withObject:nil waitUntilDone:NO];
}

- (void)stop {
    if (!self.innerThread) return;
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self stop];
}

- (void)__stop {
//    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

- (void)__executeTask:(SQPermenantThreadTask)task {
    task();
}

@end
