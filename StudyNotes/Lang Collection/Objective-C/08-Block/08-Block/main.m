//
//  main.m
//  08-Block
//
//  Created by 朱双泉 on 2019/5/9.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SQPerson.h"

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
    void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
    void (*dispose)(struct __main_block_impl_0*);
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    int age;
};


// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m
// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-12.0.0 main.m

/*
 一切以运行时的结果为准
 
 clang c++
 
 llvm x.0 中间文件
 */

typedef void (^SQBlock)(void);

int main(int argc, char * argv[]) {
    @autoreleasepool {

        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

void test12() {
    __block auto int age = 10;
#if 0
    struct __Block_byref_age_0 {
        void *__isa;
        __Block_byref_age_0 *__forwarding;
        int __flags;
        int __size;
        int age; // 10
    };
    
    __attribute__((__blocks__(byref))) auto __Block_byref_age_0 age = {
        (void*)0,
        (__Block_byref_age_0 *)&age,
        0,
        sizeof(__Block_byref_age_0),
        10};
#endif
    __block NSObject *obj = [[NSObject alloc] init];
#if 0
    struct __Block_byref_obj_1 {
        void *__isa;
        __Block_byref_obj_1 *__forwarding;
        int __flags;
        int __size;
        void (*__Block_byref_id_object_copy)(void*, void*);
        void (*__Block_byref_id_object_dispose)(void*);
        NSObject *__strong obj;
    };
    
    __attribute__((__blocks__(byref))) __Block_byref_obj_1 obj = {
        (void*)0,
        (__Block_byref_obj_1 *)&obj,
        33554432,
        sizeof(__Block_byref_obj_1),
        __Block_byref_id_object_copy_131,
        __Block_byref_id_object_dispose_131,
        ((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)((NSObject *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("NSObject"), sel_registerName("alloc")), sel_registerName("init"))};
#endif
    
    NSMutableArray * array = [NSMutableArray array];
    
    SQBlock block = ^{
        [array addObject:@"123"];
        [array addObject:@"123"];
        
        obj = nil;
        age = 20;
        NSLog(@"age is %d", age);
    };
    
#if 0
    struct __main_block_impl_0 {
        struct __block_impl impl;
        struct __main_block_desc_0* Desc;
        __Block_byref_obj_1 *obj; // by ref
        __Block_byref_age_0 *age; // by ref
        __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_obj_1 *_obj, __Block_byref_age_0 *_age, int flags=0) : obj(_obj->__forwarding), age(_age->__forwarding) {
            impl.isa = &_NSConcreteStackBlock;
            impl.Flags = flags;
            impl.FuncPtr = fp;
            Desc = desc;
        }
    };
#endif
    
    block();
#if 0
    static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
        __Block_byref_obj_1 *obj = __cself->obj; // bound by ref
        __Block_byref_age_0 *age = __cself->age; // bound by ref
        
        (obj->__forwarding->obj) = __null;
        (age->__forwarding->age) = 20;
        NSLog((NSString *)&__NSConstantStringImpl__var_folders_dr_q415vqjx46n40jw2m8htjfgm0000gn_T_main_216ef0_mi_0, (age->__forwarding->age));
    }
#endif
}

void test11() {
    // ARC
    SQBlock block;
    {
        __strong SQPerson *person = [[SQPerson alloc] init];
        person.age = 10;
        
        __weak SQPerson *weakPerson = person;
        block = ^{
            NSLog(@"----------%d", weakPerson.age);
        };
    }
    block();
    NSLog(@"-----------");
    
#if 0
    struct __main_block_impl_0 {
        struct __block_impl impl;
        struct __main_block_desc_0* Desc;
        SQPerson *__weak weakPerson;
        __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, SQPerson *__weak _weakPerson, int flags=0) : weakPerson(_weakPerson) {
            impl.isa = &_NSConcreteStackBlock;
            impl.Flags = flags;
            impl.FuncPtr = fp;
            Desc = desc;
        }
    };
    
    static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->weakPerson, (void*)src->weakPerson, 3/*BLOCK_FIELD_IS_OBJECT*/);}
    
    static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->weakPerson, 3/*BLOCK_FIELD_IS_OBJECT*/);}
#endif
    
#if 0
    // MRC
    SQBlock block;
    {
        SQPerson *person = [[SQPerson alloc] init];
        person.age = 10;
        block = [^{
            //                [person retain];
            NSLog(@"----------%d", person.age);
            //                [person release];
        } copy];
        [person release];
    }
    NSLog(@"-----------");
    
    SQPerson *person = [[SQPerson alloc] init];
    person.age = 10;
    SQBlock block = ^{
        NSLog(@"----------%d", person.age);
    };
#endif
    
#if 0
    struct __main_block_impl_0 {
        struct __block_impl impl;
        struct __main_block_desc_0* Desc;
        SQPerson *person;
        __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, SQPerson *_person, int flags=0) : person(_person) {
            impl.isa = &_NSConcreteStackBlock;
            impl.Flags = flags;
            impl.FuncPtr = fp;
            Desc = desc;
        }
    };
#endif
}

