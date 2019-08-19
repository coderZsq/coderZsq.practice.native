//
//  SQPerson.m
//  24-从OC到Swift
//
//  Created by 朱双泉 on 2019/8/19.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson.h"

@implementation SQPerson

- (instancetype)initWithAge:(NSInteger)age name:(NSString *)name {
    if (self = [super init]) {
        self.age = age;
        self.name = name;
    }
    return self;
}

+ (instancetype)personWithAge:(NSInteger)age name:(NSString *)name {
    return [[self alloc] initWithAge:age name:name];
}

+ (void)run { NSLog(@"Person +run"); }
- (void)run { NSLog(@"%zd %@ -run", _age, _name); }

+ (void)eat:(NSString *)food other:(NSString *)other { NSLog(@"Person +eat %@ %@", food, other); }
- (void)eat:(NSString *)food other:(NSString *)other { NSLog(@"%zd %@ -eat %@ %@", _age, _name, food, other); }

@end

int sum(int a, int b) { return a + b; }
