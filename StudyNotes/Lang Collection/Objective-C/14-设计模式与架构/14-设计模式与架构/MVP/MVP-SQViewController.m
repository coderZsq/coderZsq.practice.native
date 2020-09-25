//
//  MVP-SQViewController.m
//  14-设计模式与架构
//
//  Created by 朱双泉 on 2020/9/25.
//

#import "MVP-SQViewController.h"
#import "MVP-SQAppPresenter.h"

@interface MVP_SQViewController ()
@property (strong, nonatomic) MVP_SQAppPresenter *presenter;
//@property (strong, nonatomic) MVP_SQOtherPresenter *presenter1;
//@property (strong, nonatomic) MVP_SQNewsPresenter *presenter2;
@end

@implementation MVP_SQViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.presenter = [[MVP_SQAppPresenter alloc] initWithController:self];
}

@end
