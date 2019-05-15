//
//  NSMutableDictionary+Extension.m
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/15.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Extension)

+ (void)load {
    // 类簇: NSString, NSArray, NSDictionary, 真实类型是其他类型
    Class cls = NSClassFromString(@"__NSDictionaryM");
    Method method1 = class_getInstanceMethod(cls, @selector(setObject:forKeyedSubscript:));
    Method method2 = class_getInstanceMethod(cls, @selector(sq_setObject:forKeyedSubscript:));
    method_exchangeImplementations(method1, method2);
    
    Class cls2 = NSClassFromString(@"__NSDictionaryI");
    Method method3 = class_getInstanceMethod(cls2, @selector(objectForKeyedSubscript:));
    Method method4 = class_getInstanceMethod(cls2, @selector(sq_objectForKeyedSubscript:));
    method_exchangeImplementations(method3, method4);
}

- (void)sq_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (key == nil) return;
    [self sq_setObject:obj forKeyedSubscript:key];
}

- (id)sq_objectForKeyedSubscript:(id)key {
    if (!key) return nil;
    return [self sq_objectForKeyedSubscript:key];
}

@end
