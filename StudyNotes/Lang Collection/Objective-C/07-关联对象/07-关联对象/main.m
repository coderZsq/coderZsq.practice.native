//
//  main.m
//  07-关联对象
//
//  Created by 朱双泉 on 2019/5/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQPerson+Test.h"
#import <objc/runtime.h>

/*
 Category能否添加成员变量? 如果可以, 如何给Category添加成员变量?
 不能直接给Category添加成员变量, 但是可以间接实现Category有成员变量的效果
 */

//extern const void *SQNameKey;
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        NSLog(@"%p", SQNameKey);
        
        SQPerson *person = [[SQPerson alloc] init];
        person.age = 10;
        person.name = @"jack";
        person.weight = 30;
        
//        {
//            SQPerson *temp = [[SQPerson alloc] init];
//            
//            objc_setAssociatedObject(person, @"temp", temp, OBJC_ASSOCIATION_ASSIGN);
//        }
//
//        NSLog(@"%@", objc_getAssociatedObject(person, @"temp"));
        
        SQPerson *person2 = [[SQPerson alloc] init];
        person2.age = 20;
        person2.name = @"rose";
        person2.weight = 50;

        NSLog(@"person age is %d, name is %@, weight is %d", person.age, person.name, person.weight);
        NSLog(@"person2 age is %d, name is %@ weight is %d", person.age, person2.name, person2.weight);
    }
    return 0;
}

void test1() {
    SQPerson *person = [[SQPerson alloc] init];
    person.age = 10;
    person.weight = 40;

    SQPerson *person2 = [[SQPerson alloc] init];
    person2.age = 20; // 20是存储在person2对象内部
    person2.weight = 50; // 50是存放在全局的字典对象里面

    NSLog(@"person age is %d, weight is %d", person.age, person.weight);
    NSLog(@"person2 age is %d, weight is %d", person.age, person2.weight);
}
