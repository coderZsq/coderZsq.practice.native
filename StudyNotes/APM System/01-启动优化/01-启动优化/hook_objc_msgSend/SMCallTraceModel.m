//
//  SMCallTraceModel.m
//  01-启动优化
//
//  Created by 朱双泉 on 2020/9/30.
//

#import "SMCallTraceModel.h"

@implementation SMCallTraceModel

- (NSString *)des {
    NSMutableString *str = [NSMutableString new];
    [str appendFormat:@"%2d| ",(int)_callDepth];
    [str appendFormat:@"%6.2f|",_timeCost * 1000.0];
    for (NSUInteger i = 0; i < _callDepth; i++) {
        [str appendString:@"  "];
    }
    [str appendFormat:@"%s[%@ %@]", (_isClasSMethod ? "+" : "-"), _className, _methodName];
    return str;
}

@end
