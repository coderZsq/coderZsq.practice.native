//
//  SQFluecyMonitor.h
//  SQFluecyMonitor
//
//  Created by 朱双泉 on 2020/9/25.
//

#import <Foundation/Foundation.h>

#define SHAREDMONITOR [SQFluecyMonitor sharedMonitor]

/*!
 *  @brief  监听UI线程卡顿
 */
@interface SQFluecyMonitor : NSObject

+ (instancetype)sharedMonitor;

- (void)startMonitoring;
- (void)stopMonitoring;

@end
