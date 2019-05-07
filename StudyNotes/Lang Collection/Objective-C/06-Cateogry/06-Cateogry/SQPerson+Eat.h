//
//  SQPerson+Eat.h
//  06-Cateogry
//
//  Created by 朱双泉 on 2019/5/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQPerson (Eat) <NSCopying, NSCoding>

- (void)eat;

@property (assign, nonatomic) int weight;
@property (assign, nonatomic) double height;

@end

NS_ASSUME_NONNULL_END
