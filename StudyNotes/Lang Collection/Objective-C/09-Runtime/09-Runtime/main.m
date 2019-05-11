//
//  main.m
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SQPerson.h"
#import <objc/runtime.h>

// 编写代码 -> 编译链接 -> 运行

// Runtime: 运行时
// 提供了一套C语言API

// Class meta-class的地址值, 最后3位一定是0

#if 0
struct objc_object {
private:
    isa_t isa;
    ...
}

union isa_t
{
    isa_t() { }
    isa_t(uintptr_t value) : bits(value) { }
    
    Class cls;
    uintptr_t bits;
    
    
    // extra_rc must be the MSB-most field (so it matches carry/overflow flags)
    // nonpointer must be the LSB (fixme or get rid of it)
    // shiftcls must occupy the same bits that a real class pointer would
    // bits + RC_ONE is equivalent to extra_rc + 1
    // RC_HALF is the high bit of extra_rc (i.e. half of its range)
    
    // future expansion:
    // uintptr_t fast_rr : 1;     // no r/r overrides
    // uintptr_t lock : 2;        // lock for atomic property, @synch
    // uintptr_t extraBytes : 1;  // allocated with extra bytes
    
    //# if __arm64__
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
        uintptr_t extra_rc          : 19; // 里面存储的值是引用计数器减1
#       define RC_ONE   (1ULL<<45)
#       define RC_HALF  (1ULL<<18)
    };
    
    //# elif __x86_64__
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
    
    ...
};

#endif
int main(int argc, char * argv[]) {
    @autoreleasepool {
        SQPerson *person = [[SQPerson alloc] init];
        __weak SQPerson *weakPerson = person;
        weakPerson = nil;
        uintptr_t weakly_referenced = 1;
        
        objc_setAssociatedObject(person, @"name", @"Castie!", OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(person, @"name", nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
        uintptr_t has_assoc = 1;
        
        /*
        void *objc_destructInstance(id obj)
        {
            if (obj) {
                // Read all of the flags at once for performance.
                bool cxx = obj->hasCxxDtor();
                bool assoc = obj->hasAssociatedObjects();
                
                // This order is important.
                if (cxx) object_cxxDestruct(obj);
                if (assoc) _object_remove_assocations(obj);
                obj->clearDeallocating();
            }
            
            return obj;
        }
         */
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

typedef enum {
    SQOptionNone = 0,     // 0b0000
    SQOptionOne = 1<<0,   // 0b0001
    SQOptionTwo = 1<<2,   // 0b0010
    SQOptionThree = 1<<3, // 0b0100
    SQOptionFour = 1<<4,  // 0b1000
} SQOptions;

//typedef enum {
//    SQOptionOne = 1,   // 0b0001
//    SQOptionTwo = 2,   // 0b0010
//    SQOptionThree = 3, // 0b0100
//    SQOptionFour = 4,  // 0b1000
//} SQOptions;

union Date {
    int year;
    char month;
};

/*
 0b0001
 |0b0010
 |0b1000
 ------
 0b1011
 &0b1000
 ------
 0b1000
 */

void setOptions(SQOptions options) {
    if (options & SQOptionOne) {
        NSLog(@"包含了SQOptionOne");
    }
    if (options & SQOptionTwo) {
        NSLog(@"包含了SQOptionTwo");
    }
    if (options & SQOptionThree) {
        NSLog(@"包含了SQOptionThree");
    }
    if (options & SQOptionFour) {
        NSLog(@"包含了SQOptionFour");
    }
}

void test() {
    setOptions(SQOptionOne | SQOptionTwo | SQOptionFour);
    setOptions(SQOptionOne + SQOptionTwo + SQOptionFour);
    
    union Date date;
    date.year = 2019;
    date.month = 5;
    
    SQPerson *person = [[SQPerson alloc] init];
    person.tall = YES;
    person.rich = YES;
    person.handsome = NO;
    person.thin = NO;
    /*
     (lldb) p/x person->_tallRichHandsome
     ((anonymous struct)) $0 = (tall = 0x01, rich = 0x00, hansome = 0x00)
     (lldb) p/x &(person->_tallRichHandsome)
     ((anonymous struct) *) $0 = 0x0000000101206978
     (lldb) x 0x0000000101206978
     0x101206978: 01 00 00 00 00 00 00 00 50 6a 20 01 01 00 00 00  ........Pj .....
     0x101206988: 90 6c 20 01 01 00 00 00 00 6a 20 01 01 00 00 00  .l ......j .....
     */
    /*
     (lldb) p/x &(person->_tallRichHandsome)
     ((anonymous struct) *) $0 = 0x0000000100632488
     (lldb) x 0x0000000100632488
     0x100632488: 05 00 00 00 00 00 00 00 60 25 63 00 01 00 00 00  ........`%c.....
     0x100632498: a0 27 63 00 01 00 00 00 10 25 63 00 01 00 00 00  .'c......%c.....
     */
    NSLog(@"thin: %d, tall: %d, rich: %d, handsome: %d", person.isThin, person.isTall, person.isRich, person.isHandsome);
    
    NSLog(@"%zd", class_getInstanceSize([SQPerson class]));
}
