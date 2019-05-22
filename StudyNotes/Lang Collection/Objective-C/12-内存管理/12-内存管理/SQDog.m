

//
//  SQDog.m
//  12-内存管理
//
//  Created by 朱双泉 on 2019/5/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQDog.h"

@implementation SQDog

- (void)run {
    NSLog(@"%s", __func__);
}

- (void)dealloc {
    [super dealloc];
    NSLog(@"%s", __func__);
}

@end
