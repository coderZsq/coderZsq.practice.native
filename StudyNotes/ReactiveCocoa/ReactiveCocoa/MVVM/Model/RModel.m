//
//  RModel.m
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "RModel.h"

@implementation RModel

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    RModel * item = [self new];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

@end
