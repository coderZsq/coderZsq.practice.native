//
//  NSObject+Json.m
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/15.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "NSObject+Json.h"
#import <objc/runtime.h>

@implementation NSObject (Json)

+ (instancetype)sq_objectWithJson:(NSDictionary *)json {
    id obj = [[self alloc] init];
    unsigned int count;
    Ivar *ivars = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        // 取出i位置的成员变量
        Ivar ivar = ivars[i];
        NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
        [name deleteCharactersInRange:NSMakeRange(0, 1)];
        
        // 设值
        if (![name isEqualToString:@"tallRichHandsome"]) {
            [obj setValue:json[name] forKey:name];
        }
    }
    free(ivars);
    return obj;
}

@end
