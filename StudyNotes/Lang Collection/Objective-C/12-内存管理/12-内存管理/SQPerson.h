//
//  SQPerson.h
//  12-内存管理
//
//  Created by 朱双泉 on 2019/5/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQDog.h"
#import "SQCar.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQPerson : NSObject
#if 0
{
    SQDog *_dog;
    SQCar *_car;
    int _age;
}

- (void)setDog:(SQDog *)dog;

- (SQDog *)dog;

- (void)setCar:(SQCar *)car;

- (SQCar *)car;

- (void)setAge:(int)age;

- (int)age;
#endif

@property (nonatomic, assign) int age;
@property (nonatomic, retain) SQDog *dog;
@property (nonatomic, retain) SQCar *car;

+ (instancetype)person;

@end

NS_ASSUME_NONNULL_END
