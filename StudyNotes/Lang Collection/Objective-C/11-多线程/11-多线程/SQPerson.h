//
//  SQPerson.h
//  11-多线程
//
//  Created by 朱双泉 on 2019/5/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQBaseDemo.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQPerson : SQBaseDemo

@property (assign, nonatomic) int age;
@property (atomic, copy) NSString *name;
@property (strong, nonatomic) NSMutableArray *data;

@end

NS_ASSUME_NONNULL_END
