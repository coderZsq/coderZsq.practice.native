//
//  SMCallTrace.m
//  01-启动优化
//
//  Created by 朱双泉 on 2020/9/30.
//

#import "SMCallTrace.h"
#import "SMCallTraceCore.h"
#include <objc/runtime.h>
#import "SMCallTraceModel.h"


@implementation SMCallTrace

#pragma mark - Trace
#pragma mark - OC Interface
+ (void)start {
    SMCallTraceStart();
}
+ (void)startWithMaxDepth:(int)depth {
    SMCallConfigMaxDepth(depth);
    [SMCallTrace start];
}
+ (void)startWithMinCost:(double)ms {
    SMCallConfigMinTime(ms * 1000);
    [SMCallTrace start];
}
+ (void)startWithMaxDepth:(int)depth minCost:(double)ms {
    SMCallConfigMaxDepth(depth);
    SMCallConfigMinTime(ms * 1000);
    [SMCallTrace start];
}
+ (void)stop {
    SMCallTraceStop();
}
+ (void)save {
    NSMutableString *mStr = [NSMutableString new];
    NSArray<SMCallTraceModel *> *arr = [self loadRecords];
    for (SMCallTraceModel *model in arr) {
        //记录方法路径
        model.path = [NSString stringWithFormat:@"[%@ %@]",model.className,model.methodName];
        [self appendRecord:model to:mStr];
    }
    NSLog(@"%@",mStr);
}
+ (void)stopSaveAndClean {
    [SMCallTrace stop];
    [SMCallTrace save];
    SMClearCallRecords();
}
+ (void)appendRecord:(SMCallTraceModel *)cost to:(NSMutableString *)mStr {
    [mStr appendFormat:@"\n%@",[cost des]];
    if (cost.subCosts.count < 1) {
        cost.lastCall = YES;
        //记录到数据库中
        //...
    } else {
        for (SMCallTraceModel *model in cost.subCosts) {
            if ([model.className isEqualToString:@"SMCallTrace"]) {
                break;
            }
            //记录方法的子方法的路径
            model.path = [NSString stringWithFormat:@"%@ - [%@ %@]",cost.path,model.className,model.methodName];
            [self appendRecord:model to:mStr];
        }
    }
    
}
+ (NSArray<SMCallTraceModel *>*)loadRecords {
    NSMutableArray<SMCallTraceModel *> *arr = [NSMutableArray new];
    int num = 0;
    SMCallRecord *records = SMGetCallRecords(&num);
    for (int i = 0; i < num; i++) {
        SMCallRecord *rd = &records[i];
        SMCallTraceModel *model = [SMCallTraceModel new];
        model.className = NSStringFromClass(rd->cls);
        model.methodName = NSStringFromSelector(rd->sel);
        model.isClasSMethod = class_isMetaClass(rd->cls);
        model.timeCost = (double)rd->time / 1000000.0;
        model.callDepth = rd->depth;
        [arr addObject:model];
    }
    NSUInteger count = arr.count;
    for (NSUInteger i = 0; i < count; i++) {
        SMCallTraceModel *model = arr[i];
        if (model.callDepth > 0) {
            [arr removeObjectAtIndex:i];
            //Todo:不需要循环，直接设置下一个，然后判断好边界就行
            for (NSUInteger j = i; j < count - 1; j++) {
                //下一个深度小的话就开始将后面的递归的往 sub array 里添加
                if (arr[j].callDepth + 1 == model.callDepth) {
                    NSMutableArray *sub = (NSMutableArray *)arr[j].subCosts;
                    if (!sub) {
                        sub = [NSMutableArray new];
                        arr[j].subCosts = sub;
                    }
                    [sub insertObject:model atIndex:0];
                }
            }
            i--;
            count--;
        }
    }
    return arr;
}


@end
