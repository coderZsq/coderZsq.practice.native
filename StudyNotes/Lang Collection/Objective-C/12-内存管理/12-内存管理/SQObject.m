//
//  SQObject.m
//  12-内存管理
//
//  Created by 朱双泉 on 2019/5/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQObject.h"

@implementation SQObject

+ (instancetype)proxyWithTarget:(id)target {
    SQObject *proxy = [[SQObject alloc] init];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

@end
