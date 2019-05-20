//
//  ViewController.m
//  11-多线程
//
//  Created by 朱双泉 on 2019/5/20.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (assign, nonatomic) int ticketsCount;
@property (nonatomic, assign) int money;
@end

@implementation ViewController

// dispatch_sync和dispatch_async用来控制是否要开启新的线程
/*
 队列的类型, 决定了任务的执行方式 (并发, 串行)
 1.并发队列
 2.串行队列
 3.主队列 (也是一个串行队列)
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    [self moneyTest];
}

- (void)moneyTest {
    self.money = 100;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self saveMoney];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self drawMoney];
        }
    });
}

- (void)saveMoney {
    int oldMoney = self.money;
    sleep(.2);
    oldMoney += 50;
    self.money = oldMoney;
    
    NSLog(@"存50, 还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}

- (void)drawMoney {
    
    int oldMoney = self.money;
    sleep(.2);
    oldMoney -= 20;
    self.money = oldMoney;
    
    NSLog(@"取20, 还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}

- (void)saleTicket {
    int oldTicketsCount = self.ticketsCount;
    sleep(.2);
    oldTicketsCount--;
    self.ticketsCount = oldTicketsCount;
    
    NSLog(@"还剩%d张票 - %@", oldTicketsCount, [NSThread currentThread]);
}

- (void)ticketTest {
    self.ticketsCount = 15;
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self saleTicket];
        }
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
    // 添加异步任务
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务1 - %@", [NSThread currentThread]);
        }
    });
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务2 - %@", [NSThread currentThread]);
        }
    });
    // 等前面的任务执行完毕后, 会自动执行这个任务
//    dispatch_group_notify(group, queue, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            for (int i = 0; i < 5; i++) {
//                NSLog(@"任务3 - %@", [NSThread currentThread]);
//            }
//        });
//    });
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        for (int i = 0; i < 5; i++) {
//            NSLog(@"任务3 - %@", [NSThread currentThread]);
//        }
//    });
    dispatch_group_notify(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务3 - %@", [NSThread currentThread]);
        }
    });
    dispatch_group_notify(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务4 - %@", [NSThread currentThread]);
        }
    });
}

- (void)test9 {
    NSLog(@"2");
}
#if 0
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
        
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
    [thread start];
     
    [self performSelector:@selector(test9) onThread:thread withObject:nil waitUntilDone:YES];
}
#endif
- (void)test8 {
    NSLog(@"2");
}
#if 0
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"1");
        // 这句代码的本质是往Runloop中添加定时器, 子线程默认没有启动Runloop
        [self performSelector:@selector(test8) withObject:nil afterDelay:.0];
        /*
        - (void) performSelector: (SEL)aSelector
                      withObject: (id)argument
                      afterDelay: (NSTimeInterval)seconds
        {
            NSRunLoop        *loop = [NSRunLoop currentRunLoop];
            GSTimedPerformer    *item;
            
            item = [[GSTimedPerformer alloc] initWithSelector: aSelector
                                                       target: self
                                                     argument: argument
                                                        delay: seconds];
            [[loop _timedPerformers] addObject: item];
            RELEASE(item);
            [loop addTimer: item->timer forMode: NSDefaultRunLoopMode];
        }*/
        NSLog(@"3");
        
        [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
            NSLog(@"123");
        }];
        
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        /*
        - (void) run
        {
            [self runUntilDate: theFuture];
        }
        
        - (void) runUntilDate: (NSDate*)date
        {
            BOOL        mayDoMore = YES;
            
            Positive values are in the future.
            while (YES == mayDoMore)
            {
                mayDoMore = [self runMode: NSDefaultRunLoopMode beforeDate: date];
                if (nil == date || [date timeIntervalSinceNow] <= 0.0)
                {
                    mayDoMore = NO;
                }
            }
        }*/
    });
}
#endif
- (void)test7 {
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue3 = dispatch_queue_create("queue3", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue4 = dispatch_queue_create("queue4", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue5 = dispatch_queue_create("queue4", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"%p %p %p %p %p", queue1, queue2, queue3, queue4, queue5);
}

- (void)test6 {
    // 问题: 以下代码是在主线程执行的, 会不会产生死锁? 不会!
    
    NSLog(@"执行任务1");
    
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{ // 0
        NSLog(@"执行任务2");
        
        dispatch_sync(queue, ^{ // 1
            NSLog(@"执行任务3");
        });
        
        NSLog(@"执行任务4");
    });
    
    NSLog(@"执行任务5");
}

- (void)test5 {
    // 问题: 以下代码是在主线程执行的, 会不会产生死锁? 不会!
    
    NSLog(@"执行任务1");
    
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue2 = dispatch_queue_create("myqueue2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("myqueue2", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{ // 0
        NSLog(@"执行任务2");
        
        dispatch_sync(queue2, ^{ // 1
            NSLog(@"执行任务3");
        });
        
        NSLog(@"执行任务4");
    });
    
    NSLog(@"执行任务5");
}

- (void)test4 {
    // 问题: 以下代码是在主线程执行的, 会不会产生死锁? 会!
    
    NSLog(@"执行任务1");
    
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{ // 0
        NSLog(@"执行任务2");
        
        dispatch_sync(queue, ^{ // 1
            NSLog(@"执行任务3");
        });
        
        NSLog(@"执行任务4");
    });

    NSLog(@"执行任务5");
}

- (void)test3 {
    // 问题: 以下代码是在主线程执行的, 会不会产生死锁? 不会!
    
    NSLog(@"执行任务1");
    
    // 队列的特点, 排队, FIFO, First In First Out, 先进先出
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
    });
    
    // dispatch_async: 不要求立马在当前线程执行任务
    
    NSLog(@"执行任务3");
}

- (void)test2 {
    // 问题: 以下代码是在主线程执行的, 会不会产生死锁? 会!
    
    NSLog(@"执行任务1");
    
    // 队列的特点, 排队, FIFO, First In First Out, 先进先出
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"执行任务2");
    });
    
    // dispatch_sync: 立马在当前线程执行任务, 执行完毕才能继续往下执行
    
    NSLog(@"执行任务3");
}

- (void)test {
    //    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
    //    dispatch_async(queue, ^{
    //        for (int i = 0; i < 10; i++) {
    //            NSLog(@"执行任务1 - %@", [NSThread currentThread]);
    //        }
    //    });
    //    dispatch_async(queue, ^{
    //        for (int i = 0; i < 10; i++) {
    //            NSLog(@"执行任务2 - %@", [NSThread currentThread]);
    //        }
    //    });
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"执行任务 - %@", [NSThread currentThread]);
    });
}

@end
