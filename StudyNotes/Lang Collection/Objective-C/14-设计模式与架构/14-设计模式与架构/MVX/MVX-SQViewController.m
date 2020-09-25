//
//  MVX-SQViewController.m
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import "MVX-SQViewController.h"
#import "MVX-SQApp.h"
#import "MVX-SQAppView.h"

@interface MVX_SQViewController () <SQAppViewDelegate>

@end

@implementation MVX_SQViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建view
    MVX_SQAppView *appView = [[MVX_SQAppView alloc] init];
    appView.frame = CGRectMake(100, 100, 100, 150);
    appView.delegate = self;
    [self.view addSubview:appView];
    
    
    // 加载模型数据
    MVX_SQApp *app = [[MVX_SQApp alloc] init];
    app.name = @"QQ";
    app.image = @"QQ";
    
    // 设置数据到view上
    // MVX
    appView.app = app;
    // MVC-Apple
//    appView.iconView.image = [UIImage imageNamed:app.image];
//    appView.nameLabel.text = app.name;
}


#pragma mark - SQAppViewDelegate
- (void)appViewDidClick:(MVX_SQAppView *)appView {
    NSLog(@"控制器监听到了appView的点击");
}

@end
