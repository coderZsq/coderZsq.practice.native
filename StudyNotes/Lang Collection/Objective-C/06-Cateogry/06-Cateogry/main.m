//
//  main.m
//  06-Cateogry
//
//  Created by 朱双泉 on 2019/5/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQPerson+Eat.h"
#import "SQPerson+Test.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        SQPerson *person = [[SQPerson alloc] init];
        [person run];
        //        objc_msgSend(person, @selector(run));
        [person test];
        [person eat];
        //        objc_msgSend(person, @selector(eat));
        
        // 通过runtime动态将分类的方法合并到类对象, 元类对象中
    }
    return 0;
}
