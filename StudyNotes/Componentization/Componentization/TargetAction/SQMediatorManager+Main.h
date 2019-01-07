//
//  SQMediatorManager+Main.h
//  Componentization
//
//  Created by 朱双泉 on 2018/12/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQMediatorManager.h"
#import <UIKit/UIKit.h>

@interface SQMediatorManager (Main)

+ (UIViewController *)rootTabbarController;

+ (void)addChildVC: (UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired;

+ (void)setTabbarMiddleBtnClick: (void(^)(BOOL isPlaying))middleClickBlock;


@end
