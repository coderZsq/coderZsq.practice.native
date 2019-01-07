//
//  BarrageView.h
//  Componentization
//
//  Created by 朱双泉 on 2019/1/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarrageProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BarrageViewProtocol <NSObject>

@property (nonatomic, readonly) NSTimeInterval currentTime;

- (UIView *)barrageViewWithModel:(id <BarrageProtocol>)model;

- (void)barrageViewDidClick:(UIView *)barrageView at:(CGPoint)point;

@end

@interface BarrageView : UIView

@property (nonatomic, weak) id <BarrageViewProtocol> delegate;

@property (nonatomic, strong) NSMutableArray <id <BarrageProtocol>>* models;

- (void)pause;

- (void)resume;

@end

NS_ASSUME_NONNULL_END
