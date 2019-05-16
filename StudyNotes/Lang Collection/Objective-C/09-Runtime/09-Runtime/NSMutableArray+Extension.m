//
//  NSMutableArray+Extension.m
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/15.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 类簇: NSString, NSArray, NSDictionary, 真实类型是其他类型
        Class cls = NSClassFromString(@"__NSArrayM");
        Method method1 = class_getInstanceMethod(cls, @selector(insertObject:atIndex:));
        Method method2 = class_getInstanceMethod(cls, @selector(sq_insertObject:atIndex:));
        method_exchangeImplementations(method1, method2);
    });
}

- (void)sq_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject == nil) return;
    [self sq_insertObject:anObject atIndex:index];
}

@end
