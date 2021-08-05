//
//  SQMediator.m
//  App
//
//  Created by 朱双泉 on 2021/1/20.
//

#import "SQMediator.h"

@implementation SQMediator

+ (__kindof UIViewController *)detailViewControllerWithUrl:(NSString *)detailUrl {
    Class detailCls = NSClassFromString(@"SQDetailViewController");
    UIViewController *controller = [[detailCls alloc] performSelector:NSSelectorFromString(@"initWithUrlString:") withObject:detailUrl];
    return controller;
}

#pragma mark -
+ (NSMutableDictionary *)mediatorCache {
    static NSMutableDictionary *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = @{}.mutableCopy;
    });
    return cache;
}

+ (void)registerScheme:(NSString *)scheme processBlock:(SQMediatorProcessBlock)processBlock {
    if (scheme && processBlock) {
        [[[self class] mediatorCache] setObject:processBlock forKey:scheme];
    }
}

+ (void)openUrl:(NSString *)url params:(NSDictionary *)params {
    SQMediatorProcessBlock block = [[[self class] mediatorCache] objectForKey:url];
    if (block) {
        block(params);
    }
}

@end
