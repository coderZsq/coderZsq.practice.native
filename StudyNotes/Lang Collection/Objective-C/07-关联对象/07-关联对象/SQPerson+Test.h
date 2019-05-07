//
//  SQPerson+Test.h
//  07-关联对象
//
//  Created by 朱双泉 on 2019/5/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQPerson (Test)

//- (void)setWeight:(int)weight;
//- (int)weight;

@property (assign, nonatomic) int weight;

@property (copy, nonatomic) NSString *name;

@end

NS_ASSUME_NONNULL_END
