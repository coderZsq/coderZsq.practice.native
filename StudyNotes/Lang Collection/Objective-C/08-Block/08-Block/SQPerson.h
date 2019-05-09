//
//  SQPerson.h
//  08-Block
//
//  Created by 朱双泉 on 2019/5/8.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SQBlock)(void);

@interface SQPerson : NSObject

@property (copy, nonatomic) SQBlock block;

//@property (copy, nonatomic) void (^block)(void);

@property (assign, nonatomic) int age;

@property (copy, nonatomic) NSString *name;

- (void)test;

- (void)test2;

- (instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
