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
