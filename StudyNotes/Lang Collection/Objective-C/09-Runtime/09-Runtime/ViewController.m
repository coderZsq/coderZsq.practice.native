//
//  ViewController.m
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/11.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"
#import "SQPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)test {
    
}

/*
 1. print为什么能够调用成功?
 2. 为什么self.name变成了ViewController
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSObject * obj2 = [[NSObject alloc] init];
    
    id cls = [SQPerson class];
    void *obj = &cls;
    [(__bridge id)obj print];
    
//    [self performSelector:@selector(test)];
//    [person performSelector:@selector(test)]
}

@end