SQBlock myblock() {
    // ARC
    int age = 10;
    SQBlock block = ^{
        NSLog(@"----------%d", age);
    };
    return block; // [block copy]
}

void test10() {
    int age = 10;
    NSLog(@"%@", [^{
        NSLog(@"------------%d", age);
    } class]);
    
    // ARC block copy
    
    NSArray *array = @[];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    
    SQBlock mblock1 = ^{
        NSLog(@"----------%d", age);
    };
    NSLog(@"%@", [mblock1 class]);
    
    SQBlock mblock2 = myblock();
    mblock2();
    NSLog(@"%@", [mblock2 class]);
}

int g_a = 10;

void test9() {
    int a = 10;
    
    NSLog(@"数据段 g_a %p", &g_a);
    NSLog(@"栈 a %p", &a);
    NSLog(@"堆 obj %p", [[NSObject alloc] init]);
    NSLog(@"数据段 class %p", [SQPerson class]);
    //        g_a 0x100002628
    //        a 0x7ffeefbff55c
    //        obj 0x100a25f20
    //        class 0x1000025d8
    
    //        SQPerson *p = [[SQPerson alloc] init];
    //        p.block = ^{
    //
    //        };
}

// automatic reference count = NO

void (^block)(void);
void test8_test() {
    // NSStackBlock
    int age = 10;
    block = [^{
        NSLog(@"block-----------%d", age);
    } copy]; // copy NSMallocBlock
    //    [block release]; MRC
#if 0
    struct __test8_test_block_impl_0 {
        struct __block_impl impl;
        struct __test8_test_block_desc_0* Desc;
        int age;
        __test8_test_block_impl_0(void *fp, struct __test8_test_block_desc_0 *desc, int _age, int flags=0) : age(_age) {
            impl.isa = &_NSConcreteStackBlock;
            impl.Flags = flags;
            impl.FuncPtr = fp;
            Desc = desc;
        }
    };
#endif
}

#if 0
void test8_test() {
    
    int age = 10;
    block = ((void (*)())&__test8_test_block_impl_0((void *)__test8_test_block_func_0, &__test8_test_block_desc_0_DATA, age));
}
#endif

void test8() {
    test8_test();
    block();
}

int g_age = 10;

void test7() {
    static int s_age = 10;
    int age = 10;
    
    // Global: 没有访问auto变量
    void (^block1)(void) = ^{
        NSLog(@"block1------------%d %d", s_age, g_age);
    };
    
    NSLog(@"%@", [[block1 copy] class]);
    
    // Stack: 访问auto变量
    void (^block2)(void) = ^{
        NSLog(@"block2------------%d", age);
    };
    
    NSLog(@"%@", [[[block2 copy] copy] class]); // copy copy 引用计数+1
    
    NSLog(@"%@ %@", [block1 class], [block2 class]);
}

void test6() {
    // 堆: 动态分配内存, 需要程序员申请, 也需要程序员自己管理内存
    // malloc(20);
    // free();
    // [[NSObject alloc] release];
    
    void (^block1)(void) = ^{
        NSLog(@"Hello");
    };
    
    int age = 10;
    void (^block2)(void) = ^{
        NSLog(@"Hello - %d", age);
    };
    
    NSLog(@"%@ %@ %@", [block1 class], [block2 class], [^{
        NSLog(@"%d", age);
    } class]);
}

void test5() {
    // __NSGlobalBlock__ : __NSGlobalBlock : NSBlock : NSObject
    void (^block)(void) = ^{
        NSLog(@"Hello");
    };
    NSLog(@"%@", [block class]);
    NSLog(@"%@", [[block class] superclass]);
    NSLog(@"%@", [[[block class] superclass] superclass]);
    NSLog(@"%@", [[[[block class] superclass] superclass] superclass]);
    
}

int age_ = 10;
static int height_ = 10;

void test4() {
    void (^block)(void) = ^{
        NSLog(@"age is %d, height is %d", age_, height_);
    };
    
    age_ = 20;
    height_ = 20;
    
    block();
    
#if 0
    int age_ = 10;
    static int height_ = 10;
    
    void (*block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA));
    
    struct __main_block_impl_0 {
        struct __block_impl impl;
        struct __main_block_desc_0* Desc;
        __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int flags=0) {
            impl.isa = &_NSConcreteStackBlock;
            impl.Flags = flags;
            impl.FuncPtr = fp;
            Desc = desc;
        }
    };
    
    age_ = 20;
    height_ = 20;
    
    static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
        
        NSLog((NSString *)&__NSConstantStringImpl__var_folders_dr_q415vqjx46n40jw2m8htjfgm0000gn_T_main_155c09_mi_0, age_, height_);
    }
    
    ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
#endif
}

//void (^block)(void);

void test3_test() {
    int age = 10;
    static int height = 10;
    
    block = ^{
        NSLog(@"age is %d, height is %d", age, height);
    };
    
    age = 20;
    height = 30;
}

