//
//  RFlagItem.h
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RFlagItem : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * icon;

+ (instancetype)itemWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
