//
//  ViewController.m
//  12-内存管理
//
//  Created by 朱双泉 on 2019/5/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "SQObject.h"
#import "SQProxy.h"
#import "SQTimer.h"
#import "SQPerson.h"

@interface ViewController ()
@property (strong, nonatomic) CADisplayLink *link;
//@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, copy) NSString *task;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) UITabBarController *tabBarController;
@end

@implementation ViewController
#if 0 // MRC
- (void)setName:(NSString *)name {
    if (_name != name) {
        [_name release];
        _name = [name copy];
    }
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
#if 0
    @autoreleasepool {
        SQPerson *person = [[[SQPerson alloc] init] autorelease];
    }
    NSLog(@"%s", __func__);
#endif
    // 这个Person什么时候调用release, 是由RunLoop来控制的
    // 它可能是在某次RunLoop循环中, RunLoop休眠之前调用了release
    SQPerson *person = [[[SQPerson alloc] init] autorelease];
    NSLog(@"%s", __func__);
//    NSLog(@"%@", [NSRunLoop mainRunLoop]);
#if 0
     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
         kCFRunLoopEntry = (1UL << 0), // 1
         kCFRunLoopBeforeTimers = (1UL << 1), // 2
         kCFRunLoopBeforeSources = (1UL << 2), // 4
         kCFRunLoopBeforeWaiting = (1UL << 5), // 32
         kCFRunLoopAfterWaiting = (1UL << 6), // 64
         kCFRunLoopExit = (1UL << 7), // 128
         kCFRunLoopAllActivities = 0x0FFFFFFFU
     };
     
     observers = (
     //   kCFRunLoopEntry push
     "<CFRunLoopObserver 0x6000010e4140 [0x10d0f2ae8]>{valid = Yes, activities = 0x1, repeats = Yes, order = -2147483647, callout = _wrapRunLoopWithAutoreleasePoolHandler (0x1156aa87d), context = <CFArray 0x600002fa8270 [0x10d0f2ae8]>{type = mutable-small, count = 1, values = (\n\t0 : <0x7fce97802058>\n)}}",
     ...
     //   kCFRunLoopBeforeWaiting | kCFRunLoopExit
     //   kCFRunLoopBeforeWaiting pop, push
     //   kCFRunLoopExit pop
     "<CFRunLoopObserver 0x6000010e41e0 [0x10d0f2ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2147483647, callout = _wrapRunLoopWithAutoreleasePoolHandler (0x1156aa87d), context = <CFArray 0x600002fa8270 [0x10d0f2ae8]>{type = mutable-small, count = 1, values = (\n\t0 : <0x7fce97802058>\n)}}"
#endif
    // ARC LLVM 直接插入release
    SQPerson *person2 = [[SQPerson alloc] init];
    NSLog(@"%s", __func__);
    [person2 release];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s", __func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s", __func__);
}

- (void)test7 {
    // ARC是LLVM编译器和Runtime系统相互协作的一个结果
    
    __strong SQPerson *person1;
    __weak SQPerson *person2;
    __unsafe_unretained SQPerson *person3;
    {
        SQPerson *person = [[SQPerson alloc] init];
        person2 = person;
    }
    NSLog(@"%s - %@", __func__, person2);
}

- (void)test6 {
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
#if 0
    @implementation NSMutableArray
    
    - (instancetype)array {
        return [[[self alloc] init] autorelease];
    }
    
    @end
#endif
    self.data = [NSMutableArray array];
    
    self.data = [[[NSMutableArray alloc] init] autorelease];
    
    self.data = [[NSMutableArray alloc] init];
    [self.data release];
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    self.data = data;
    [data release];
}

- (void)dealloc {
    self.data = nil;
    self.tabBarController = nil;
    [super dealloc];
}

- (void)test5 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"abc"];
        });
    }
    
    NSString *str1 = [NSString stringWithFormat:@"abcdefghijk"];
    NSString *str2 = [NSString stringWithFormat:@"abc"];
    
    NSLog(@"%@ %@", [str1 class], [str2 class]);
    NSLog(@"%p %p", str1, str2);
}

- (void)test4 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            // 加锁
            self.name = [NSString stringWithFormat:@"abcdefghijk"];
            // 解锁
        });
    }
}

- (void)test3 {
    NSLog(@"begin");
    //    self.task = [SQTimer execTask:^{
    //        NSLog(@"%s- %@", __func__, [NSThread currentThread]);
    //    } start: 2.0 interval: 1.0 repeats: YES async: YES];
    
    self.task = [SQTimer execTask:self selector:@selector(doTask) start:2.0 interval:1.0 repeats:YES async:NO];
}

- (void)doTask {
    NSLog(@"%s - %@", __func__, [NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [SQTimer cancelTask:self.task];
}

- (void)test2 {
    NSLog(@"begin");
    
    // 队列
    //    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_queue_t queue = dispatch_queue_create("timer", DISPATCH_QUEUE_SERIAL);
    
    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置时间
    uint64_t start = 2.0; // 2秒后开始执行
    uint64_t interval = 1.0; // 每隔1秒执行
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC),
                              interval * NSEC_PER_SEC, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"%s", __func__);
    });
    
    dispatch_source_set_event_handler_f(timer, timerFire);
    
    // 启动定时器
    dispatch_resume(timer);
    self.timer = timer;
}

void timerFire(void *param) {
    NSLog(@"%s - %@", __func__, [NSThread currentThread]);
}

- (void)test {
    // 保证调用频率和屏幕的刷帧频率一致, 60FPS
    self.link = [CADisplayLink displayLinkWithTarget:[SQProxy proxyWithTarget:self] selector:@selector(linkTest)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    //    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[SQProxy proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
    
    //    __weak typeof(self) weakSelf = self;
    //    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        [weakSelf timerTest];
    //    }];
}

- (void)timerTest {
    NSLog(@"%s", __func__);
}

- (void)linkTest {
    NSLog(@"%s", __func__);
}
#if 0
- (void)dealloc {
    NSLog(@"%s", __func__);
    [self.link invalidate];
//    [self.timer invalidate];
}
#endif
@end
