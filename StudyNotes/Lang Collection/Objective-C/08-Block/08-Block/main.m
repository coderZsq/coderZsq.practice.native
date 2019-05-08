//
//  main.m
//  08-Block
//
//  Created by 朱双泉 on 2019/5/8.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
};

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0* Desc;
    int age;
};

// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m

/*
 一切以运行时的结果为准
 
 clang c++
 
 llvm x.0 中间文件
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
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
    return 0;
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

void (^block)(void);

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
    void (*block)(void) = ((void (*)())
                           &__main_block_impl_0((void *)
                                                __main_block_func_0, &__main_block_desc_0_DATA
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
