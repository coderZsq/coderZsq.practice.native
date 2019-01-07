//
//  BarrageModel.h
//  Componentization
//
//  Created by 朱双泉 on 2019/1/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BarrageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BarrageModel : NSObject<BarrageProtocol>

@property (nonatomic, assign) NSTimeInterval beginTime;
@property (nonatomic, assign) NSTimeInterval liveTime;
@property (nonatomic, copy) NSString * content;

@end

NS_ASSUME_NONNULL_END
