//
//  Object.h
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Object : NSObject

@property (nonatomic, copy) NSString * string;

- (void)sendMessage;

+ (instancetype)objectWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
