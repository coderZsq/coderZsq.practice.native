//
//  ViewController.m
//  08-Block
//
//  Created by 朱双泉 on 2019/5/9.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "SQPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SQPerson *p = [[SQPerson alloc] init];
    
    __weak SQPerson *weakP = p;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"1--------------%@", weakP);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"2--------------%@", p);
        });
    });
    
    NSLog(@"%s", __func__);
}

@end
