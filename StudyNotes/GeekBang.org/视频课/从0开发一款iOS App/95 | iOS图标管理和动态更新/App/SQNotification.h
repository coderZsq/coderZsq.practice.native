//
//  SQNotification.h
//  App
//
//  Created by 朱双泉 on 2021/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// APP 推送管理
@interface SQNotification : NSObject

+ (SQNotification *)notificationManager;

- (void)checkNotificationAuthorization;

@end

NS_ASSUME_NONNULL_END
