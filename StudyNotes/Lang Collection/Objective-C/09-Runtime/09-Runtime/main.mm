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
#import "SQStudent.h"
#import "SQCar.h"
#import "NSObject+Json.h"

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
    
    /*
     讲一下OC的消息机制
     OC中的方法调用其实都是转成了objc_msgSend函数的调用, 给receiver(方法调用者)发送了一条消息(selector方法名)
     objc_msgSend底层有3大阶段
     消息发送(当前类, 父类中查找), 动态方法解析, 消息转发
     */
    
    /*
     什么是Runtime? 平时项目中有用过么?
     OC是一门动态性比较强的编程语言, 允许很多操作推迟到程序运行时再进行
     OC的动态性就是由Runtime来支撑和实现的, Runtime是一套C语言的API, 封装了很多动态性相关的函数
     平时编写的OC代码, 底层都是转换成了RuntimeAPI进行调用
     
     具体应用
     利用关联对象 (AssociatedObject) 给分类添加属性
     遍历类的所有成员变量 (修改textfield的占位文字颜色, 字典转模型, 自动归档解档)
     交换方法实现 (交换系统的方法)
     利用消息转发机制解决方法找不到的异常问题
     ...
     */
    
    int main(int argc, char * argv[]) {
        @autoreleasepool {
            SQPerson *person = [[SQPerson alloc] init];
            Method runMethod = class_getInstanceMethod([SQPerson class], @selector(run));
            Method testMethod = class_getInstanceMethod([SQPerson class], @selector(test));
            
            // 如果有方法IMP为空则不交换
            method_exchangeImplementations(runMethod, testMethod);
            
            [person run];

            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        }
    }
    
    void myrun() {
        NSLog(@"----myrun");
    }
    
    void test14() {
        SQPerson *person = [[SQPerson alloc] init];
        //            class_replaceMethod([SQPerson class], @selector(run), (IMP)myrun, "v");
        class_replaceMethod([SQPerson class], @selector(run), imp_implementationWithBlock(^{
            NSLog(@"123123");
        }), "v");
        [person run];
    }
    
    void test13() {
        // 字典转模型
        NSDictionary *json = @{
                               @"age": @20,
                               @"height": @60,
                               @"name": @"Castie!",
                               @"no": @30
                               };
        SQPerson *person = [SQPerson sq_objectWithJson:json];
        //            [SQCar sq_objectWithJson:json];
        
        //            SQPerson *person = [[SQPerson alloc] init];
        //            person.age = [json[@"age"] intValue];
        //            person.height = [json[@"height"] intValue];
        //            person.name = json[@"name"];
        
        //            SQStudent *student = [SQStudent sq_objectWithJson:json];
    }
    
    void test12() {
        // 获取成员变量信息
        Ivar ageIvar = class_getInstanceVariable([SQPerson class], "_age");
        NSLog(@"%s %s", ivar_getName(ageIvar), ivar_getTypeEncoding(ageIvar));
        
        // 设置和获取成员变量的值
        Ivar nameIvar = class_getInstanceVariable([SQPerson class], "_name");
        SQPerson *person = [[SQPerson alloc] init];
        object_setIvar(person, nameIvar, @"123");
        //            object_getIvar(person, nameIvar);
        NSLog(@"%@", person.name);
        object_setIvar(person, ageIvar, (__bridge id)(void *)10);
        NSLog(@"%d", person.age);
        
        // 成员变量的数量
        unsigned int count;
        Ivar *ivars = class_copyIvarList([SQPerson class], &count);
        for (int i = 0; i < count; i++) {
            // 取出i位置的成员变量
            Ivar ivar = ivars[i];
            NSLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
        }
        free(ivars);
    }
    
    void run(id self, SEL _cmd) {
        NSLog(@"%@ - %@", self, NSStringFromSelector(_cmd));
    }
    
    void test11() {
        // 创建类
        Class newClass = objc_allocateClassPair([NSObject class], "SQDog", 0);
        class_addIvar(newClass, "_age", 4, 1, @encode(int));
        class_addIvar(newClass, "_weight", 4, 1, @encode(int));
        class_addMethod(newClass, @selector(run), (IMP)run, "v@:");
        // 注册类
        objc_registerClassPair(newClass);
        
        id dog = [[newClass alloc] init];
        [dog setValue:@10 forKey:@"_age"];
        [dog setValue:@20 forKey:@"_weight"];
        [dog run];
        
        NSLog(@"%zd", class_getInstanceSize(newClass));
        NSLog(@"%@ %@", [dog valueForKey:@"_age"], [dog valueForKey:@"_weight"]);
        
        SQPerson *person = [[SQPerson alloc] init];
        object_setClass(person, newClass);
        [person run];
        
        // 在不需要这个类时释放
        objc_disposeClassPair(newClass);
    }
    
    void test10() {
        SQPerson *person = [[SQPerson alloc] init];
        [person run];
        
        NSLog(@"%p %p", object_getClass(person), [SQPerson class]);
        
        object_setClass(person, [SQCar class]);
        [person run];
        
        NSLog(@"%d %d %d", object_isClass(person), object_isClass([SQPerson class]), object_isClass(object_getClass([SQPerson class])));
    }
    
    // 局部变量分配在栈空间
    // 栈空间分配, 从高地址到低地址
    void test9_test() {
        long long a = 4; //0x7ffeeb4d6e38
        long long b = 5; //0x7ffeeb4d6e30
        long long c = 6; //0x7ffeeb4d6e28
        long long d = 7; //0x7ffeeb4d6e20
        
        NSLog(@"%p %p %p %p", &a, &b, &c, &d);
    }
    
    void test9() {
        test9_test();
    }
    
