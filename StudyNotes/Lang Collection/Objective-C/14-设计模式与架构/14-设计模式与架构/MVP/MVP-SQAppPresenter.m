//
//  MVP-SQAppPresenter.m
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import "MVP-SQAppPresenter.h"
#import "MVP-SQApp.h"
#import "MVP-SQAppView.h"

@interface MVP_SQAppPresenter () <SQAppViewDelegate>
@property (weak, nonatomic) UIViewController *controller;
@end

@implementation MVP_SQAppPresenter

- (instancetype)initWithController:(UIViewController *)controller {
    if (self = [super init]) {
        self.controller = controller;
        
        // 创建view
        MVP_SQAppView *appView = [[MVP_SQAppView alloc] init];
        appView.frame = CGRectMake(100, 100, 100, 150);
        appView.delegate = self;
        [controller.view addSubview:appView];
        
        // 加载模型数据
        MVP_SQApp *app = [[MVP_SQApp alloc] init];
        app.name = @"QQ";
        app.image = @"QQ";
        
        // 赋值数据
        [appView setName:app.name andImage:app.image];
//        appView.iconView.image = [UIImage imageNamed:app.image];
//        appView.nameLabel.text = app.name;
    }
    return self;
}

#pragma mark - SQAppleViewDelegate
- (void)appViewDidClick:(MVP_SQAppView *)appView {
    NSLog(@"presenter 监听了 appView 的点击");
}

@end
