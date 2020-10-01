//
//  SQCallTrace.m
//  13-性能优化
//
//  Created by 朱双泉 on 2020/9/30.
//

#import "SQCallTrace.h"
#import "SQCallTraceCore.h"
#include <objc/runtime.h>
#import "SQCallTraceModel.h"


@implementation SQCallTrace

#pragma mark - Trace
#pragma mark - OC Interface
+ (void)start {
    SQCallTraceStart();
}
+ (void)startWithMaxDepth:(int)depth {
    SQCallConfigMaxDepth(depth);
    [SQCallTrace start];
}
+ (void)startWithMinCost:(double)ms {
    SQCallConfigMinTime(ms * 1000);
    [SQCallTrace start];
}
+ (void)startWithMaxDepth:(int)depth minCost:(double)ms {
    SQCallConfigMaxDepth(depth);
    SQCallConfigMinTime(ms * 1000);
    [SQCallTrace start];
}
+ (void)stop {
    SQCallTraceStop();
}
+ (void)save {
    NSMutableString *mStr = [NSMutableString new];
    NSArray<SQCallTraceModel *> *arr = [self loadRecords];
    for (SQCallTraceModel *model in arr) {
        //记录方法路径
        model.path = [NSString stringWithFormat:@"[%@ %@]",model.className,model.methodName];
        [self appendRecord:model to:mStr];
    }
    NSLog(@"%@",mStr);
}
+ (void)stopSaveAndClean {
    [SQCallTrace stop];
    [SQCallTrace save];
    SQClearCallRecords();
}
+ (void)appendRecord:(SQCallTraceModel *)cost to:(NSMutableString *)mStr {
    [mStr appendFormat:@"\n%@",[cost des]];
    if (cost.subCosts.count < 1) {
        cost.lastCall = YES;
        //记录到数据库中
        //...
    } else {
        for (SQCallTraceModel *model in cost.subCosts) {
            if ([model.className isEqualToString:@"SQCallTrace"]) {
                break;
            }
            //记录方法的子方法的路径
            model.path = [NSString stringWithFormat:@"%@ - [%@ %@]",cost.path,model.className,model.methodName];
            [self appendRecord:model to:mStr];
        }
    }
    
}
+ (NSArray<SQCallTraceModel *>*)loadRecords {
    NSMutableArray<SQCallTraceModel *> *arr = [NSMutableArray new];
    int num = 0;
    SQCallRecord *records = SQGetCallRecords(&num);
    for (int i = 0; i < num; i++) {
        SQCallRecord *rd = &records[i];
        SQCallTraceModel *model = [SQCallTraceModel new];
        model.className = NSStringFromClass(rd->cls);
        model.methodName = NSStringFromSelector(rd->sel);
        model.isClasSMethod = class_isMetaClass(rd->cls);
        model.timeCost = (double)rd->time / 1000000.0;
        model.callDepth = rd->depth;
        [arr addObject:model];
    }
    NSUInteger count = arr.count;
    for (NSUInteger i = 0; i < count; i++) {
        SQCallTraceModel *model = arr[i];
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
