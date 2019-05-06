//
//  SQPerson.m
//  05-KVC
//
//  Created by 朱双泉 on 2019/5/6.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson.h"

@implementation SQCat

@end

@implementation SQPerson

//- (int)getAge {
//    return 11;
//}

//- (int)age {
//    return 12;
//}

//- (int)isAge {
//    return 13;
//}

//- (int)_age {
//    return 14;
//}

//- (void)setAge:(int)age {
////    _age = age;
//
//    NSLog(@"%s - %d", __func__, age);
//}

//- (void)_setAge:(int)age {
//    NSLog(@"%s - %d", __func__, age);
//}

// 默认的返回值就是YES
//+ (BOOL)accessInstanceVariablesDirectly {
//    return YES;
//}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"%s - %@", __func__, key);
}

- (void)didChangeValueForKey:(NSString *)key {
    NSLog(@"%s - begin - %@", __func__, key);
    [super didChangeValueForKey:key];
    NSLog(@"%s - end - %@", __func__, key);
}

- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"%s", __func__);
    return nil;
}

@end
