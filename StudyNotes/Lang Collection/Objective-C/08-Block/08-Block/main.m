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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
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
    return 0;
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
