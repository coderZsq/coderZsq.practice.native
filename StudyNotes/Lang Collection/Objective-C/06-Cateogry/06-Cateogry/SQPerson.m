//
//  SQPerson.m
//  06-Cateogry
//
//  Created by 朱双泉 on 2019/5/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson.h"

// class extension (匿名分类/类扩展)
//@interface SQPerson ()
//@property (nonatomic, assign) int age;
//@end

@implementation SQPerson

+ (void)load {
    NSLog(@"%s", __func__);
}

+ (void)test {
    NSLog(@"%s", __func__);
}

- (void)run {
    NSLog(@"%s", __func__);
}

+ (void)run2 {
    NSLog(@"%s", __func__);
}

@end
