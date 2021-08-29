//
//  SQCommentManager.h
//  App
//
//  Created by 朱双泉 on 2021/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQCommentManager : NSObject

+ (SQCommentManager *)sharedManager;

- (void)showCommentView;

@end

NS_ASSUME_NONNULL_END
