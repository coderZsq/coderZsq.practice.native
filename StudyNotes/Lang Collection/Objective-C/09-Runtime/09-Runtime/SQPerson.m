//
//  SQPerson.m
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/9.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson.h"
#import <objc/runtime.h>
#import "SQCat.h"

// & 可以用来取出特定的位
//   0000 0011
// & 0000 0010
// -------------
//   0000 0010

//   0010 0010
// & 1111 1101
// -------------
//   0010 0000

// | 可以用来设置特定的位
//   0010 1000
// | 0000 0010
// -------------
//   0010 1010

// 掩码, 一般用来按位与(&)运算的
//#define SQTallMask 1
//#define SQRichMask 2
//#define SQHandsomeMask 4

//#define SQTallMask 0b00000001
//#define SQRichMask 0b00000010
//#define SQHandsomeMask 0b00000100

#define SQTallMask (1<<0)
#define SQRichMask (1<<1)
#define SQHandsomeMask (1<<2)
#define SQThinMask (1<<3)

@interface SQPerson () {
    union {
        char bits;
        struct {
            char tall: 1; // 最低位
            char rich: 1;
            char handsome: 1;
            char thin: 1;
        }; // 0b 0000 0111
    } _tallRichHandsome;
    
//    char _tallRichHandsome; // 0b 0000 0000
    
//    位域
//    struct {
//        char tall: 2; // 最低位
//        char rich: 2;
//        char handsome: 2;
//    } _tallRichHandsome; // 0b 0001 0101
}
@end

struct SQPerson_IMPL {
    Class isa;
    NSString *_name;
};
#if 0
struct SQPerson_IMPL {
    struct NSObject_IMPL NSObject_IVARS;
    
    union  {
        char bits;
        
        struct  {
            char tall : 1;
            char rich : 1;
            char handsome : 1;
            char thin : 1;
        } ;
    } _tallRichHandsome;
    NSString * _Nonnull _name;
    double _height;
};
#endif

// xcrun -sdk iphoneos clang -arch arm64 -rewrite-objc SQPerson.m
// clang -emit-llvm -S SQPerson.m

@implementation SQPerson

// LLVM
// OC -> 中间代码 -> 汇编 -> 机器代码

void test(int param) {
    
}
#if 0
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [super forwardInvocation:anInvocation];
    
    /*
    ; Function Attrs: noinline optnone ssp uwtable
    define internal void @"\01-[SQPerson forwardInvocation:]"(%1*, i8*, %2*) #1 {
        %4 = alloca %1*, align 8
        %5 = alloca i8*, align 8
        %6 = alloca %2*, align 8
        %7 = alloca %struct._objc_super, align 8
        %8 = alloca i32, align 4
        %9 = alloca i32, align 4
        %10 = alloca i32, align 4
        store %1* %0, %1** %4, align 8
        store i8* %1, i8** %5, align 8
        store %2* %2, %2** %6, align 8
        %11 = load %1*, %1** %4, align 8
        %12 = load %2*, %2** %6, align 8
        %13 = bitcast %1* %11 to i8*
        %14 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %7, i32 0, i32 0
        store i8* %13, i8** %14, align 8
        %15 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_", align 8
        %16 = bitcast %struct._class_t* %15 to i8*
        %17 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %7, i32 0, i32 1
        store i8* %16, i8** %17, align 8
        %18 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.2, align 8, !invariant.load !9
        call void bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to void (%struct._objc_super*, i8*, %2*)*)(%struct._objc_super* %7, i8* %18, %2* %12)
        store i32 10, i32* %8, align 4
        store i32 20, i32* %9, align 4
        %19 = load i32, i32* %8, align 4
        %20 = load i32, i32* %9, align 4
        %21 = add nsw i32 %19, %20
        store i32 %21, i32* %10, align 4
        %22 = load i32, i32* %10, align 4
        call void @test(i32 %22)
        ret void
    }*/
    
    // 查看汇编
    // objc_msgSendSuper2()
    /*
     movq    %rdx, -40(%rbp)
     movq    L_OBJC_CLASSLIST_SUP_REFS_$_(%rip), %rdx
     movq    %rdx, -32(%rbp)
     movq    L_OBJC_SELECTOR_REFERENCES_.2(%rip), %rdx
     leaq    -40(%rbp), %rdi
     movq    %rsi, -64(%rbp)         ## 8-byte Spill
     movq    %rdx, %rsi
     movq    -64(%rbp), %rdx         ## 8-byte Reload
     callq    _objc_msgSendSuper2
     */
    
    //转为cpp文件
    // ((void (*)(__rw_objc_super *, SEL, NSInvocation *))(void *)objc_msgSendSuper)((__rw_objc_super){(id)self, (id)class_getSuperclass(objc_getClass("SQPerson"))}, sel_registerName("forwardInvocation:"), (NSInvocation *)anInvocation);
    
    int a = 10;
    int b = 20;
    int c = a + b;
    test(c);
}
#endif
- (void)print {
    NSLog(@"my name is %@", self.name);
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    // 本来能调用的方法
    if ([self respondsToSelector:aSelector]) {
        return [super methodSignatureForSelector:aSelector];
    }
    
    // 找不到的方法
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

// 找不到的方法, 都会来到这里
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"找不到%@方法", NSStringFromSelector(anInvocation.selector));
}
// NSProxy

