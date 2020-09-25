//
//  MVVM-SQViewController.m
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import "MVVM-SQViewController.h"
#import "MVVM-SQAppViewModel.h"

@interface MVVM_SQViewController ()
@property (strong, nonatomic) MVVM_SQAppViewModel *viewModel;
@end

@implementation MVVM_SQViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewModel = [[MVVM_SQAppViewModel alloc] initWithController:self];
}

@end
