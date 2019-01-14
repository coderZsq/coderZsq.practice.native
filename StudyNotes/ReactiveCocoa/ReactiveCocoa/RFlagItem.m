//
//  RFlagItem.m
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "RFlagItem.h"

@implementation RFlagItem

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    RFlagItem * item = [self new];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}

@end
