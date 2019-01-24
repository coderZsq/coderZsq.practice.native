//
//  NSArray+Address.m
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "NSArray+Address.h"

@implementation NSArray (Address)

- (void *)elementsAddress {
    void *address = (__bridge void *)(self);
    return *((void **)address + 5);
}

@end
