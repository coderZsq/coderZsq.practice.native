//
//  SQAppFluecyMonitor.m
//  SQAppFluecyMonitor
//
//  Created by 朱双泉 on 2020/9/25.
//

#import "SQAppFluecyMonitor.h"
#import "SQBacktraceLogger.h"


#define SQ_DEPRECATED_POLLUTE_MAIN_QUEUE


@interface SQAppFluecyMonitor ()

@property (nonatomic, assign) int timeOut;
@property (nonatomic, assign) BOOL isMonitoring;

@property (nonatomic, assign) CFRunLoopObserverRef observer;
@property (nonatomic, assign) CFRunLoopActivity currentActivity;

@property (nonatomic, strong) dispatch_semaphore_t semphore;
@property (nonatomic, strong) dispatch_semaphore_t eventSemphore;

@end


#define SQ_SEMPHORE_SUCCESS 0
static NSTimeInterval sq_restore_interval = 5;
static NSTimeInterval sq_time_out_interval = 1;
static int64_t sq_wait_interval = 200 * NSEC_PER_MSEC;


/*!
 *  @brief  监听runloop状态为before waiting状态下是否卡顿
 */
static inline dispatch_queue_t sq_event_monitor_queue() {
    static dispatch_queue_t sq_event_monitor_queue;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sq_event_monitor_queue = dispatch_queue_create("com.sindrilin.sq_event_monitor_queue", NULL);
    });
    return sq_event_monitor_queue;
}

/*!
 *  @brief  监听runloop状态在after waiting和before sources之间
 */
static inline dispatch_queue_t sq_fluecy_monitor_queue() {
    static dispatch_queue_t sq_fluecy_monitor_queue;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sq_fluecy_monitor_queue = dispatch_queue_create("com.sindrilin.sq_monitor_queue", NULL);
    });
    return sq_fluecy_monitor_queue;
}

#define LOG_RUNLOOP_ACTIVITY 0
static void SQRunLoopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void * info) {
    SHAREDMONITOR.currentActivity = activity;
    dispatch_semaphore_signal(SHAREDMONITOR.semphore);
#if LOG_RUNLOOP_ACTIVITY
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"runloop entry");
            break;
            
        case kCFRunLoopExit:
            NSLog(@"runloop exit");
            break;
            
        case kCFRunLoopAfterWaiting:
            NSLog(@"runloop after waiting");
            break;
            
        case kCFRunLoopBeforeTimers:
            NSLog(@"runloop before timers");
            break;
            
        case kCFRunLoopBeforeSources:
            NSLog(@"runloop before sources");
            break;
            
        case kCFRunLoopBeforeWaiting:
            NSLog(@"runloop before waiting");
            break;
            
        default:
            break;
    }
#endif
};




@implementation SQAppFluecyMonitor


#pragma mark - Singleton override
+ (instancetype)sharedMonitor {
    static SQAppFluecyMonitor * sharedMonitor;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedMonitor = [[super allocWithZone: NSDefaultMallocZone()] init];
        [sharedMonitor commonInit];
    });
    return sharedMonitor;
}

+ (instancetype)allocWithZone: (struct _NSZone *)zone {
    return [self sharedMonitor];
}

- (void)dealloc {
    [self stopMonitoring];
}

- (void)commonInit {
    self.semphore = dispatch_semaphore_create(0);
    self.eventSemphore = dispatch_semaphore_create(0);
}


#pragma mark - Public
- (void)startMonitoring {
    if (_isMonitoring) { return; }
    _isMonitoring = YES;
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        NULL,
        NULL
    };
    _observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &SQRunLoopObserverCallback, &context);
    CFRunLoopAddObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    
    dispatch_async(sq_event_monitor_queue(), ^{
        while (SHAREDMONITOR.isMonitoring) {
            if (SHAREDMONITOR.currentActivity == kCFRunLoopBeforeWaiting) {
                __block BOOL timeOut = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    timeOut = NO;
                    dispatch_semaphore_signal(SHAREDMONITOR.eventSemphore);
                });
                [NSThread sleepForTimeInterval: sq_time_out_interval];
                if (timeOut) {
                    [SQBacktraceLogger sq_logMain];
                }
                dispatch_wait(SHAREDMONITOR.eventSemphore, DISPATCH_TIME_FOREVER);
            }
        }
    });
    
    dispatch_async(sq_fluecy_monitor_queue(), ^{
        while (SHAREDMONITOR.isMonitoring) {
            long waitTime = dispatch_semaphore_wait(self.semphore, dispatch_time(DISPATCH_TIME_NOW, sq_wait_interval));
            if (waitTime != SQ_SEMPHORE_SUCCESS) {
                if (!SHAREDMONITOR.observer) {
                    SHAREDMONITOR.timeOut = 0;
                    [SHAREDMONITOR stopMonitoring];
                    continue;
                }
                if (SHAREDMONITOR.currentActivity == kCFRunLoopBeforeSources || SHAREDMONITOR.currentActivity == kCFRunLoopAfterWaiting) {
                    if (++SHAREDMONITOR.timeOut < 5) {
                        continue;
                    }
                    [SQBacktraceLogger sq_logMain];
                    [NSThread sleepForTimeInterval: sq_restore_interval];
                }
            }
            SHAREDMONITOR.timeOut = 0;
        }
    });
}

- (void)stopMonitoring {
    if (!_isMonitoring) { return; }
    _isMonitoring = NO;
    
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    CFRelease(_observer);
    _observer = nil;
}


@end
