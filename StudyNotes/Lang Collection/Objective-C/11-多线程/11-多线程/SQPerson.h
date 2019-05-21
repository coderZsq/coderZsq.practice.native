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

@end

/*
 nonatomic 和 atomic
 atom: 原子, 不可再分割的单位
 atomic: 原子性
 
 给属性加上atomic修饰, 可以保证属性的setter和getter都是原子性操作, 也就是保证setter和getter内部是线程同步
 */

NS_ASSUME_NONNULL_END
