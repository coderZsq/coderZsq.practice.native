//
//  ViewController.m
//  10-RunLoop
//
//  Created by 朱双泉 on 2019/5/16.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "SQThread.h"

@interface ViewController ()
@property (strong, nonatomic) SQThread *thread;
@property (nonatomic, assign, getter=isStopped) BOOL stopped;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.thread = [[SQThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    
    __weak typeof (self) weakSelf = self;
    self.stopped = NO;
    
    self.thread = [[SQThread alloc] initWithBlock:^{
        NSLog(@"%@----begin----", [NSThread currentThread]);
        // 往RunLoop里面添加Source\Timer\Observer
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        while (weakSelf && !weakSelf.isStopped) {
            NSLog(@"%@", weakSelf);
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        /*
         NSRunLoop的run方法是无法停止的, 它专门用于开启一个永不销毁的线程 (NSRunLoop)
         [[NSRunLoop currentRunLoop] run];
         
         it runs the receiver in the NSDefaultRunLoopMode by repeatedly invoking runMode:beforeDate:. In other words, this method effectively begins an infinite loop that processes data from the run loop’s input sources and timers.
         */
        NSLog(@"%@-----end-----", [NSThread currentThread]);
    }];
    [self.thread start];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.thread) return;
    [self performSelector:@selector(test3_test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

// 子线程需要执行的任务
- (void)test3_test {
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
}

- (IBAction)stop {
    if (!self.thread) return;
    // 在子线程调用stop (waitUntilDone设置为YES, 代表子线程的代码执行完毕后, 这个方法才会往下走)
    [self performSelector:@selector(stopThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}

// 用于停止子线程的RunLoop
- (void)stopThread {
    // 设置标记为YES
    self.stopped = YES;
    
    // 停止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
    
    // 清空线程
    self.thread = nil;
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    [self stop];
}

#if 0
- (void)run {
    NSLog(@"%s, %@", __func__, [NSThread currentThread]);
    // 往RunLoop里面添加Source\Timer\Observer
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    NSLog(@"%s -----end-----", __func__);
}
#endif
- (void)test2 {
    static int count = 0;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%d", ++count);
    }];
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode: NSDefaultRunLoopMode];
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode: UITrackingRunLoopMode];
    
    // NSDefaultRunLoopMode, UITrackingRunLoopMode才是真正存在的模式
    // NSRunLoopCommonModes并不是一个真的模式, 它只是一个标记
    // timer能在_commonModes数组中存放的模式下工作
    [[NSRunLoop currentRunLoop] addTimer:timer forMode: NSRunLoopCommonModes];
    
    //    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        NSLog(@"%d", ++count);
    //    }];
}

NSMutableDictionary *runloops;

void observerRunLoopActivities(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit");
            break;
        default:
            break;
    }
}

- (void)test {
    //    NSRunLoop *runloop;
    //    CFRunLoopRef runloop2;
    
    //    runloops[thread] = runloop;
    
    //    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    //    CFRunLoopRef runloop2 = CFRunLoopGetCurrent();
    
    //    NSArray *array;
    //    CFArrayRef array2;
    //
    //    NSString *string;
    //    CFStringRef string2;
    
    NSLog(@"%p %p", [NSRunLoop currentRunLoop], [NSRunLoop mainRunLoop]);
    NSLog(@"%p %p", CFRunLoopGetCurrent(), CFRunLoopGetMain());
    
    // 有序的
    //    NSMutableArray *array;
    //    [array addObject:@""];
    //    array[0];
    
    // 无序的
    //    NSMutableSet *set;
    //    [set addObject:@""];
    //    [set anyObject];
    
    //    kCFRunLoopDefaultMode;
    //    NSDefaultRunLoopMode;
    
    //    NSLog(@"%@", [NSRunLoop mainRunLoop]);
    
    // kCFRunLoopCommonModes默认包括kCFRunLoopDefaultMode, UITrackingRunLoopMode
#if 0
    // 创建Observer
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, observerRunLoopActivities, NULL);
    // 添加observer到RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    // 释放observer
    CFRelease(observer);
#endif
    
    // 创建Observer
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry: {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopEntry - %@", mode);
                CFRelease(mode);
                break;
            }
            case kCFRunLoopExit: {
                CFRunLoopMode mode = CFRunLoopCopyCurrentMode(CFRunLoopGetCurrent());
                NSLog(@"kCFRunLoopExit - %@", mode);
                CFRelease(mode);
                break;
            }
            default:
                break;
        }
    });
    // 添加observer到RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    // 释放observer
    CFRelease(observer);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理一些子线程的逻辑
        
        // 回到主线程去刷新UI界面
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"GCD-------");
        });
        /*
         (lldb)  bt
         * thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
         * frame #0: 0x00000001076e4427 10-RunLoop`__29-[ViewController viewDidLoad]_block_invoke_3(.block_descriptor=0x00000001076e6148) at ViewController.m:118:13
         frame #1: 0x000000010a280d7f libdispatch.dylib`_dispatch_call_block_and_release + 12
         frame #2: 0x000000010a281db5 libdispatch.dylib`_dispatch_client_callout + 8
         frame #3: 0x000000010a28f080 libdispatch.dylib`_dispatch_main_queue_callback_4CF + 1540
         frame #4: 0x000000010897e8a9 CoreFoundation`__CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9
         frame #5: 0x0000000108978f56 CoreFoundation`__CFRunLoopRun + 2310
         frame #6: 0x0000000108978302 CoreFoundation`CFRunLoopRunSpecific + 626
         frame #7: 0x0000000110fd32fe GraphicsServices`GSEventRunModal + 65
         frame #8: 0x000000010bab9ba2 UIKitCore`UIApplicationMain + 140
         frame #9: 0x00000001076e45c0 10-RunLoop`main(argc=1, argv=0x00007ffee851aec8) at main.m:73:16
         frame #10: 0x000000010a2f6541 libdyld.dylib`start + 1
         frame #11: 0x000000010a2f6541 libdyld.dylib`start + 1
         */
    });
}
#if 0
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    /*
     (lldb) bt
     * thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
     * frame #0: 0x000000010d62f65d 10-RunLoop`-[ViewController touchesBegan:withEvent:](self=0x00007fb097c0dc90, _cmd="touchesBegan:withEvent:", touches=1 element, event=0x0000600003edc2d0) at ViewController.m:175:5
     frame #1: 0x00000001116f9a09 UIKitCore`forwardTouchMethod + 353
     frame #2: 0x00000001116f9897 UIKitCore`-[UIResponder touchesBegan:withEvent:] + 49
     frame #3: 0x0000000111708c48 UIKitCore`-[UIWindow _sendTouchesForEvent:] + 1869
     frame #4: 0x000000011170a5d2 UIKitCore`-[UIWindow sendEvent:] + 4079
     frame #5: 0x00000001116e8d16 UIKitCore`-[UIApplication sendEvent:] + 356
     frame #6: 0x00000001117b9293 UIKitCore`__dispatchPreprocessedEventFromEventQueue + 3232
     frame #7: 0x00000001117bbbb9 UIKitCore`__handleEventQueueInternal + 5911
     frame #8: 0x000000010e8c7be1 CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
     frame #9: 0x000000010e8c7463 CoreFoundation`__CFRunLoopDoSources0 + 243
     frame #10: 0x000000010e8c1b1f CoreFoundation`__CFRunLoopRun + 1231
     frame #11: 0x000000010e8c1302 CoreFoundation`CFRunLoopRunSpecific + 626
     frame #12: 0x0000000116f342fe GraphicsServices`GSEventRunModal + 65
     frame #13: 0x00000001116ceba2 UIKitCore`UIApplicationMain + 140
     frame #14: 0x000000010d62f710 10-RunLoop`main(argc=1, argv=0x00007ffee25cfec8) at main.m:73:16
     frame #15: 0x000000011023f541 libdyld.dylib`start + 1
     frame #16: 0x000000011023f541 libdyld.dylib`start + 1
     */
    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSLog(@"定时器-------");
        /*
         (lldb) bt
         * thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
         * frame #0: 0x0000000107000533 10-RunLoop`__41-[ViewController touchesBegan:withEvent:]_block_invoke(.block_descriptor=0x0000000107002188, timer=0x0000600000ca0a80) at ViewController.m:163:9
         frame #1: 0x00000001073c1135 Foundation`__NSFireTimer + 83
         frame #2: 0x000000010829b3e4 CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__ + 20
         frame #3: 0x000000010829aff2 CoreFoundation`__CFRunLoopDoTimer + 1026
         frame #4: 0x000000010829a85a CoreFoundation`__CFRunLoopDoTimers + 266
         frame #5: 0x0000000108294efc CoreFoundation`__CFRunLoopRun + 2220
         frame #6: 0x0000000108294302 CoreFoundation`CFRunLoopRunSpecific + 626
         frame #7: 0x00000001108232fe GraphicsServices`GSEventRunModal + 65
         frame #8: 0x000000010b0a1ba2 UIKitCore`UIApplicationMain + 140
         frame #9: 0x00000001070005c0 10-RunLoop`main(argc=1, argv=0x00007ffee8bfeec8) at main.m:73:16
         frame #10: 0x0000000109c12541 libdyld.dylib`start + 1
         frame #11: 0x0000000109c12541 libdyld.dylib`start + 1
         */
    }];
}
#endif
@end

