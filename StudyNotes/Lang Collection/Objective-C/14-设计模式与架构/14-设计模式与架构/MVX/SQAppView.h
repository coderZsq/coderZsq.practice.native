//
//  SQAppView.h
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// MVC-Apple
//@interface SQAppView : UIView
//
//@property (weak, nonatomic, readonly) UIImageView *iconView;
//@property (weak, nonatomic, readonly) UILabel *nameLabel;
//
//@end

@class MVX_SQApp, MVX_SQAppView;
@protocol SQAppViewDelegate <NSObject>
@optional
- (void)appViewDidClick:(MVX_SQAppView *)appView;
@end

@interface MVX_SQAppView : UIView

@property (strong, nonatomic) MVX_SQApp *app;
@property (weak, nonatomic) id<SQAppViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
