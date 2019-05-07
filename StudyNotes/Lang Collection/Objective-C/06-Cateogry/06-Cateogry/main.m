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
        [SQStudent load];
        
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
