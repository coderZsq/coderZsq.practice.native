//
//  SQProxy.m
//  12-内存管理
//
//  Created by 朱双泉 on 2019/5/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQProxy.h"

@implementation SQProxy

+ (instancetype)proxyWithTarget:(id)target {
    // NSProxy对象不需要调用init, 因为它本来就没有init方法
    SQProxy *proxy = [SQProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
