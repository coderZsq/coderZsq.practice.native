//
//  NSObject+Test.m
//  03-isa和superclass
//
//  Created by 朱双泉 on 2019/5/5.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "NSObject+Test.h"

@implementation NSObject (Test)

//+ (void)test {
//    NSLog(@"+[NSObject test] - %p", self);
//}

- (void)test {
    NSLog(@"-[NSObject test] - %p", self);
}

@end
