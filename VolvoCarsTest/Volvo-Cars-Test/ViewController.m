//
//  ViewController.m
//  Volvo-Cars-Test
//
//  Created by 朱双泉 on 2023/4/25.
//

#import "ViewController.h"
#import "Volvo_Cars_Test-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *viewController = [SwiftUIViewWrapper createSwiftUIView];
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    viewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [viewController.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    [viewController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [viewController.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor].active = YES;
    [viewController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [viewController didMoveToParentViewController:self];
}


@end
