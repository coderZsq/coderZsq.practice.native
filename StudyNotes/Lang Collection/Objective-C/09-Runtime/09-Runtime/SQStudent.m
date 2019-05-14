//
//  SQStudent.m
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQStudent.h"
#import <objc/runtime.h>

// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc SQStudent.m

@implementation SQStudent

/*
 [super message]的底层实现
 1.消息接收者仍然是子类对象
 2.从父类开始查找方法的实现
 */

/// Specifies the superclass of an instance.
struct objc_super {
    /// Specifies an instance of a class.
    __unsafe_unretained _Nonnull id receiver; // 消息接受者
    
    /// Specifies the particular superclass of the instance to message.
#if !defined(__cplusplus)  &&  !__OBJC2__
    /* For compatibility with old objc-runtime.h header */
    __unsafe_unretained _Nonnull Class class;
#else
    __unsafe_unretained _Nonnull Class super_class; // 消息接受者的父类
#endif
    /* super_class is the first class to search */
};

- (void)run {
    // super调用的receiver仍然是SQStudent对象
    [super run];
    
//    struct objc_super arg =  {
//        self,
//        class_getSuperclass(objc_getClass("SQStudent")) // [SQPerson class]
//    };
//    objc_msgSendSuper(arg, @selector(run));
//    ((void (*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("SQStudent"))}, sel_registerName("run"));
    NSLog(@"%s", __func__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        objc_msgSend(self, @selector(class))
        NSLog(@"[self class] = %@", [self class]); //SQStudent
        NSLog(@"[self superclass] = %@", [self superclass]); //SQPerson
        
        NSLog(@"--------------------------");
        
//        objc_msgSendSuper({self, [SQPerson class]}, @selector(class))
        NSLog(@"[super class] = %@", [super class]); //SQStudent
        NSLog(@"[super superclass] = %@", [super superclass]); //SQPerson
    }
    return self;
}

- (void)studentTest {
    NSLog(@"%s", __func__);
}

@end

//@implementation NSObject
//
//- (Class)class {
//    return object_getClass(self);
//}
//
//- (Class)superclass {
//    return class_getSuperclass(object_getClass(self));
//}
//
//@end
