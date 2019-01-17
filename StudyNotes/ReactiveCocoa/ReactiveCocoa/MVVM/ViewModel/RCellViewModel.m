//
//  RCellViewModel.m
//  ReactiveCocoa
//
//  Created by 朱双泉 on 2019/1/17.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "RCellViewModel.h"
#import "RCell.h"
#import "UIImageView+WebCache.h"
#import "SQHomeRecommendItem.h"

@implementation RCellViewModel

- (void)bindViewModel:(UIView *)bindView {
    RCell * cell = (RCell *)bindView;
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:_item.courseImage]];
    cell.nameView.text = _item.courseName;
    [cell.numView setTitle:_item.studentNum forState:UIControlStateNormal];
}

@end
