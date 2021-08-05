//
//  SQVideoPlayer.h
//  App
//
//  Created by 朱双泉 on 2021/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQVideoPlayer : NSObject

+ (SQVideoPlayer *)Player;

- (void)playVideoWithUrl:(NSString *)videoUrl attachView:(UIView *)attachView;

@end

NS_ASSUME_NONNULL_END
