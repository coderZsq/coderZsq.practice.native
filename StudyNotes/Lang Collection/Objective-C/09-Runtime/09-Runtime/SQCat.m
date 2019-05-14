//
//  SQCat.m
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQCat.h"

@implementation SQCat

+ (void)test {
    NSLog(@"%s", __func__);
}

- (void)test {
    NSLog(@"%s", __func__);
}

- (int)test2:(int)age {
    return age * 2;
}

@end