- (void)run {
    NSLog(@"%s", __func__);
}

// 提醒编译器不要自动生成setter和getter的实现, 不要自动生成成员变量
@dynamic age;
//@synthesize age = _age, height = _height;

void setAge(id self, SEL _cmd, int age) {
    NSLog(@"age is %d", age);
}

int age() {
    return 120;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(setAge:)) {
        class_addMethod(self, sel, (IMP)setAge, "v@:i");
        return YES;
    } else if (sel == @selector(age)) {
        class_addMethod(self, sel, (IMP)age, "i@:");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
//        return [SQCat class];
//        return nil;
        // objc_msgSend([[SQCat alloc] init], @selector(test));
        // [[[SQCat alloc] init] test]
        return [[SQCat alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s", __func__);
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
//        return [[SQCat alloc] init];
        return nil;
    }
    return [super forwardingTargetForSelector:aSelector];
}
#if 0
// 方法签名: 返回值类型, 参数类型
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(test2:)) {
//        return [NSMethodSignature signatureWithObjCTypes:"i@:i"];
        return [[[SQCat alloc] init] methodSignatureForSelector:aSelector];
    }
    if (aSelector == @selector(test)) {
        return [NSMethodSignature signatureWithObjCTypes:"v16@0:8"];
    }
    if (aSelector == @selector(test:)) {
//        return [NSMethodSignature signatureWithObjCTypes:"v20@0:8i16"];
        return [NSMethodSignature signatureWithObjCTypes:"v@:i"];
    }
    return [super methodSignatureForSelector:aSelector];
}

// NSInvocation封装了一个方法调用, 包括: 方法调用者, 方法名, 方法参数
//    anInvocation.target 方法调用者
//    anInvocation.selector 方法名
//    [anInvocation getArgument:NULL atIndex:0]
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"%s", __func__);
    
    if (anInvocation.selector == @selector(test2:)) {
        // anInvocation.target == person对象
        // anInvocation.target == test2:
        // anInvocation的参数: receiver, selector, 15
        // [[[SQCat alloc] init] test2: 15]
        [anInvocation invokeWithTarget:[[SQCat alloc] init]];
        int ret;
        [anInvocation getReturnValue:&ret];
        NSLog(@"%d", ret);
    }
    
    if (anInvocation.selector == @selector(test:)) {
        // 参数顺序: reveiver, selector, other arguments
        int age;
        [anInvocation getArgument:&age atIndex:2];
        NSLog(@"%d", age + 10);
    }
    
    if (anInvocation.selector == @selector(test)) {
        //    anInvocation.target = [[SQCat alloc] init];
        //    [anInvocation invoke];
        [anInvocation invokeWithTarget:[[SQCat alloc] init]];
    }
}
#endif
#if 0
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
        // objc_msgSend([[SQCat alloc] init], aSelector);
        return [[SQCat alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}
#endif

void c_other(id self, SEL _cmd) {
    NSLog(@"c_other - %@ - %@", self, NSStringFromSelector(_cmd));
}

- (void)other {
    NSLog(@"%s", __func__);
}
#if 0
+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(test)) {
        class_addMethod(object_getClass(self), sel,
                        (IMP)c_other,
                        "v16@0:8");
        return YES;
    }
    return [super resolveClassMethod:sel];
}
#endif
//- (void)test {
//    NSLog(@"%s", __func__);
//}

// typedef struct objc_method *Method;
// struct objc_method == struct method_t
// struct method_t *otherMethod = (struct method_t *)class_getInstanceMethod(self, @selector(other));
// NSLog(@"%s %s %p", otherMethod->sel, otherMethod->types, otherMethod->imp);

struct method_t {
    SEL sel;
    char *types;
    IMP imp;
};

