//
//  main.m
//  12-内存管理
//
//  Created by 朱双泉 on 2019/5/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SQProxy.h"
#import "SQObject.h"
#import "ViewController.h"
#import "SQPerson.h"

/*
 拷贝的目的: 产生一个副本对象, 跟源对象互不影响
 修改了源对象, 不会影响副本对象
 修改了副本对象, 不会影响源对象
 */

/*
 iOS提供了2个拷贝方法
 1 copy, 不可变拷贝, 产生不可变副本
 2 mutableCopy, 可变拷贝, 产生可变副本
 
 深拷贝和浅拷贝
 1.深拷贝: 内容拷贝, 产生新的对象
 2.浅拷贝: 指针拷贝. 没有产生新的对象
 */

// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc main.m

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

extern void _objc_autoreleasePoolPrint(void);

void test15() {
#if 0
    
#define I386_PGBYTES            4096            /* bytes per 80386 page */
#define PAGE_SIZE               I386_PGBYTES
#define PAGE_MAX_SIZE           PAGE_SIZE
    
    class AutoreleasePoolPage
    {
        // EMPTY_POOL_PLACEHOLDER is stored in TLS when exactly one pool is
        // pushed and it has never contained any objects. This saves memory
        // when the top level (i.e. libdispatch) pushes and pops pools but
        // never uses them.
#   define EMPTY_POOL_PLACEHOLDER ((id*)1)
        
#   define POOL_BOUNDARY nil
        static pthread_key_t const key = AUTORELEASE_POOL_KEY;
        static uint8_t const SCRIBBLE = 0xA3;  // 0xA3A3A3A3 after releasing
        static size_t const SIZE =
#if PROTECT_AUTORELEASEPOOL
        PAGE_MAX_SIZE;  // must be multiple of vm page size
#else
        PAGE_MAX_SIZE;  // size and alignment, power of 2
#endif
        static size_t const COUNT = SIZE / sizeof(id);
        
        magic_t const magic;
        id *next;
        pthread_t const thread;
        AutoreleasePoolPage * const parent;
        AutoreleasePoolPage *child;
        uint32_t const depth;
        uint32_t hiwat;
        
        ...
        
        id * begin() {
            return (id *) ((uint8_t *)this+sizeof(*this));
        }
        
        id * end() {
            return (id *) ((uint8_t *)this+SIZE);
        }
        
        ...
    }
#endif
    
    @autoreleasepool {
        //            atautoreleasepoolobj = objc_autoreleasePoolPush();
        //            atautoreleasepoolobj = 0x1038
        
        for (int i = 0; i < 1000; i++) {
            SQPerson *person = [[[SQPerson alloc] init] autorelease];
        } // 8000个字节
        
        _objc_autoreleasePoolPrint();
        
        //            objc_autoreleasePoolPop(atautoreleasepoolobj);
    }
#if 0
    struct __AtAutoreleasePool {
        __AtAutoreleasePool() {atautoreleasepoolobj = objc_autoreleasePoolPush();}
        ~__AtAutoreleasePool() {objc_autoreleasePoolPop(atautoreleasepoolobj);}
        void * atautoreleasepoolobj;
    };
    
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool;
        SQPerson *person = ((SQPerson *(*)(id, SEL))(void *)objc_msgSend)((id)((SQPerson *(*)(id, SEL))(void *)objc_msgSend)((id)((SQPerson *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("SQPerson"), sel_registerName("alloc")), sel_registerName("init")), sel_registerName("autorelease"));
    }
#endif
    NSLog(@"%s", __func__);
    
}

void test14() {
    SQPerson *p1 = [[SQPerson alloc] init];
    p1.age = 20;
    p1.weight = 50;
    
    SQPerson *p2 = [p1 copy];
    p2.age = 30;
    
    NSLog(@"%@", p1);
    NSLog(@"%@", p2);
    
    [p2 release];
    [p1 release];
}

void test13() {
    SQPerson *p = [[SQPerson alloc] init];
    p.data = [NSMutableArray array];
    
    [p.data addObject:@"jack"];
    [p.data addObject:@"rose"];
    
    NSLog(@"%@", p.data);
    
    [p release];
}

void test12() {
    NSArray *array1 = [[NSArray alloc] initWithObjects:@"a", @"b", nil];
    NSArray *array2 = [array1 copy]; // 浅拷贝
    NSMutableArray *array3 = [array1 mutableCopy]; // 深拷贝
    
    NSLog(@"%p %p %p", array1, array2, array3);
    
    [array1 release];
    [array2 release];
    [array3 release];
}

void test11() {
    NSMutableString *str1 = [[NSMutableString alloc] initWithFormat:@"test"];
    NSString *str2 = [str1 copy]; // 深拷贝
    NSMutableString *str3 = [str1 mutableCopy]; // 深拷贝
    
    [str1 appendString:@"111"];
    [str3 appendFormat:@"333"];
    
    NSLog(@"%@ %@ %@", str1, str2, str3);
    
    [str1 release];
    [str2 release];
    [str3 release];
}

void test10() {
    NSString *str1 = [[NSString alloc] initWithFormat:@"test1111111111111111"];
    NSString *str2 = [str1 copy]; // 浅拷贝, 指针拷贝, 没有产生新对象
    NSLog(@"%zd", str1.retainCount);
    
    NSMutableString *str3 = [str1 mutableCopy]; // 深拷贝, 内容拷贝, 有产生新对象
    
    NSLog(@"%p %p %p", str1, str2, str3);
    
    [str3 release];
    [str2 release];
    [str1 release];
}

