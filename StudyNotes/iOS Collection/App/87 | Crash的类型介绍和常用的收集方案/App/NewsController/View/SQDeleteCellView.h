//
//  SQDeleteCellView.h
//  App
//
//  Created by 朱双泉 on 2021/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 删除Cell确认浮层
@interface SQDeleteCellView : UIView

/// 点击出现删除Cell确认浮层
/// @param point 点击的位置
/// @param clickBlock 点击后的操作
- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;

@end

NS_ASSUME_NONNULL_END
