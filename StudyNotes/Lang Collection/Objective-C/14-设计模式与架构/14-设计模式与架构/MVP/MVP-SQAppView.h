//
//  SQAppView.h
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MVP_SQAppView;
@protocol SQAppViewDelegate <NSObject>
@optional
- (void)appViewDidClick:(MVP_SQAppView *)appView;
@end

@interface MVP_SQAppView : UIView

@property (weak, nonatomic) id<SQAppViewDelegate> delegate;

- (void)setName:(NSString *)name andImage:(NSString *)image;

@end

NS_ASSUME_NONNULL_END