#if 0
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s", __func__);
    if (sel == @selector(test)) {
        // 动态添加test方法的实现
        class_addMethod(self, sel,
                        (IMP)c_other,
                        "v16@0:8");
        // 返回YES代表有动态添加方法
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
#endif

#if 0
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s", __func__);
    if (sel == @selector(test)) {
        // 获取其他方法
        Method method = class_getInstanceMethod(self, @selector(other));

        // 动态添加test方法的实现
        class_addMethod(self, sel,
                        method_getImplementation(method),
                        method_getTypeEncoding(method));
        // 返回YES代表有动态添加方法
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
#endif

#if 0
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%s", __func__);
    if (sel == @selector(test)) {
        // 获取其他方法
         struct method_t *otherMethod = (struct method_t *)class_getInstanceMethod(self, @selector(other));
         NSLog(@"%s %s %p", otherMethod->sel, otherMethod->types, otherMethod->imp);

        // 动态添加test方法的实现
        class_addMethod(self, sel, otherMethod->imp, otherMethod->types);

        // 返回YES代表有动态添加方法
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
#endif

- (int)test:(int)age height:(float)height {
    NSLog(@"%s", __func__);
    return 0;
}

- (void)personTest {
    NSLog(@"%s", __func__);
}

- (void)personTest2 {}

- (void)personTest3 {}

- (void)setTall:(BOOL)tall {
    if (tall) {
        _tallRichHandsome.bits |= SQTallMask;
    } else {
        _tallRichHandsome.bits &= ~SQTallMask;
    }
}

- (BOOL)isTall {
    return !!(_tallRichHandsome.bits & SQTallMask);
}

- (void)setRich:(BOOL)rich {
    if (rich) {
        _tallRichHandsome.bits |= SQRichMask;
    } else {
        _tallRichHandsome.bits &= ~SQRichMask;
    }
}

- (BOOL)isRich {
    return !!(_tallRichHandsome.bits & SQRichMask);
}

- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _tallRichHandsome.bits |= SQHandsomeMask;
    } else {
        _tallRichHandsome.bits &= ~SQHandsomeMask;
    }
}

- (BOOL)isHandsome {
    return !!(_tallRichHandsome.bits & SQHandsomeMask);
}

- (void)setThin:(BOOL)thin {
    if (thin) {
        _tallRichHandsome.bits |= SQThinMask;
    } else {
        _tallRichHandsome.bits &= ~SQThinMask;
    }
}

- (BOOL)isThin {
    return !!(_tallRichHandsome.bits & SQThinMask);
}

/*
- (void)setTall:(BOOL)tall {
    _tallRichHandsome.tall = tall;
}

- (BOOL)isTall {
    //    BOOL 0b1111 1111
    //    _tallRichHandsome.tall == 0b1
    //    BOOL ret = _tallRichHandsome.tall;
 
    // (lldb) p/x &ret
    // (BOOL *) $0 = 0x00007ffeefbff49f 255
    // (lldb) x 0x00007ffeefbff49f
    // 0x7ffeefbff49f: ff df af a3 70 ff 7f 00 00 50 65 b0 02 01 00 00  ....p....Pe.....
    // 0x7ffeefbff4af: 00 00 f5 bf ef fe 7f 00 00 e6 0d 00 00 01 00 00  ................
 
    // char c1 = -1;
    // unsigned char c2 = 255;
 
    // (lldb) p/x &c1
    // (char *) $0 = 0x00007ffeefbff4ef "\xffffffff \xfffffff5\xffffffbf\xffffffef\xfffffffe\x7f"
    // (lldb) p/x &c2
    // (char *) $1 = 0x00007ffeefbff4ee "\xffffffff\xffffffff \xfffffff5\xffffffbf\xffffffef\xfffffffe\x7f"
    // (lldb) x 0x00007ffeefbff4ef
    // 0x7ffeefbff4ef: ff 20 f5 bf ef fe 7f 00 00 01 00 00 00 00 00 00  . ..............
    // 0x7ffeefbff4ff: 00 10 f5 bf ef fe 7f 00 00 d5 13 57 7c ff 7f 00  ...........W|...
    // (lldb) x 0x00007ffeefbff4ee
    // 0x7ffeefbff4ee: ff ff 20 f5 bf ef fe 7f 00 00 01 00 00 00 00 00  .. .............
    // 0x7ffeefbff4fe: 00 00 10 f5 bf ef fe 7f 00 00 d5 13 57 7c ff 7f  ............W|..
 
    return !!_tallRichHandsome.tall;
}

- (void)setRich:(BOOL)rich {
    _tallRichHandsome.rich = rich;
}

- (BOOL)isRich {
    //    return _tallRichHandsome.rich;
    return !!_tallRichHandsome.rich;
}

- (void)setHandsome:(BOOL)handsome {
    _tallRichHandsome.handsome = handsome;
}

- (BOOL)isHandsome {
    return !!_tallRichHandsome.handsome;
}
*/

/*
- (instancetype)init {
    if (self = [super init]) {
        _tallRichHandsome = 0b00000011;
    }
    return self;
}

- (void)setTall:(BOOL)tall {
    if (tall) {
        _tallRichHandsome |= SQTallMask;
    } else {
        _tallRichHandsome &= ~SQTallMask;
    }
}

- (BOOL)isTall {
    return !!(_tallRichHandsome & SQTallMask);
}

- (void)setRich:(BOOL)rich {
    if (rich) {
        _tallRichHandsome |= SQRichMask;
    } else {
        _tallRichHandsome &= ~SQRichMask;
    }
}

- (BOOL)isRich {
    return !!(_tallRichHandsome & SQRichMask);
}

- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _tallRichHandsome |= SQHandsomeMask;
    } else {
        _tallRichHandsome &= ~SQHandsomeMask;
    }
}

- (BOOL)isHandsome {
    return !!(_tallRichHandsome & SQHandsomeMask);
}
*/

@end
