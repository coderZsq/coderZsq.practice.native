//
//  NSConditionLockDemo.m
//  11-多线程
//
//  Created by 朱双泉 on 2019/5/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "NSConditionLockDemo.h"

@interface NSConditionLockDemo ()
@property (nonatomic, strong) NSConditionLock *conditionLock;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation NSConditionLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.conditionLock = [[NSConditionLock alloc] initWithCondition: 1];
//        self.conditionLock = [[NSConditionLock alloc] init];
        self.data = [NSMutableArray array];
    }
    return self;
}

- (void)otherTest {
    [[[NSThread alloc] initWithTarget:self selector:@selector(__one) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__two) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__three) object:nil] start];
}

- (void)__one {
//    [self.conditionLock lockWhenCondition:1];
//    [self.conditionLock lockWhenCondition:0];
    [self.conditionLock lock]; // 不等条件值
    NSLog(@"__one");
    sleep(1);
    [self.conditionLock unlockWithCondition:2];
}

- (void)__two {
    [self.conditionLock lockWhenCondition:2];
    NSLog(@"__two");
    sleep(1);
    [self.conditionLock unlockWithCondition:3];
}

- (void)__three {
    [self.conditionLock lockWhenCondition:3];
    NSLog(@"__three");
    [self.conditionLock unlock];
}

@end
