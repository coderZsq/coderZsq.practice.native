//
//  main.m
//  01-OC对象的本质
//
//  Created by 朱双泉 on 2019/5/5.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

struct NSObject_IMPL {
    Class isa;
};

struct SQPerson_IMPL {
    struct NSObject_IMPL NSOBJECT_IVARS;
    int _age;
    int _height;
    int _no;
};

@interface SQPerson : NSObject
{
    int _age;
    int _height;
    int _no;
}
@end

@implementation SQPerson

@end

// clang -rewrite-objc main.m -o main.cpp
// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m -o main-arm64.cpp
// 什么平台的代码
// 不同平台支持的代码肯定是不一样的
// Windows, Mac, iOS
// 模拟器(i386), 32bit(armv7), 64bit(arm64)
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"%zd", sizeof(struct SQPerson_IMPL));
        SQPerson *p = [[SQPerson alloc] init];
        // 79 15 00 00 01 80 1D 00
        // 00 00 00 00 00 00 00 00
        // 00 00 00 00 00 00 00 00
        // 00 00 00 00 00 00 00 00
        NSLog(@"%zd - %zd", class_getInstanceSize([SQPerson class]), malloc_size((__bridge const void *)p));
    }
    return 0;
}

struct Person_IMPL {
    struct NSObject_IMPL NSObject_IVARS;
    int _age;
    int _height;
};

//struct Person_IMPL {
//    struct NSObject_IMPL NSObject_IVARS; // 8
//    int _age; // 4
//}; // 16 内存对齐: 结构体的大小必须是最大成员大小的倍数

struct Student_IMPL {
    struct Person_IMPL Person_IVARS;
    int _no;
};

// Person
@interface Person : NSObject
{
    int _age;
}
@property (nonatomic, assign) int height;
@end

@implementation Person

@end

// Student
@interface Student : Person
{
    int _no;
}
@end

@implementation Student

@end

void _Person() {
    Student *stu = [[Student alloc] init];
    NSLog(@"stu - %zd", class_getInstanceSize([Student class]));
    NSLog(@"stu - %zd", malloc_size((__bridge const void *)stu));
    
    Person *person = [[Person alloc] init];
    [person setHeight:10];
    [person height];
    NSLog(@"person - %zd", class_getInstanceSize([Person class]));
    NSLog(@"person - %zd", malloc_size((__bridge const void *)person));
}

struct Student1_IMPL {
    struct NSObject_IMPL NSObject_IVARS;
    int _no;
    int _age;
};

@interface Student1 : NSObject
{
@public
    int _no;
    int _age;
}
@end

@implementation Student1

@end

void _Student() {
    Student1 *stu = [[Student1 alloc] init];
    stu->_no = 4;
    stu->_age = 5;

    // D1 11 00 00 01 80 1D 00
    // 04 00 00 00 05 00 00 00
    NSLog(@"%zd", class_getInstanceSize([Student1 class]));
    NSLog(@"%zd", malloc_size((__bridge const void *)stu));

    struct Student1_IMPL *stuImpl = (__bridge struct Student1_IMPL *)stu;
    NSLog(@"no is %d, age is %d", stuImpl->_no, stuImpl->_age);
}

// NSObject 定义
//@interface NSObject {
//    Class isa;
//}
// NSObject Implementation
//struct NSObject_IMPL {
//    Class isa; // 8个字节
//};
// 指针
//typedef struct objc_class *Class;

