//
//  RCell.h
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RCell : UITableViewCell
@property (weak, nonatomic, readonly) IBOutlet UIImageView *iconView;
@property (weak, nonatomic, readonly) IBOutlet UILabel *nameView;
@property (weak, nonatomic, readonly) IBOutlet UIButton *numView;

@end