void test9() {
    //        NSString *str1 = [NSString stringWithFormat:@"test"];
    //        NSString *str2 = [str1 copy]; // 返回的是NSString
    //        NSMutableString *str3 = [str1 mutableCopy]; //返回的是NSMutableString
    //
    //        NSLog(@"%@ %@ %@", str1, str2, str3);
    //
    //        [str3 appendString:@"123"];
    //        NSLog(@"%@", str3);
    
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"test"];
    NSString *str2 = [str1 copy];
    NSMutableString *str3 = [str1 mutableCopy];
    
    NSLog(@"%@ %@ %@", str1, str2, str3);
    
    [str3 appendString:@"123"];
    NSLog(@"%@", str3);
}

void test8() {
    @autoreleasepool {
        SQPerson *person = [SQPerson person];
    }
}

void test7() {
    SQDog *dog = [[SQDog alloc] init];
    SQPerson *person = [[SQPerson alloc] init];
    [person setDog:dog];
    
    [dog release];
    
    [person setDog:dog];
    [person setDog:dog];
    
    [person release];
    
}

void test6() {
    SQDog *dog1 = [[SQDog alloc] init];
    SQDog *dog2 = [[SQDog alloc] init];
    
    SQPerson *person = [[SQPerson alloc] init];
    [person setDog:dog1];
    [person setDog:dog2];
    
    [dog1 release];
    [dog2 release];
    [person release];
}

void test5() {
    SQDog *dog = [[SQDog alloc] init];
    SQPerson *person1 = [[SQPerson alloc] init];
    SQPerson *person2 = [[SQPerson alloc] init];
    
    [person1 setDog:dog];
    [person2 setDog:dog];
    
    [dog release];
    
    [[person1 dog] run];
    
    [person1 release];
    
    [[person2 dog] run];
    
    [person2 release];
}

void test4() {
    SQPerson *person = [[SQPerson alloc] init];
    NSLog(@"%zd", person.retainCount);
    [person release];
    
    @autoreleasepool {
        SQPerson *person1 = [[[SQPerson alloc] init] autorelease];
        SQPerson *person2 = [[[SQPerson alloc] init] autorelease];
        NSLog(@"1");
    }
    NSLog(@"2");
}

BOOL isTaggedPointer(id pointer) {
    return (uintptr_t)(__bridge void *)pointer & 1;
}
#if 0
inline bool
objc_object::isTaggedPointer()
{
    return _objc_isTaggedPointer(this);
}

// 如果是iOS平台 (指针的最高有效位是1, 就是Tagged Pointer)
#   define _OBJC_TAG_MASK (1UL<<63)

// 如果是Mac平台 (指针的最低有效位是1, 就是Tagged Pointer)
#   define _OBJC_TAG_MASK 1UL

static inline bool
_objc_isTaggedPointer(const void * _Nullable ptr)
{
    return ((uintptr_t)ptr & _OBJC_TAG_MASK) == _OBJC_TAG_MASK;
}
#endif
void test3() {
    //        NSNumber *number = [NSNumber numberWithBool:10];
    //        NSNumber *number = @(10);
    
    NSNumber *number1 = @4;
    NSNumber *number2 = @5;
    NSNumber *number3 = @(0xffffffffffff);
    
    NSLog(@"%d %d %d", isTaggedPointer(number1), isTaggedPointer(number2), isTaggedPointer(number3));
    NSLog(@"%p %p %p", number1, number2, number3);
}

/*
 字符串常量
 str=0x10ccc1250
 
 已初始化的全局变量, 静态变量
 &a =0x10ccc27e0
 &c =0x10ccc27e4

 未初始化的全局变量, 静态变量
 &d =0x10ccc28a8
 &b =0x10ccc28c0
 
 堆
 obj=0x60000345c170

 栈
 &f =0x7ffee2f41e68
 &e =0x7ffee2f41e6c
 */

int a = 10;
int b;

void test2() {
    static int c = 20;
    static int d;
    int e;
    int f = 20;
    NSString *str = @"123";
    NSObject *obj = [[NSObject alloc] init];
    
    NSLog(@"\n&a=%p\n&b=%p\n&c=%p\n&d=%p\n&e=%p\n&f=%p\nstr=%p\nobj=%p",
          &a, &b, &c, &d, &e, &f, str, obj);
}

void test() {
    ViewController *vc = [[ViewController alloc] init];
    
    SQProxy *proxy = [SQProxy proxyWithTarget:vc];
    SQObject *object = [SQObject proxyWithTarget:vc];
    
    NSLog(@"%d %d",
          [proxy isKindOfClass:[ViewController class]],
          [object isKindOfClass:[ViewController class]]);
#if 0
    - (BOOL) isKindOfClass: (Class)aClass
    {
        NSMethodSignature    *sig;
        NSInvocation        *inv;
        BOOL            ret;
        
        sig = [self methodSignatureForSelector: _cmd];
        inv = [NSInvocation invocationWithMethodSignature: sig];
        [inv setSelector: _cmd];
        [inv setArgument: &aClass atIndex: 2];
        [self forwardInvocation: inv];
        [inv getReturnValue: &ret];
        return ret;
    }
#endif
}
