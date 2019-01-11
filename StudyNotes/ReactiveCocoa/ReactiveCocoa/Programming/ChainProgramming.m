//
//  ChainProgramming.m
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ChainProgramming.h"

@implementation ChainProgramming

/*
 NSLog(@"%ld", [ChainProgramming new].add(1).add(2).add(3).add(4).result);
 */

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (ChainProgramming * _Nonnull (^)(NSInteger))add {
    return ^(NSInteger value) {
        self.result += value;
        return self;
    };
}

- (void)setResult:(NSInteger)result {
    _result = result;
}

@end
