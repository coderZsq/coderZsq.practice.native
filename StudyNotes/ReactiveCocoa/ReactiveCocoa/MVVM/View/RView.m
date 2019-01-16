//
//  RView.m
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "RView.h"
#import "ReactiveObjC.h"

@implementation RView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    if ([_delegate respondsToSelector:@selector(viewWithTap:)]) {
//        [_delegate viewWithTap:self];
//    }
    [_subject sendNext:self];
    [_subject sendCompleted];
}

@end