void _NSObject() {
    /*
     一个NSObject对象占用多少内存
     系统分配了16个字节给NSObject对象 (通过malloc_size函数获得)
     但NSObject对象内部只使用了8个字节的空间 (64bit环境下, 可以通过class_getInstanceSize函数获得)
     */
    NSObject *obj = [[NSObject alloc] init];
    // 41 F1 12 AF FF FF 1D 00
    // 00 00 00 00 00 00 00 00
    /*
     (lldb) p obj
     (NSObject *) $0 = 0x0000000100711c40
     (lldb) po obj
     <NSObject: 0x100711c40>
     
     (lldb) memory read 0x100711c40
     0x100711c40: 41 f1 12 af ff ff 1d 00 00 00 00 00 00 00 00 00  A...............
     0x100711c50: 20 1d 71 00 01 00 00 00 60 1f 71 00 01 00 00 00   .q.....`.q.....
     (lldb) x 0x100711c40
     0x100711c40: 41 f1 12 af ff ff 1d 00 00 00 00 00 00 00 00 00  A...............
     0x100711c50: 20 1d 71 00 01 00 00 00 60 1f 71 00 01 00 00 00   .q.....`.q.....
     (lldb) x/3xg 0x100711c40
     0x100711c40: 0x001dffffaf12f141 0x0000000000000000
     0x100711c50: 0x0000000100711d20
     (lldb) x/4xg 0x100711c40
     0x100711c40: 0x001dffffaf12f141 0x0000000000000000
     0x100711c50: 0x0000000100711d20 0x0000000100711f60
     (lldb) x/4xw 0x100711c40
     0x100711c40: 0xaf12f141 0x001dffff 0x00000000 0x00000000
     (lldb) x/4dw 0x100711c40
     0x100711c40: -1357713087
     0x100711c44: 1966079
     0x100711c48: 0
     0x100711c4c: 0
     (lldb) memory write 0x100711c48 9
     (lldb) x 0x100711c40
     0x100711c40: 41 f1 12 af ff ff 1d 00 09 00 00 00 00 00 00 00  A...............
     0x100711c50: 20 1d 71 00 01 00 00 00 60 1f 71 00 01 00 00 00   .q.....`.q.....
     (lldb)
     */
    
    /*
     id
     _objc_rootAllocWithZone(Class cls, malloc_zone_t *zone)
     {
     id obj;
     
     #if __OBJC2__
     // allocWithZone under __OBJC2__ ignores the zone parameter
     (void)zone;
     obj = class_createInstance(cls, 0);
     #else
     if (!zone) {
     obj = class_createInstance(cls, 0);
     }
     else {
     obj = class_createInstanceFromZone(cls, 0, zone);
     }
     #endif
     
     if (slowpath(!obj)) obj = callBadAllocHandler(cls);
     return obj;
     }
     
     id
     class_createInstance(Class cls, size_t extraBytes)
     {
     return _class_createInstanceFromZone(cls, extraBytes, nil);
     }
     
     static __attribute__((always_inline))
     id
     _class_createInstanceFromZone(Class cls, size_t extraBytes, void *zone,
     bool cxxConstruct = true,
     size_t *outAllocatedSize = nil)
     {
     if (!cls) return nil;
     
     assert(cls->isRealized());
     
     // Read class's info bits all at once for performance
     bool hasCxxCtor = cls->hasCxxCtor();
     bool hasCxxDtor = cls->hasCxxDtor();
     bool fast = cls->canAllocNonpointer();
     
     size_t size = cls->instanceSize(extraBytes);
     if (outAllocatedSize) *outAllocatedSize = size;
     
     id obj;
     if (!zone  &&  fast) {
     obj = (id)calloc(1, size);
     if (!obj) return nil;
     obj->initInstanceIsa(cls, hasCxxDtor);
     }
     else {
     if (zone) {
     obj = (id)malloc_zone_calloc ((malloc_zone_t *)zone, 1, size);
     } else {
     obj = (id)calloc(1, size);
     }
     if (!obj) return nil;
     
     // Use raw pointer isa on the assumption that they might be
     // doing something weird with the zone or RR.
     obj->initIsa(cls);
     }
     
     if (cxxConstruct && hasCxxCtor) {
     obj = _objc_constructOrFree(obj, cls);
     }
     
     return obj;
     }
     
     size_t instanceSize(size_t extraBytes) {
     size_t size = alignedInstanceSize() + extraBytes;
     // CF requires all objects be at least 16 bytes.
     if (size < 16) size = 16;
     return size;
     }
     */
    
    // 16个字节
    
    // 获得NSObject类的实例对象的成员变量所占用的大小 >> 8
    NSLog(@"%zd", class_getInstanceSize([NSObject class]));
    /*
     size_t class_getInstanceSize(Class cls)
     {
     if (!cls) return 0;
     return cls->alignedInstanceSize();
     }
     //Class's ivar size rounded up to a pointer-size boundary.
     uint32_t alignedInstanceSize() {
     return word_align(unalignedInstanceSize());
     }
     */
    
    // 获得obj指针所指向内存的大小 >> 16
    NSLog(@"%zd", malloc_size((__bridge const void *)obj));
}
