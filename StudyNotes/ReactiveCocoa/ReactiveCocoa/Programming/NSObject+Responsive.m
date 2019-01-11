//
//  NSObject+Responsive.m
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "NSObject+Responsive.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (Responsive)

- (void)_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    NSString * className = [NSString stringWithFormat:@"NSKVONotifying_%@", NSStringFromClass(self.class)];
    Class cls = objc_allocateClassPair(self.class, className.UTF8String, 0);
    objc_registerClassPair(cls);
    object_setClass(self, NSClassFromString(className));
    objc_setAssociatedObject(self, "observer", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    id o = objc_getAssociatedObject(self, "observer");
    [o observeValueForKeyPath:keyPath ofObject:self change:nil context:context];
}

@end
