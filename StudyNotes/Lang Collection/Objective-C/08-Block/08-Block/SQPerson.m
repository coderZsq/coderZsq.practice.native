//
//  SQPerson.m
//  08-Block
//
//  Created by 朱双泉 on 2019/5/8.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson.h"

// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc SQPerson.m

@implementation SQPerson

- (void)test {
    void (^block)(void) = ^{
        NSLog(@"--------%d", _name);
    };
    block();
    
#if 0
    static void __SQPerson__test_block_func_0(struct __SQPerson__test_block_impl_0 *__cself) {
        SQPerson *self = __cself->self; // bound by copy
        
        NSLog((NSString *)&__NSConstantStringImpl__var_folders_dr_q415vqjx46n40jw2m8htjfgm0000gn_T_SQPerson_ded891_mi_0, (*(NSString * _Nonnull *)((char *)self + OBJC_IVAR_$_SQPerson$_name)));
    }
#endif
    
//    void (^block)(void) = ^{
//        NSLog(@"--------%p", self);
//    };
//    block();
    
#if 0
    struct __SQPerson__test_block_impl_0 {
        struct __block_impl impl;
        struct __SQPerson__test_block_desc_0* Desc;
        SQPerson *self;
        __SQPerson__test_block_impl_0(void *fp, struct __SQPerson__test_block_desc_0 *desc, SQPerson *_self, int flags=0) : self(_self) {
            impl.isa = &_NSConcreteStackBlock;
            impl.Flags = flags;
            impl.FuncPtr = fp;
            Desc = desc;
        }
    };
#endif
}

#if 0
static void _I_SQPerson_test(SQPerson * self, SEL _cmd) {
    void (*block)(void) = ((void (*)())&__SQPerson__test_block_impl_0((void *)__SQPerson__test_block_func_0, &__SQPerson__test_block_desc_0_DATA, self, 570425344));
    ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
}
#endif

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;
    }
    return self;
}

#if 0
static instancetype _Nonnull _I_SQPerson_initWithName_(SQPerson * self, SEL _cmd, NSString * _Nonnull name) {
    if (self = ((SQPerson *(*)(__rw_objc_super *, SEL))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("SQPerson"))}, sel_registerName("init"))) {
        ((void (*)(id, SEL, NSString * _Nonnull))(void *)objc_msgSend)((id)self, sel_registerName("setName:"), (NSString * _Nonnull)name);
    }
    return self;
}
#endif

@end
