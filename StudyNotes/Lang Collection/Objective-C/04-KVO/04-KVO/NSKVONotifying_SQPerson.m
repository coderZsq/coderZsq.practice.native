//
//  NSKVONotifying_SQPerson.m
//  04-KVO
//
//  Created by 朱双泉 on 2019/5/5.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "NSKVONotifying_SQPerson.h"

@implementation NSKVONotifying_SQPerson

- (void)setAge:(int)age {
    _NSSetIntValueAndNotify();
}

// 屏幕内部实现, 隐藏了NSKVONotifying_SQPerson类的存在
- (Class)class {
    return [SQPerson class];
}

- (void)dealloc {
    // 收尾工作
}

- (BOOL)_isKVOA {
    return YES;
}

void _NSSetIntValueAndNotify() {
    [self willChangeValueForKey:@"age"];
    [super setAge:age];
    [self didChangeValueForKey:@"age"];
}

- (void)didChangeValueForKey:(NSString *)key {
    // 通知监听器, 某某属性值发生了改变
    [observer observeValueForKeyPath:key ofObject:self change:nil context:nil];
}

@end
