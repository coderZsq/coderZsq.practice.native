//
//  SQAppView.h
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MVVM_SQAppView, MVVM_SQAppViewModel;
@protocol SQAppViewDelegate <NSObject>
@optional
- (void)appViewDidClick:(MVVM_SQAppView *)appView;
@end

@interface MVVM_SQAppView : UIView

@property (weak, nonatomic) MVVM_SQAppViewModel *viewModel;
@property (weak, nonatomic) id<SQAppViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