#if 0
    @implementation NSObject
    + (BOOL)isMemberOfClass:(Class)cls {
        return object_getClass((id)self) == cls;
    }
    
    - (BOOL)isMemberOfClass:(Class)cls {
        return [self class] == cls;
    }
    
    + (BOOL)isKindOfClass:(Class)cls {
        for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->superclass) {
            if (tcls == cls) return YES;
        }
        return NO;
    }
    
    - (BOOL)isKindOfClass:(Class)cls {
        for (Class tcls = [self class]; tcls; tcls = tcls->superclass) {
            if (tcls == cls) return YES;
        }
        return NO;
    }
    @end
#endif
    void test(id obj) {
        if ([obj isMemberOfClass:[SQPerson class]]) {
            
        }
    }
    
    void test8() {
        NSLog(@"%d", [[NSObject class] isKindOfClass:[NSObject class]]);
        NSLog(@"%d", [[NSObject class] isMemberOfClass:[NSObject class]]);
        NSLog(@"%d", [[SQPerson class] isKindOfClass:[SQPerson class]]);
        NSLog(@"%d", [[SQPerson class] isMemberOfClass:[SQPerson class]]);
        
        // 这句代码的方法调用者不管是哪个类(只要是NSObject体系下的), 都返回YES
        NSLog(@"%d", [NSObject isKindOfClass:[NSObject class]]); //1
        NSLog(@"%d", [NSObject isMemberOfClass:[NSObject class]]); //0
        NSLog(@"%d", [SQPerson isKindOfClass:[SQPerson class]]); //0
        NSLog(@"%d", [SQPerson isMemberOfClass:[SQPerson class]]); //0
        
        test([[SQPerson alloc] init]);
        
        id person = [[SQPerson alloc] init];
        NSLog(@"%d", [person isMemberOfClass:[SQPerson class]]);
        NSLog(@"%d", [person isMemberOfClass:[NSObject class]]);
        
        NSLog(@"%d", [person isKindOfClass:[SQPerson class]]);
        NSLog(@"%d", [person isKindOfClass:[NSObject class]]);
        
        NSLog(@"%d", [SQPerson isMemberOfClass:object_getClass([SQPerson class])]);
        NSLog(@"%d", [SQPerson isKindOfClass:object_getClass([NSObject class])]);
        
        NSLog(@"%d", [SQPerson isKindOfClass:[NSObject class]]);
    }
    
    void test(SEL selector) {
        SQPerson * person = [[SQPerson alloc] init];
        if ([person respondsToSelector:selector]) {
            [person performSelector:selector];
        }
    }
    
    void test(NSMutableArray *array) {
        [array addObject:@"123"];
    }
    
    // 降低unrecognized selector崩溃率
    void test7() {
        SQStudent *student = [[SQStudent alloc] init];
        SQPerson *person = [[SQPerson alloc] init];
        [person run];
        [person test];
        [person other];
    }
    
    // 消息转发: 将消息转发给别人
    void test6() {
        SQPerson *person = [[SQPerson alloc] init];
        [person test];
        [SQPerson test];
        
        [person test:15];
        [person test2:15];
        
        person.age = 20;
        NSLog(@"%d", person.age);
    }
    
    void objc_msgSend(id receiver, SEL selector) {
        if (receiver == nil) return;
        
        // 查找缓存
    }
    
    void test5() {
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
        
        //        [person test];
        //        objc_msgSend如果找不到合适的方法进行调用, 会报错
        //        '-[SQPerson test]: unrecognized selector sent to instance 0x6000033ac270'
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
        }*/
        
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
