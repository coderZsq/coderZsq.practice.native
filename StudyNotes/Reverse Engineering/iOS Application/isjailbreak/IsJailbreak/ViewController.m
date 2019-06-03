//
//  ViewController.m
//  IsJailbreak
//
//  Created by 朱双泉 on 2019/6/3.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]) {
        NSLog(@"此设备已越狱");
    } else {
        NSLog(@"此设备未越狱");
    }
}


@end
