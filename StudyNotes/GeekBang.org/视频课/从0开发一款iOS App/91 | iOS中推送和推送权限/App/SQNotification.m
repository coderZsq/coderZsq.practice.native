//
//  SQNotification.m
//  App
//
//  Created by 朱双泉 on 2021/1/20.
//

#import "SQNotification.h"
#import <UserNotifications/UserNotifications.h>

@interface SQNotification ()

@end

@implementation SQNotification

+ (SQNotification *)notificationManager {
    static SQNotification *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SQNotification alloc] init];
    });
    return manager;
}

- (void)checkNotificationAuthorization {
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"");
    }];
}

@end
