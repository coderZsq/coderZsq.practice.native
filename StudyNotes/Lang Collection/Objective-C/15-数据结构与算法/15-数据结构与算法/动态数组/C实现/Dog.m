//
//  Dog.m
//  15-数据结构与算法
//
//  Created by 朱双泉 on 2020/12/11.
//

#import "Dog.h"

@implementation Dog

+ (instancetype)dogWithName:(NSString *)name
{
    Dog *dog = [[self alloc] init];
    dog.name = name;
    return dog;
}

- (void)run
{
    NSLog(@"%@起飞了....", self.name);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@", self.name];
}

@end
