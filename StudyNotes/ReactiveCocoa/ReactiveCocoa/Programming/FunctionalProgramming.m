//
//  FunctionalProgramming.m
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "FunctionalProgramming.h"

@implementation FunctionalProgramming

/*
 FunctionalProgramming * f = [FunctionalProgramming new];
 [[f calculator:^(NSInteger result) {
 result += 5;
 result += 10;
 result -= 1;
 return result;
 }]log];
 */

- (instancetype)calculator:(NSInteger (^)(NSInteger))calculator {
    _result = calculator(_result);
    return self;
}

- (instancetype)log {
    NSLog(@"%ld", _result);
    return self;
}

@end
