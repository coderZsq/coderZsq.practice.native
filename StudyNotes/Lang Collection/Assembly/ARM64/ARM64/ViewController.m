//
//  ViewController.m
//  ARM64
//
//  Created by 朱双泉 on 2019/4/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /*
     (lldb) register read x0
     x0 = 0x0000000283c7b8d0
     (lldb) register read w0
     w0 = 0x83c7b8d0
     (lldb) register write x0 0x0000000111111111
     (lldb) register read w0
     w0 = 0x11111111
     (lldb) register read
     General Purpose Registers:
     x0 = 0x0000000111111111
     x1 = 0x0000000283c7b8d0
     x2 = 0x0000000280e65d40
     x3 = 0x0000000283c7b8d0
     x4 = 0x0000000000000001
     x5 = 0x0000000000000001
     x6 = 0x0000000100f84000
     x7 = 0x0000000000000000
     x8 = 0x0000200000000000
     x9 = 0x000141a1e1630915 (0x00000001e1630915) (void *)0x01e1630c80000001
     x10 = 0x0000000000000000
     x11 = 0x000000000000002d
     x12 = 0x000000000000002d
     x13 = 0x0000000000000000
     x14 = 0x0000000000000000
     x15 = 0x00000001d5916e2d  "touchesBegan:withEvent:"
     x16 = 0x00000001a741147c  libobjc.A.dylib`objc_storeStrong
     x17 = 0x0000000000000000
     x18 = 0x0000000000000000
     x19 = 0x0000000151d0f530
     x20 = 0x0000000280e65ce0
     x21 = 0x0000000283c7b8d0
     x22 = 0x00000001d5916e2d  "touchesBegan:withEvent:"
     x23 = 0x0000000151d0d080
     x24 = 0x0000000280e65d40
     x25 = 0x0000000151d0d080
     x26 = 0x0000000283c7b8d0
     x27 = 0x00000001d590f8c0  "countByEnumeratingWithState:objects:count:"
     x28 = 0x0000000283c7b8d0
     fp = 0x000000016f2c9950
     lr = 0x0000000100b3a800  ARM64`-[ViewController touchesBegan:withEvent:] + 64 at ViewController.m:23:5
     sp = 0x000000016f2c9920
     pc = 0x0000000100b3a800  ARM64`-[ViewController touchesBegan:withEvent:] + 64 at ViewController.m:23:5
     cpsr = 0x80000000
     */
}

@end
