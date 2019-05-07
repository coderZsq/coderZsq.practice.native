//
//  main.m
//  06-Cateogry
//
//  Created by 朱双泉 on 2019/5/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "SQPerson+Eat.h"
#import "SQPerson+Test.h"
#import "SQPerson+Test1.h"
#import "SQPerson+Test2.h"
#import "SQStudent.h"
#import "SQTeacher.h"

/*
 Category的实现原理
 Category编译之后的底层结构是struct category_t, 里面存储着分类的对象方法, 类方法, 属性, 协议信息
 在程序运行的时候, runtime会将Category的数据, 合并到类信息中(类对象, 元类对象中)
 */

/*
 Category和Class Extension的区别是什么?
 Class Extension在编译的时候, 它的数据就已经包含在类信息中
 Category是在运行时, 才会将数据合并到类信息中
 */

/*
 Category中有load方法吗? load方法是什么时候调用的? load方法能继承吗?
 有load方法
 load方法在runtime加载类, 分类的时候调用
 load方法可以继承, 但是一般情况下不会主动调用load方法, 都是让系统自动调用
 */

/*
 load, initialize方法的区别是什么?
 1.调用方式
 1> load是根据函数地址直接调用
 2> initialize是通过objc_msgSend调用
 
 2.调用时刻
 1> load是runtime加载类, 分类的时候调用 (只会调用1次)
 2> initialize是类第一次接收到消息的时候调用, 每一个类只会initialize一次 (父类的initialize方法可能会被调用多次)
 
 load, initialize的调用顺序?
 1.load
 1> 先调用类的load
 a) 先编译的类, 优先调用load
 b) 调用子类的load之前, 会先调用父类的load
 
 2> 再调用分类的load
 a) 先编译的分类, 优先调用load
 
 2.initialize
 1> 先初始化父类
 2> 再初始化子类 (可能最终调用的是父类的initialize方法)
 */

void printMethodNamesOfClass(Class cls) {
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString string];
    
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        // 拼接方法名
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    
    // 释放
    free(methodList);
    
    // 打印方法名
    NSLog(@"%@ %@", cls, methodNames);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        [SQPerson test];
//        objc_msgSend([SQPerson class], @selector(test));

        NSLog(@"-----------------");
        
        BOOL studentInitialized = NO;
        BOOL personInitialized = NO;
        BOOL teacherInitialized = NO;
        
        [SQStudent load];
        
        if (!studentInitialized) {
            if (!personInitialized) {
//                objc_msgSend([SQPerson class], @selector(initialize));
                personInitialized = YES;
            }
//            objc_msgSend([SQStudent class], @selector(initialize));
            studentInitialized = YES;
        }
        
        [SQTeacher load];

        if (!teacherInitialized) {
            if (!personInitialized) {
//                objc_msgSend([SQPerson class], @selector(initialize));
                personInitialized = YES;
            }
//            objc_msgSend([SQTeacher class], @selector(initialize));
            teacherInitialized = YES;
        }

//        printMethodNamesOfClass(object_getClass([SQPerson class]));
    }
    return 0;
}

void test() {
    SQPerson *person = [[SQPerson alloc] init];
    [person run];
    //        objc_msgSend(person, @selector(run));
    [person test];
    [person eat];
    //        objc_msgSend(person, @selector(eat));
    
    // 通过runtime动态将分类的方法合并到类对象, 元类对象中
}
