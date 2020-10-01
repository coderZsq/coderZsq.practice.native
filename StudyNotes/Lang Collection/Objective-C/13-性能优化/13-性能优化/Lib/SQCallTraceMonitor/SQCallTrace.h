//
//  SQCallTrace.h
//  13-性能优化
//
//  Created by 朱双泉 on 2020/9/30.
//

#import <Foundation/Foundation.h>

@interface SQCallTrace : NSObject
+ (void)start; //开始记录
+ (void)startWithMaxDepth:(int)depth;
+ (void)startWithMinCost:(double)ms;
+ (void)startWithMaxDepth:(int)depth minCost:(double)ms;
+ (void)stop;             //停止记录
+ (void)save;             //保存和打印记录，如果不是短时间 stop 的话使用 saveAndClean
+ (void)stopSaveAndClean; //停止保存打印并进行内存清理
//int SMRebindSymbols(struct SMRebinding rebindings[], size_t rebindings_nel);

@end
