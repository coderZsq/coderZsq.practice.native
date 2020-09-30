//
//  ViewController.m
//  01-启动优化
//
//  Created by 朱双泉 on 2020/9/30.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

+ (void)load {
    NSLog(@"%s", __func__);
}


+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"%s", __func__);
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __func__);
}

@end
