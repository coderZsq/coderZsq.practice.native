//
//  main.m
//  03-isa和superclass
//
//  Created by 朱双泉 on 2019/5/5.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "NSObject+Test.h"
#import "SQClassInfo.h"

/*
 对象的isa指针指向哪里?
 instanceu对象的isa指向class对象
 class对象的isa指向meta-class对象
 meta-class对象的isa指向基类的meta-class对象
 */

/*
 OC的类信息存放在哪里?
 对象方法, 属性, 成员变量, 协议信息, 存放在class对象中
 类方法, 存放在meta-class对象中
 成员变量的具体值, 存放在instance对象中
 */

// SQPerson
@interface SQPerson : NSObject<NSCopying>
{
@public
    int _age;
}
@property (nonatomic, assign) int no;
- (void)personInstanceMethod;
+ (void)personClassMethod;

+ (void)test;

@end

@implementation SQPerson
- (void)personInstanceMethod {
    
}
+ (void)personClassMethod {
    
}
- (id)copyWithZone:(NSZone *)zone {
    return nil;
}

//+ (void)test {
//    NSLog(@"+[SQPerson1 test] - %p", self);
//}

@end

// SQStudent
@interface SQStudent : SQPerson<NSCoding>
{
@public
    int _weight;
}
@property (nonatomic, assign) int height;
- (void)studentInstanceMethod;
+ (void)studentClassMethod;
@end

@implementation SQStudent
- (void)studentInstanceMethod {
    
}
+ (void)studentClassMethod {
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return nil;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
}
@end

//struct sq_objc_class {
//    Class isa;
//    Class superclass;
//};

// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m -o main-arm64.cpp
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*
         SQPerson 类对象地址值: 0x00000001000025b0
         isa & ISA_MASK: 0x00000001000025b0
         SQPerson 实例对象的isa: 0x001d8001000025b1
         (lldb) p person->isa
         (Class) $0 = SQPerson
         (lldb) p (long)person->isa
         (long) $1 = 8303516107941297
         (lldb) p/x (long)person->isa
         (long) $2 = 0x001d8001000025b1
         (lldb) p/x personClass
         (Class) $3 = 0x00000001000025b0 SQPerson
         (lldb) p/x 0x001d8001000025b1 & 0x00007ffffffffff8
         (long) $4 = 0x00000001000025b0
         
         # if __arm64__
         #   define ISA_MASK        0x0000000ffffffff8ULL
         #   define ISA_MAGIC_MASK  0x000003f000000001ULL
         #   define ISA_MAGIC_VALUE 0x000001a000000001ULL
         struct {
         uintptr_t nonpointer        : 1;
         uintptr_t has_assoc         : 1;
         uintptr_t has_cxx_dtor      : 1;
         uintptr_t shiftcls          : 33; // MACH_VM_MAX_ADDRESS 0x1000000000
         uintptr_t magic             : 6;
         uintptr_t weakly_referenced : 1;
         uintptr_t deallocating      : 1;
         uintptr_t has_sidetable_rc  : 1;
         uintptr_t extra_rc          : 19;
         #       define RC_ONE   (1ULL<<45)
         #       define RC_HALF  (1ULL<<18)
         };
         
         # elif __x86_64__
         #   define ISA_MASK        0x00007ffffffffff8ULL
         #   define ISA_MAGIC_MASK  0x001f800000000001ULL
         #   define ISA_MAGIC_VALUE 0x001d800000000001ULL
         struct {
         uintptr_t nonpointer        : 1;
         uintptr_t has_assoc         : 1;
         uintptr_t has_cxx_dtor      : 1;
         uintptr_t shiftcls          : 44; // MACH_VM_MAX_ADDRESS 0x7fffffe00000
         uintptr_t magic             : 6;
         uintptr_t weakly_referenced : 1;
         uintptr_t deallocating      : 1;
         uintptr_t has_sidetable_rc  : 1;
         uintptr_t extra_rc          : 8;
         #       define RC_ONE   (1ULL<<56)
         #       define RC_HALF  (1ULL<<7)
         };
         
         # else
         #   error unknown architecture for packed isa
         # endif
         
         // SUPPORT_PACKED_ISA
         #endif
         */
        SQPerson *person = [[SQPerson alloc] init];
        
        struct sq_objc_class *personClass = (__bridge struct sq_objc_class *)([SQPerson class]);
        /*
         (lldb) p/x personClass->isa
         (Class) $0 = 0x001d800100002589
         (lldb) p/x personMetaClass
         (Class) $1 = 0x0000000100002588
         (lldb) p/x 0x001d800100002589 & 0x00007ffffffffff8
         (long) $2 = 0x0000000100002588
         */
        struct sq_objc_class *studentClass = (__bridge struct sq_objc_class *)([SQStudent class]);
        /*
         (lldb) p/x studentClass->superclass
         (Class) $1 = 0x00000001000025b0 SQPerson
         */
        class_rw_t *personClassData = personClass->data();
        class_rw_t *studentClassData = studentClass->data();
        
        class_rw_t *personMetaClassData = personClass->metaClass()->data();
        class_rw_t *studentMetaClassData = studentClass->metaClass()->data();
        
        Class personMetaClass = object_getClass((__bridge id _Nullable)(personClass));
        
        NSLog(@"%p %p %p", person, personClass, personMetaClass);
        
    }
    return 0;
}

void test2() {
    NSLog(@"[SQPerson class] - %p", [SQPerson class]);
    NSLog(@"[NSObject class] - %p", [NSObject class]);
    
    [SQPerson test];
    // objc_msgSend([SQPerson class], @selector(personInstanceMethod))
    
    // isa -> superclass -> superclass -> superclass -> .... superclass == nil
    
    [NSObject test];
    // objc_msgSend([NSObject class], @selector(personInstanceMethod))
}

void test1() {
    SQStudent *student = [[SQStudent alloc] init];
    [student studentInstanceMethod];
    [student personInstanceMethod];
    [student init];
    
    [SQStudent studentClassMethod];
    [SQStudent personClassMethod];
    [SQStudent load];
    
    SQPerson *person = [[SQPerson alloc] init];
    person->_age = 10;
    [person personInstanceMethod];
    // objc_msgSend(person, @selector(personInstanceMethod))
    // ((void (*)(id, SEL))(void *)objc_msgSend)((id)person, sel_registerName("personInstanceMethod"));
    [SQPerson personClassMethod];
    // objc_msgSend([SQPerson class], @selector(personInstanceMethod))
    
    Class personClass = [SQPerson class];
    
    Class personMetaClass = object_getClass(personClass);
    
    NSLog(@"%p %p %p", person, personClass, personMetaClass);
}
