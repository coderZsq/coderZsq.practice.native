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
@end
