//
//  RView.h
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RACSubject;
//@class RView;
//@protocol RViewDelegate <NSObject>
//
//@optional
//- (void)viewWithTap:(RView *)view;
//
//@end

@interface RView : UIView

//@property (nonatomic, weak) id <RViewDelegate> delegate;

@property (nonatomic, strong) RACSubject * subject;

@end

NS_ASSUME_NONNULL_END
