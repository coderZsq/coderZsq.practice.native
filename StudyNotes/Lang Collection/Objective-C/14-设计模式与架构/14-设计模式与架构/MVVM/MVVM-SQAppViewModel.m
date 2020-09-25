//
//  MVVM-SQAppViewModel.m
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import "MVVM-SQAppViewModel.h"
#import "MVVM-SQApp.h"
#import "MVVM-SQAppView.h"

@interface MVVM_SQAppViewModel () <SQAppViewDelegate>
@property (weak, nonatomic) UIViewController *controller;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *image;
@end

@implementation MVVM_SQAppViewModel

- (instancetype)initWithController:(UIViewController *)controller {
    if (self = [super init]) {
        self.controller = controller;
        
        // 创建view
        MVVM_SQAppView *appView = [[MVVM_SQAppView alloc] init];
        appView.frame = CGRectMake(100, 100, 100, 150);
        appView.delegate = self;
        appView.viewModel = self;
        [controller.view addSubview:appView];
        
        // 加载模型数据
        MVVM_SQApp *app = [[MVVM_SQApp alloc] init];
        app.name = @"QQ";
        app.image = @"QQ";
        
        // 设置数据
        self.name = app.name;
        self.image = app.image;
    }
    return self;
}

#pragma mark - SQAppleViewDelegate
- (void)appViewDidClick:(MVVM_SQAppView *)appView {
    NSLog(@"viewModel 监听了 appView 的点击");
}

@end
