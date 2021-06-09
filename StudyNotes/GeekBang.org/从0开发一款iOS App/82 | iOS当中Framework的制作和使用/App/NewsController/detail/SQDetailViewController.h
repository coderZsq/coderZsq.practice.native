//
//  SQDetailViewController.h
//  App
//
//  Created by 朱双泉 on 2021/1/9.
//

#import <UIKit/UIKit.h>
#import "SQMediator.h"

NS_ASSUME_NONNULL_BEGIN

/// 文章底层页
@interface SQDetailViewController : UIViewController<SQDetailViewControllerProtocol>

- (instancetype)initWithUrlString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
