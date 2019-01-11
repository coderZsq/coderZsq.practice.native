//
//  FunctionalProgramming.h
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FunctionalProgramming : NSObject

@property (nonatomic, readonly) NSInteger result;

- (instancetype)calculator:(NSInteger(^)(NSInteger result))calculator;

- (instancetype)log;

@end

NS_ASSUME_NONNULL_END
