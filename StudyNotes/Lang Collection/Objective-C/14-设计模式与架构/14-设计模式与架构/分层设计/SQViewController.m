//
//  ViewController.m
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import "SQViewController.h"
#import "SQNewsService.h"

@interface SQViewController ()

@end

@implementation SQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SQNewsService loadNews:@{} success:^(NSArray * _Nonnull newsData) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
