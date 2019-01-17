//
//  RCellViewModel.h
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/17.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class SQHomeRecommendItem;

@interface RCellViewModel : NSObject <RProtocol>

@property (nonatomic, strong) SQHomeRecommendItem * item;

@end

NS_ASSUME_NONNULL_END
