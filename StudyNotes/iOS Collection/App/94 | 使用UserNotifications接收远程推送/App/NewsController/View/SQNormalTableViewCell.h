//
//  SQNormalTableViewCell.h
//  App
//
//  Created by 朱双泉 on 2021/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SQListItem;

/// 点击删除按钮
@protocol SQNormalTableViewCellDelegate <NSObject>
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;
@end

/// 新闻列表cell
@interface SQNormalTableViewCell : UITableViewCell

@property (nonatomic, weak, readwrite) id<SQNormalTableViewCellDelegate> delegate;

- (void)layoutTableViewCellWithItem:(SQListItem *)item;

@end

NS_ASSUME_NONNULL_END