void test3() {
    test3_test();
    block();
    
    //        // auto: 自动变量, 离开作用域就销毁
    //        auto int age = 10;
    //        static int height = 10;
    //
    //        void (^block)(void) = ^{
    //            // age的值捕获进来 (capture)
    //            NSLog(@"age is %d, height is %d", age, height);
    //        };
    //
    //        age = 20;
    //        height = 20;
    //
    //        block();
#if 0
    auto int age = 10;
    static int height = 10;
    
    void (*block)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, age, &height));
    
    struct __main_block_impl_0 {
        struct __block_impl impl;
        struct __main_block_desc_0* Desc;
        int age;
        int *height;
        __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _age, int *_height, int flags=0) : age(_age), height(_height) {
            impl.isa = &_NSConcreteStackBlock;
            impl.Flags = flags;
            impl.FuncPtr = fp;
            Desc = desc;
        }
    };
    
    age = 20;
    height = 20;
    
    static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
        int age = __cself->age; // bound by copy
        int *height = __cself->height; // bound by copy
        
        
        NSLog((NSString *)&__NSConstantStringImpl__var_folders_dr_q415vqjx46n40jw2m8htjfgm0000gn_T_main_ead15a_mi_0, age, (*height));
    }
    
    ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
#endif
    
    //        void (^block)(int, int) = ^(int a, int b) {
    //            NSLog(@"Hello, World! - %d %d", a, b);
    //        };
    //
    //        block(10, 20);
    
#if 0
    void (*block)(int, int) = ((void (*)(int, int))&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA));
    
    ((void (*)(__block_impl *, int, int))((__block_impl *)block)->FuncPtr)((__block_impl *)block, 10, 20);
#endif
}

void test2() {
    void (^block)(void) = ^{
        NSLog(@"Hello, World");
    };
    
    block();
#if 0
    // 定义block变量
    void (*block)(void) = ((void (*)())&__main_block_impl_0((void *)
                                                __main_block_func_0,
                                                &__main_block_desc_0_DATA
                                                ));
    
    struct __main_block_impl_0 {
        struct __block_impl impl;
        struct __main_block_desc_0* Desc;
        // 构造函数 (类似于OC的init方法) 返回结构体对象
        __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int flags=0) {
            impl.isa = &_NSConcreteStackBlock;
            impl.Flags = flags;
            impl.FuncPtr = fp;
            Desc = desc;
        }
    };
    
    // 封装了block执行逻辑的函数
    static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
        
        NSLog((NSString *)&__NSConstantStringImpl__var_folders_dr_q415vqjx46n40jw2m8htjfgm0000gn_T_main_a0bb7c_mi_0);
    }
    
    // 执行block内部的代码
    ((void (*)(__block_impl *))((__block_impl *)block)->FuncPtr)((__block_impl *)block);
#endif
}

void test() {
    //        ^{
    //            NSLog(@"this is a block");
    //            NSLog(@"this is a block");
    //            NSLog(@"this is a block");
    //            NSLog(@"this is a block");
    //        }();
    
    int age = 20;
    
    // ->  0x100000ed0 <+32>:  movl   0x20(%rdi), %esi
    void(^block)(int, int) = ^(int a, int b){
        NSLog(@"this is a block! -- %d", age);
        NSLog(@"this is a block!");
        NSLog(@"this is a block!");
        NSLog(@"this is a block!");
    };
    
    struct __main_block_impl_0 *blockStruct = (__bridge struct __main_block_impl_0 *)block;
    // Printing description of blockStruct->impl.FuncPtr:
    // (void *) FuncPtr = 0x0000000100000eb0
    
    block(10, 10);
    
#if 0
    int age = 10;
    
    void(*block)(int, int) = ((void (*)(int, int))&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, age));
    
    ((void (*)(__block_impl *, int, int))((__block_impl *)block)->FuncPtr)((__block_impl *)block, 10, 10);
    
    struct __main_block_impl_0 {
        struct __block_impl impl;
        struct __main_block_desc_0* Desc;
        int age;
        __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _age, int flags=0) : age(_age) {
            impl.isa = &_NSConcreteStackBlock;
            impl.Flags = flags;
            impl.FuncPtr = fp;
            Desc = desc;
        }
    };
    
    struct __block_impl {
        void *isa;
        int Flags;
        int Reserved;
        void *FuncPtr;
    };
    
    static struct __main_block_desc_0 {
        size_t reserved;
        size_t Block_size;
    } __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};
    
    static void __main_block_func_0(struct __main_block_impl_0 *__cself, int a, int b) {
        int age = __cself->age; // bound by copy
        
        NSLog((NSString *)&__NSConstantStringImpl__var_folders_dr_q415vqjx46n40jw2m8htjfgm0000gn_T_main_2dd44b_mi_0, age);
        NSLog((NSString *)&__NSConstantStringImpl__var_folders_dr_q415vqjx46n40jw2m8htjfgm0000gn_T_main_2dd44b_mi_1);
        NSLog((NSString *)&__NSConstantStringImpl__var_folders_dr_q415vqjx46n40jw2m8htjfgm0000gn_T_main_2dd44b_mi_2);
        NSLog((NSString *)&__NSConstantStringImpl__var_folders_dr_q415vqjx46n40jw2m8htjfgm0000gn_T_main_2dd44b_mi_3);
    }
#endif
}
