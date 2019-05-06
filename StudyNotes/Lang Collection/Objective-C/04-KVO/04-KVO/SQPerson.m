//
//  SQPerson.m
//  04-KVO
//
//  Created by 朱双泉 on 2019/5/5.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson.h"

@implementation SQPerson

- (void)setAge:(int)age {
    _age = age;
    
    NSLog(@"%s", __func__);
}

//- (int)age {
//    return _age;
//}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    
    NSLog(@"%s", __func__);
}

- (void)didChangeValueForKey:(NSString *)key {
    
    NSLog(@"%s - begin", __func__);
    
    [super didChangeValueForKey:key];
    
    NSLog(@"%s - end", __func__);
}

@end
