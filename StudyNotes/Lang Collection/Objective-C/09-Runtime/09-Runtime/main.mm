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
#import "SQClassInfo.h"
#import "SQGoodStudent.h"

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

#if 0
struct class_rw_t {
    // Be warned that Symbolication knows the layout of this structure.
    uint32_t flags;
    uint32_t version;
    
    const class_ro_t *ro;
    
    method_array_t methods;
    property_array_t properties;
    protocol_array_t protocols;
    
    Class firstSubclass;
    Class nextSiblingClass;
    
    char *demangledName;
    
#if SUPPORT_INDEXED_ISA
    uint32_t index;
#endif
    ...
#endif
    
#if 0
    struct method_t {
        SEL name;
        const char *types;
        IMP imp;
        
        struct SortBySELAddress :
        public std::binary_function<const method_t&,
        const method_t&, bool>
        {
            bool operator() (const method_t& lhs,
                             const method_t& rhs)
            { return lhs.name < rhs.name; }
        };
    };
#endif
    
#if 0
    struct bucket_t {
    private:
        cache_key_t _key; // SEL作为key
        IMP _imp; // 函数的内存地址
        
    public:
        inline cache_key_t key() const { return _key; }
        inline IMP imp() const { return (IMP)_imp; }
        inline void setKey(cache_key_t newKey) { _key = newKey; }
        inline void setImp(IMP newImp) { _imp = newImp; }
        
        void set(cache_key_t newKey, IMP newImp);
    };
    
    struct cache_t {
        struct bucket_t *_buckets; // 散列表
        mask_t _mask; // 散列表的长度 - 1
        mask_t _occupied; // 已经缓存的方法数量
        
    public:
        struct bucket_t *buckets();
        mask_t mask();
        mask_t occupied();
        void incrementOccupied();
        void setBucketsAndMask(struct bucket_t *newBuckets, mask_t newMask);
        void initializeToEmpty();
        
        mask_t capacity();
        bool isConstantEmptyCache();
        bool canBeFreed();
        
        static size_t bytesForCapacity(uint32_t cap);
        static struct bucket_t * endMarker(struct bucket_t *b, uint32_t cap);
        
        void expand();
        void reallocate(mask_t oldCapacity, mask_t newCapacity);
        struct bucket_t * find(cache_key_t key, id receiver);
        
        static void bad_cache(id receiver, SEL sel, Class isa) __attribute__((noreturn));
    };
#endif
    
// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc -fobjc-arc -fobjc-runtime=ios-12.0.0 main.mm
    
int main(int argc, char * argv[]) {
    @autoreleasepool {

        SQPerson *person = [[SQPerson alloc] init];
        [person personTest];
//        NSLog(@"%p %p", sel_registerName("personTest"), @selector(personTest));
//        ((void (*)(id, SEL))(void *)objc_msgSend)((id)person, sel_registerName("personTest"));
        // 消息接受者 (receiver): person
        // 消息名称: personTest
        
        [SQPerson initialize];
//        ((void (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("SQPerson"), sel_registerName("initialize"));
        // 消息接受者 (receiver): [SQPerson class]
        // 消息名称: initialize
        
        // OC的方法调用: 消息机制, 给方法调用者发送消息
        
//        [person abc];
//        objc_msgSend如果找不到合适的方法进行调用, 会报错
//        '-[SQPerson abc]: unrecognized selector sent to instance 0x6000033ac270'
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
    
void test4() {
    //        SQPerson *person = [[SQPerson alloc] init];
    //        sq_objc_class *personClass = (__bridge sq_objc_class *) [SQPerson class];
    //        [person personTest];
    
    SQGoodStudent *goodStudent = [[SQGoodStudent alloc] init];
    sq_objc_class *goodStudentClass = (__bridge sq_objc_class *) [SQGoodStudent class];
    [goodStudent goodStudentTest];
    [goodStudent studentTest];
    [goodStudent personTest];
    [goodStudent goodStudentTest];
    [goodStudent studentTest];
    
    NSLog(@"---------------------------------");
    
    cache_t cache = goodStudentClass->cache;
    NSLog(@"%s %p", @selector(personTest), cache.imp(@selector(personTest)));
    NSLog(@"%s %p", @selector(studentTest), cache.imp(@selector(studentTest)));
    NSLog(@"%s %p", @selector(goodStudentTest), cache.imp(@selector(goodStudentTest)));
    /*
     (lldb) p (IMP)0x101a1f6c0
     (IMP) $0 = 0x0000000101a1f6c0 (09-Runtime`-[SQPerson personTest] at SQPerson.m:75)
     (lldb) p (IMP)0x101a20690
     (IMP) $1 = 0x0000000101a20690 (09-Runtime`-[SQStudent studentTest] at SQStudent.m:13)
     (lldb) p (IMP)0x101a1f9e0
     (IMP) $2 = 0x0000000101a1f9e0 (09-Runtime`-[SQGoodStudent goodStudentTest] at SQGoodStudent.m:13)
     */
    
    bucket_t *buckets = cache._buckets;
    bucket_t bucket = buckets[(long long)@selector(studentTest) & cache._mask];
    NSLog(@"%s %p", bucket._key, bucket._imp);
    
    for (int i = 0; i <= cache._mask; i++) {
        bucket_t bucket = buckets[i];
        NSLog(@"%s %p", bucket._key, bucket._imp);
    }
}
    
void test3() {
    NSLog(@"%s", @encode(int));
    NSLog(@"%s", @encode(void));
    NSLog(@"%s", @encode(id));
    NSLog(@"%s", @encode(SEL));
    
    SQPerson *person = [[SQPerson alloc] init];
    sq_objc_class *cls = (__bridge sq_objc_class *) [SQPerson class];
    class_rw_t *data = cls->data();
    // v 16 @ 0 : 8
    //        [person test];
    //        Printing description of data->methods->first.types:
    //        (const char *) types = 0x0000000104b78494 "i24@0:8i16f20"
    [person test:10 height:20];
    
    SEL sel1 = sel_registerName("test");
    SEL sel2 = @selector(test);
    
    sel_getName(sel1);
    NSStringFromSelector(sel2);
    
    NSLog(@"%p %p %p", @selector(test), @selector(test), sel1);
}

void test2() {
    SQPerson *person = [[SQPerson alloc] init];
    __weak SQPerson *weakPerson = person;
    weakPerson = nil;
    uintptr_t weakly_referenced = 1;
    
    //        objc_setAssociatedObject(person, @"name", @"Castie!", OBJC_ASSOCIATION_COPY_NONATOMIC);
    //        objc_setAssociatedObject(person, @"name", nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    //        uintptr_t has_assoc = 1;
    
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
//    setOptions(SQOptionOne | SQOptionTwo | SQOptionFour);
//    setOptions(SQOptionOne + SQOptionTwo + SQOptionFour);
    
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
