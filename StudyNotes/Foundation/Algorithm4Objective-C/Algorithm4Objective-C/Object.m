//
//  Object.m
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "Object.h"

@implementation Object

+ (instancetype)objectWithString:(NSString *)string {
    Object *obj = [Object new];
    obj.string = string;
    return obj;
}

- (void)sendMessage {
    NSLog(@"%@: sendMessage", self.string);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", self.string];
}

@end
