 //
//  SQPerson.m
//  12-内存管理
//
//  Created by 朱双泉 on 2019/5/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson.h"

@implementation SQPerson
//@synthesize age = _age;
#if 0
- (void)setDog:(SQDog *)dog {
    if (_dog != dog) {
        [_dog release];
        _dog = [dog retain];
    }
}

- (SQDog *)dog {
    return _dog;
}

- (void)setCar:(SQCar *)car {
    if (_car != car) {
        [_car release];
        _car = [car retain];
    }
}

- (SQCar *)car {
    return _car;
}

- (void)setAge:(int)age {
    _age = age;
}

- (int)age {
    return _age;
}
#endif

+ (instancetype)person {
    return [[[self alloc] init] autorelease];
}

- (void)setData:(NSMutableArray *)data {
    if (_data != data) {
        [_data release];
        _data = [data copy];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"age = %d, weight = %f", self.age, self.weight];
}

- (id)copyWithZone:(NSZone *)zone {
    SQPerson *person = [[SQPerson allocWithZone:zone] init];
    person.age = self.age;
    person.weight = self.weight;
    return person;
}

- (void)dealloc {
    self.data = nil;
    
//    [_dog release];
//    _dog = nil;
    self.dog = nil;
    self.car = nil;
    
    NSLog(@"%s", __func__);
    
    // 父类的dealloc放到最后
    [super dealloc];
}

@end
