//
//  RProtocol.h
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/17.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RProtocol <NSObject>

@optional
- (void)bindViewModel:(UIView *)bindView;

@end

NS_ASSUME_NONNULL_END
