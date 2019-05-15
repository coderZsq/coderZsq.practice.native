//
//  UIControl+Extension.m
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/15.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "UIControl+Extension.h"
#import <objc/runtime.h>

@implementation UIControl (Extension) 

+ (void)load {
    // hook 钩子函数
    Method method1 = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method method2 = class_getInstanceMethod(self, @selector(sq_sendAction:to:forEvent:));
    method_exchangeImplementations(method1, method2);
#if 0
    static void flushCaches(Class cls)
    {
        runtimeLock.assertWriting();
        
        mutex_locker_t lock(cacheUpdateLock);
        
        if (cls) {
            foreach_realized_class_and_subclass(cls, ^(Class c){
                cache_erase_nolock(c);
            });
        }
        else {
            foreach_realized_class_and_metaclass(^(Class c){
                cache_erase_nolock(c);
            });
        }
    }

    
    void method_exchangeImplementations(Method m1, Method m2)
    {
        if (!m1  ||  !m2) return;
        
        rwlock_writer_t lock(runtimeLock);
        
        IMP m1_imp = m1->imp;
        m1->imp = m2->imp;
        m2->imp = m1_imp;
        
        
        // RR/AWZ updates are slow because class is unknown
        // Cache updates are slow because class is unknown
        // fixme build list of classes whose Methods are known externally?
        
        flushCaches(nil);
        
        updateCustomRR_AWZ(nil, m1);
        updateCustomRR_AWZ(nil, m2);
    }
#endif
}

- (void)sq_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSLog(@"%@-%@-%@", self, target, NSStringFromSelector(action));
//    [target performSelector:action];
    if ([self isKindOfClass:[UIButton class]]) {
        // 拦截了所有按钮的事件
    }
    [self sq_sendAction:action to:target forEvent:event];
}

@end
