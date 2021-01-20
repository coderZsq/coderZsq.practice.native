//
//  SQVideoCoverView.h
//  App
//
//  Created by 朱双泉 on 2021/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQVideoCoverView : UICollectionViewCell

- (void)layoutWithVideoCoverUrl:(NSString *)videoCoverUrl videoUrl:(NSString *)videoUrl;

@end

NS_ASSUME_NONNULL_END
