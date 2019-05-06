//
//  main.m
//  05-KVC
//
//  Created by 朱双泉 on 2019/5/6.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQPerson.h"
#import "SQObserver.h"

/*
 通过KVC修改属性会触发KVO么?
 会触发KVO
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        SQPerson *person = [[SQPerson alloc] init];
//        person->_age = 11;
//        person->_isAge = 12;
//        person->age = 13;
//        person->isAge = 14;
        
        /*
         getAge:
         age:
         isAge:
         _age:
         
         + accessInstanceVariablesDirectly
         
         int _age;
         int _isAge;
         int age;
         int isAge;
         
         valueForUndefinedKey:
         */
        
        NSLog(@"%@", [person valueForKey:@"age"]);
    }
    return 0;
}

void test2() {
    SQObserver *observer = [[SQObserver alloc] init];
    SQPerson *person = [[SQPerson alloc] init];
    
    // 添加KVO监听
    [person addObserver:observer forKeyPath:@"age" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    
    // 通过KVC修改age属性
    [person setValue:@10 forKey:@"age"];
    
    //        [person willChangeValueForKey:@"age"];
    //        person->_age = 10;
    //        [person didChangeValueForKey:@"age"];
    
    /*
     setAge:
     _setAge:
     
     + accessInstanceVariablesDirectly
     
     int _age;
     int _isAge;
     int age;
     int isAge;
     
     valueForUndefinedKey:
     */
//    NSLog(@"_age: %d, _isAge: %d, age: %d:, isAge: %d",
//          person->_age, person->_isAge, person->age, person->isAge);
    
    // 移除KVO监听
    [person removeObserver:observer forKeyPath:@"age"];
}

void test1() {
    SQPerson *person = [[SQPerson alloc] init];
//    person.age = 10;
    
    NSLog(@"%@", [person valueForKey:@"age"]);
    NSLog(@"%@", [person valueForKeyPath:@"cat.weight"]);
    
//    person.age = 10;
//    NSLog(@"%d", person.age);
    
    [person setValue:[NSNumber numberWithInt:10] forKey:@"age"];
    [person setValue:@10 forKey:@"age"];
//    NSLog(@"%d", person.age);
    
    person.cat = [[SQCat alloc] init];
    [person setValue:@10 forKeyPath:@"cat.weight"];
}
