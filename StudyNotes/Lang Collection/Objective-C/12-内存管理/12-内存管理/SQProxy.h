//
//  SQProxy.h
//  12-内存管理
//
//  Created by 朱双泉 on 2019/5/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;

@property (weak, nonatomic) id target;

@end

NS_ASSUME_NONNULL_END
