//
//  SQBacktraceLogger.h
//  SQAppFluecyMonitor
//
//  Created by 朱双泉 on 2020/9/25.
//

#import <Foundation/Foundation.h>

/*!
 *  @brief  线程堆栈上下文输出
 */
@interface SQBacktraceLogger : NSObject

+ (NSString *)sq_backtraceOfAllThread;
+ (NSString *)sq_backtraceOfMainThread;
+ (NSString *)sq_backtraceOfCurrentThread;
+ (NSString *)sq_backtraceOfNSThread:(NSThread *)thread;

+ (void)sq_logMain;
+ (void)sq_logCurrent;
+ (void)sq_logAllThread;

@end
