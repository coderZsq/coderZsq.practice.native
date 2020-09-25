//
//  SQAppFluecyMonitor.h
//  SQAppFluecyMonitor
//
//  Created by 朱双泉 on 2020/9/25.
//

#import <Foundation/Foundation.h>

#define SHAREDMONITOR [SQAppFluecyMonitor sharedMonitor]

/*!
 *  @brief  监听UI线程卡顿
 */
@interface SQAppFluecyMonitor : NSObject

+ (instancetype)sharedMonitor;

- (void)startMonitoring;
- (void)stopMonitoring;

@end
