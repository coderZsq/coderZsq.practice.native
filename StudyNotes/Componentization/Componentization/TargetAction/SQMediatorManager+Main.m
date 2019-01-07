//
//  SQMediatorManager+Main.m
//  Componentization
//
//  Created by 朱双泉 on 2018/12/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "SQMediatorManager+Main.h"

@implementation SQMediatorManager (Main)

+ (UIViewController *)rootTabbarController {
    
    UIViewController *vc = [self performTarget:@"MainModuleAPI" action:@"rootTabBarCcontroller" params:nil isRequiredReturnValue:YES];
//    if (vc == nil) {
//        return [UIViewController 404Page];
//    }
    
    return vc;
}


+ (void)addChildVC: (UIViewController *)vc normalImageName: (NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController: (BOOL)isRequired {
    
    NSArray *param = @[vc, normalImageName, selectedImageName, @(isRequired)];
    [self performTarget:@"MainModuleAPI" action:@"addChildVC:normalImageName:selectedImageName:isRequiredNavController:" params:param isRequiredReturnValue:NO];
    
}


+ (void)setTabbarMiddleBtnClick: (void(^)(BOOL isPlaying))middleClickBlock {
    
    [self performTarget:@"MainModuleAPI" action:@"setTabbarMiddleBtnClick:" params:@[middleClickBlock] isRequiredReturnValue:NO];
    
    
}


@end
