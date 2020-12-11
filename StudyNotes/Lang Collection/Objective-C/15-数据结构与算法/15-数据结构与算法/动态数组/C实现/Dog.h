//
//  Dog.h
//  15-数据结构与算法
//
//  Created by 朱双泉 on 2020/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject

@property (nonatomic, copy) NSString *name;

- (void)run;

+ (instancetype)dogWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