#if 0
2019-05-16 14:44:10.051633+0800 10-RunLoop[43451:6670533] <CFRunLoop 0x600002444400 [0x108331ae8]>{wakeup port = 0x1f07, stopped = false, ignoreWakeUps = false,
    current mode = kCFRunLoopDefaultMode,
    common modes = <CFBasicHash 0x60000161c000 [0x108331ae8]>{type = mutable set, count = 2,
        entries =>
        0 : <CFString 0x10b6fd070 [0x108331ae8]>{contents = "UITrackingRunLoopMode"}
        2 : <CFString 0x108343ed8 [0x108331ae8]>{contents = "kCFRunLoopDefaultMode"}
    }
    ,
    common mode items = <CFBasicHash 0x60000160fea0 [0x108331ae8]>{type = mutable set, count = 13,
        entries =>
        0 : <CFRunLoopSource 0x600002d54000 [0x108331ae8]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 0, info = 0x0, callout = PurpleEventSignalCallback (0x1105b12bb)}}
        1 : <CFRunLoopSource 0x600002d443c0 [0x108331ae8]>{signalled = No, valid = Yes, order = -2, context = <CFRunLoopSource context>{version = 0, info = 0x60000160a550, callout = __handleHIDEventFetcherDrain (0x10af13842)}}
        4 : <CFRunLoopObserver 0x6000029480a0 [0x108331ae8]>{valid = Yes, activities = 0x20, repeats = Yes, order = 0, callout = _UIGestureRecognizerUpdateObserver (0x10aa0cd19), context = <CFRunLoopObserver context 0x600003348000>}
        6 : <CFRunLoopObserver 0x6000029403c0 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2147483647, callout = _wrapRunLoopWithAutoreleasePoolHandler (0x10ae2887d), context = <CFArray 0x60000161dd70 [0x108331ae8]>{type = mutable-small, count = 1, values = (
                                                                                                                                                                                                                                                                                            0 : <0x7f95bb000058>
                                                                                                                                                                                                                                                                                            )}}
        7 : <CFRunLoopObserver 0x600002940320 [0x108331ae8]>{valid = Yes, activities = 0x1, repeats = Yes, order = -2147483647, callout = _wrapRunLoopWithAutoreleasePoolHandler (0x10ae2887d), context = <CFArray 0x60000161dd70 [0x108331ae8]>{type = mutable-small, count = 1, values = (
                                                                                                                                                                                                                                                                                            0 : <0x7f95bb000058>
                                                                                                                                                                                                                                                                                            )}}
        8 : <CFRunLoopSource 0x600002d44240 [0x108331ae8]>{signalled = No, valid = Yes, order = 0, context = <CFRunLoopSource MIG Server> {port = 42763, subsystem = 0x10b6ad328, context = 0x0}}
        9 : <CFRunLoopObserver 0x6000029401e0 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 1999000, callout = _beforeCACommitHandler (0x10ae56245), context = <CFRunLoopObserver context 0x7f95b7e00a90>}
        10 : <CFRunLoopObserver 0x600002940280 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2001000, callout = _afterCACommitHandler (0x10ae562af), context = <CFRunLoopObserver context 0x7f95b7e00a90>}
        12 : <CFRunLoopSource 0x600002d48000 [0x108331ae8]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 1, info = 0x3103, callout = PurpleEventCallback (0x1105b12c7)}}
        13 : <CFRunLoopObserver 0x600002944500 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2000000, callout = _ZN2CA11Transaction17observer_callbackEP19__CFRunLoopObservermPv (0x10c825e92), context = <CFRunLoopObserver context 0x0>}
        14 : <CFRunLoopSource 0x600002d5c180 [0x108331ae8]>{signalled = No, valid = Yes, order = 0, context = <CFRunLoopSource MIG Server> {port = 41987, subsystem = 0x10b6b5500, context = 0x60000186c420}}
        21 : <CFRunLoopSource 0x600002d5c900 [0x108331ae8]>{signalled = Yes, valid = Yes, order = 0, context = <CFRunLoopSource context>{version = 0, info = 0x600003c5c8a0, callout = FBSSerialQueueRunLoopSourceHandler (0x1136965ec)}}
        22 : <CFRunLoopSource 0x600002d44180 [0x108331ae8]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 0, info = 0x600002d48180, callout = __handleEventQueue (0x10af13836)}}
    }
    ,
    modes = <CFBasicHash 0x60000161c300 [0x108331ae8]>{type = mutable set, count = 4,
        entries =>
        2 : <CFRunLoopMode 0x60000235c000 [0x108331ae8]>{name = UITrackingRunLoopMode, port set = 0x2c03, queue = 0x60000365c100, source = 0x60000365c200 (not fired), timer port = 0x2f03,
            sources0 = <CFBasicHash 0x60000160ff00 [0x108331ae8]>{type = mutable set, count = 4,
                entries =>
                0 : <CFRunLoopSource 0x600002d54000 [0x108331ae8]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 0, info = 0x0, callout = PurpleEventSignalCallback (0x1105b12bb)}}
                2 : <CFRunLoopSource 0x600002d44180 [0x108331ae8]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 0, info = 0x600002d48180, callout = __handleEventQueue (0x10af13836)}}
                3 : <CFRunLoopSource 0x600002d5c900 [0x108331ae8]>{signalled = Yes, valid = Yes, order = 0, context = <CFRunLoopSource context>{version = 0, info = 0x600003c5c8a0, callout = FBSSerialQueueRunLoopSourceHandler (0x1136965ec)}}
                5 : <CFRunLoopSource 0x600002d443c0 [0x108331ae8]>{signalled = No, valid = Yes, order = -2, context = <CFRunLoopSource context>{version = 0, info = 0x60000160a550, callout = __handleHIDEventFetcherDrain (0x10af13842)}}
            }
            ,
            sources1 = <CFBasicHash 0x60000160fed0 [0x108331ae8]>{type = mutable set, count = 3,
                entries =>
                0 : <CFRunLoopSource 0x600002d5c180 [0x108331ae8]>{signalled = No, valid = Yes, order = 0, context = <CFRunLoopSource MIG Server> {port = 41987, subsystem = 0x10b6b5500, context = 0x60000186c420}}
                1 : <CFRunLoopSource 0x600002d48000 [0x108331ae8]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 1, info = 0x3103, callout = PurpleEventCallback (0x1105b12c7)}}
                2 : <CFRunLoopSource 0x600002d44240 [0x108331ae8]>{signalled = No, valid = Yes, order = 0, context = <CFRunLoopSource MIG Server> {port = 42763, subsystem = 0x10b6ad328, context = 0x0}}
            }
            ,
            observers = (
                         "<CFRunLoopObserver 0x600002940320 [0x108331ae8]>{valid = Yes, activities = 0x1, repeats = Yes, order = -2147483647, callout = _wrapRunLoopWithAutoreleasePoolHandler (0x10ae2887d), context = <CFArray 0x60000161dd70 [0x108331ae8]>{type = mutable-small, count = 1, values = (\n\t0 : <0x7f95bb000058>\n)}}",
                         "<CFRunLoopObserver 0x6000029480a0 [0x108331ae8]>{valid = Yes, activities = 0x20, repeats = Yes, order = 0, callout = _UIGestureRecognizerUpdateObserver (0x10aa0cd19), context = <CFRunLoopObserver context 0x600003348000>}",
                         "<CFRunLoopObserver 0x6000029401e0 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 1999000, callout = _beforeCACommitHandler (0x10ae56245), context = <CFRunLoopObserver context 0x7f95b7e00a90>}",
                         "<CFRunLoopObserver 0x600002944500 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2000000, callout = _ZN2CA11Transaction17observer_callbackEP19__CFRunLoopObservermPv (0x10c825e92), context = <CFRunLoopObserver context 0x0>}",
                         "<CFRunLoopObserver 0x600002940280 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2001000, callout = _afterCACommitHandler (0x10ae562af), context = <CFRunLoopObserver context 0x7f95b7e00a90>}",
                         "<CFRunLoopObserver 0x6000029403c0 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2147483647, callout = _wrapRunLoopWithAutoreleasePoolHandler (0x10ae2887d), context = <CFArray 0x60000161dd70 [0x108331ae8]>{type = mutable-small, count = 1, values = (\n\t0 : <0x7f95bb000058>\n)}}"
                         ),
            timers = (null),
            currently 579681850 (197514563464578) / soft deadline in: 1.84465466e+10 sec (@ -1) / hard deadline in: 1.84465466e+10 sec (@ -1)
        },
        
        3 : <CFRunLoopMode 0x60000235c0d0 [0x108331ae8]>{name = GSEventReceiveRunLoopMode, port set = 0x5103, queue = 0x60000365c280, source = 0x60000365c380 (not fired), timer port = 0x5003,
            sources0 = <CFBasicHash 0x60000160fe40 [0x108331ae8]>{type = mutable set, count = 1,
                entries =>
                0 : <CFRunLoopSource 0x600002d54000 [0x108331ae8]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 0, info = 0x0, callout = PurpleEventSignalCallback (0x1105b12bb)}}
            }
            ,
            sources1 = <CFBasicHash 0x60000160fe10 [0x108331ae8]>{type = mutable set, count = 1,
                entries =>
                1 : <CFRunLoopSource 0x600002d480c0 [0x108331ae8]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 1, info = 0x3103, callout = PurpleEventCallback (0x1105b12c7)}}
            }
            ,
            observers = (null),
            timers = (null),
            currently 579681850 (197514564658087) / soft deadline in: 1.84465466e+10 sec (@ -1) / hard deadline in: 1.84465466e+10 sec (@ -1)
        },
        
        4 : <CFRunLoopMode 0x6000023400d0 [0x108331ae8]>{name = kCFRunLoopDefaultMode, port set = 0x200f, queue = 0x600003644200, source = 0x600003644300 (not fired), timer port = 0x1d07,
            sources0 = <CFBasicHash 0x60000160fde0 [0x108331ae8]>{type = mutable set, count = 4,
                entries =>
                0 : <CFRunLoopSource 0x600002d54000 [0x108331ae8]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 0, info = 0x0, callout = PurpleEventSignalCallback (0x1105b12bb)}}
                2 : <CFRunLoopSource 0x600002d44180 [0x108331ae8]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 0, info = 0x600002d48180, callout = __handleEventQueue (0x10af13836)}}
                3 : <CFRunLoopSource 0x600002d5c900 [0x108331ae8]>{signalled = Yes, valid = Yes, order = 0, context = <CFRunLoopSource context>{version = 0, info = 0x600003c5c8a0, callout = FBSSerialQueueRunLoopSourceHandler (0x1136965ec)}}
                5 : <CFRunLoopSource 0x600002d443c0 [0x108331ae8]>{signalled = No, valid = Yes, order = -2, context = <CFRunLoopSource context>{version = 0, info = 0x60000160a550, callout = __handleHIDEventFetcherDrain (0x10af13842)}}
            }
            ,
            sources1 = <CFBasicHash 0x60000160fe70 [0x108331ae8]>{type = mutable set, count = 3,
                entries =>
                0 : <CFRunLoopSource 0x600002d5c180 [0x108331ae8]>{signalled = No, valid = Yes, order = 0, context = <CFRunLoopSource MIG Server> {port = 41987, subsystem = 0x10b6b5500, context = 0x60000186c420}}
                1 : <CFRunLoopSource 0x600002d48000 [0x108331ae8]>{signalled = No, valid = Yes, order = -1, context = <CFRunLoopSource context>{version = 1, info = 0x3103, callout = PurpleEventCallback (0x1105b12c7)}}
                2 : <CFRunLoopSource 0x600002d44240 [0x108331ae8]>{signalled = No, valid = Yes, order = 0, context = <CFRunLoopSource MIG Server> {port = 42763, subsystem = 0x10b6ad328, context = 0x0}}
            }
            ,
            observers = (
                         "<CFRunLoopObserver 0x600002940320 [0x108331ae8]>{valid = Yes, activities = 0x1, repeats = Yes, order = -2147483647, callout = _wrapRunLoopWithAutoreleasePoolHandler (0x10ae2887d), context = <CFArray 0x60000161dd70 [0x108331ae8]>{type = mutable-small, count = 1, values = (\n\t0 : <0x7f95bb000058>\n)}}",
                         "<CFRunLoopObserver 0x6000029480a0 [0x108331ae8]>{valid = Yes, activities = 0x20, repeats = Yes, order = 0, callout = _UIGestureRecognizerUpdateObserver (0x10aa0cd19), context = <CFRunLoopObserver context 0x600003348000>}",
                         "<CFRunLoopObserver 0x6000029401e0 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 1999000, callout = _beforeCACommitHandler (0x10ae56245), context = <CFRunLoopObserver context 0x7f95b7e00a90>}",
                         "<CFRunLoopObserver 0x600002944500 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2000000, callout = _ZN2CA11Transaction17observer_callbackEP19__CFRunLoopObservermPv (0x10c825e92), context = <CFRunLoopObserver context 0x0>}",
                         "<CFRunLoopObserver 0x600002940280 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2001000, callout = _afterCACommitHandler (0x10ae562af), context = <CFRunLoopObserver context 0x7f95b7e00a90>}",
                         "<CFRunLoopObserver 0x6000029403c0 [0x108331ae8]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2147483647, callout = _wrapRunLoopWithAutoreleasePoolHandler (0x10ae2887d), context = <CFArray 0x60000161dd70 [0x108331ae8]>{type = mutable-small, count = 1, values = (\n\t0 : <0x7f95bb000058>\n)}}"
                         ),
            timers = <CFArray 0x600003c44d80 [0x108331ae8]>{type = mutable-small, count = 1, values = (
                                                                                                       0 : <CFRunLoopTimer 0x600002d44300 [0x108331ae8]>{valid = Yes, firing = No, interval = 0, tolerance = 0, next fire date = 579681851 (1.43580794 @ 197516002074039), callout = (Delayed Perform) UIApplication _accessibilitySetUpQuickSpeak (0x107064fb3 / 0x10a4e76ea) (/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/UIKitCore.framework/UIKitCore), context = <CFRunLoopTimer context 0x600000d037c0>}
                                                                                                       )},
            currently 579681850 (197514564697873) / soft deadline in: 1.43737614 sec (@ 197516002074039) / hard deadline in: 1.43737611 sec (@ 197516002074039)
        },
        
        5 : <CFRunLoopMode 0x6000023440d0 [0x108331ae8]>{name = kCFRunLoopCommonModes, port set = 0x3f0b, queue = 0x600003659e80, source = 0x600003659f80 (not fired), timer port = 0x3b0f,
            sources0 = (null),
            sources1 = (null),
            observers = (null),
            timers = (null),
            currently 579681850 (197514566301932) / soft deadline in: 1.84465466e+10 sec (@ -1) / hard deadline in: 1.84465466e+10 sec (@ -1)
        },
        
    }
    }

#endif
