//
//  AppDelegate.m
//  App
//
//  Created by 朱双泉 on 2021/1/8.
//

#import "AppDelegate.h"
#import "SQStaticTest.h"
#import <SQFramework/SQFrameworkTest.h>
#include <execinfo.h>
#import "SQLocation.h"
#import "SQNotification.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // static
//    [[SQStaticTest alloc] init];

    // framework
//    [[SQFrameworkTest alloc] init];
    
    // crash
//    [self _caughtException];
//    [@[].mutableCopy addObject:nil];
    
    [[SQLocation locationManager] checkLocationAuthorization];
    [[SQNotification notificationManager] checkNotificationAuthorization];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 100;
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

#pragma mark -

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // SQNotification中实现
    NSLog(@"");
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"");
}

#pragma mark - crash

- (void)_caughtException {
    // NSException
    NSSetUncaughtExceptionHandler(HandleNSException);
    
    // signal
    signal(SIGABRT, SignalExceptionHandler);
    signal(SIGILL, SignalExceptionHandler);
    signal(SIGSEGV, SignalExceptionHandler);
    signal(SIGFPE, SignalExceptionHandler);
    signal(SIGBUS, SignalExceptionHandler);
    signal(SIGPIPE, SignalExceptionHandler);
}

void SignalExceptionHandler(int signal){
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    NSMutableArray *backtrace = [NSMutableArray arrayWithCapacity:frames];
    for (int i = 0; i < frames; i++) {
        [backtrace addObject:[NSString stringWithUTF8String:strs[i]]];
    }
    free(strs);
    //存储crash信息。
}

void HandleNSException(NSException *excetion) {
    __unused NSString *reason = [excetion reason];
    __unused NSString *name = [excetion name];
    // 存储crash信息.
}

@end
