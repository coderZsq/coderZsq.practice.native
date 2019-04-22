//
//  main.m
//  ARM64
//
//  Created by 朱双泉 on 2019/4/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "arm.h"

void mytest() {
    int a = 10;
    int b = 20;
    NSLog(@"%d", a + b);
}
/*
 0x1006ce758 <+0>:  sub    sp, sp, #0x20             ; =0x20
 0x1006ce75c <+4>:  stp    x29, x30, [sp, #0x10]
 0x1006ce760 <+8>:  add    x29, sp, #0x10            ; =0x10
 0x1006ce764 <+12>: mov    w8, #0xa
 0x1006ce768 <+16>: stur   w8, [x29, #-0x4]
 0x1006ce76c <+20>: mov    w8, #0x14
 0x1006ce770 <+24>: str    w8, [sp, #0x8]
 0x1006ce774 <+28>: ldur   w8, [x29, #-0x4]
 0x1006ce778 <+32>: ldr    w9, [sp, #0x8]
 0x1006ce77c <+36>: add    w8, w8, w9
 0x1006ce780 <+40>: mov    x0, x8
 0x1006ce784 <+44>: mov    x10, sp
 0x1006ce788 <+48>: str    x0, [x10]
 0x1006ce78c <+52>: adrp   x0, 2
 0x1006ce790 <+56>: add    x0, x0, #0x60             ; =0x60
 0x1006ce794 <+60>: bl     0x1006ceb30               ; symbol stub for: NSLog
 0x1006ce798 <+64>: ldp    x29, x30, [sp, #0x10]
 0x1006ce79c <+68>: add    sp, sp, #0x20             ; =0x20
 0x1006ce7a0 <+72>: ret
 */

int main(int argc, char * argv[]) {
    @autoreleasepool {
        /*
         mytest();
         0x1006ce7c4 <+32>:  bl     0x1006ce758               ; mytest at main.m:13
         */
        
        /*
         int a = 20;
         int b = 10;
         if (a > b) {
            printf("a > b");
         } else {
            NSLog(@"a <= b");
         }
         0x1002ce77c <+28>:  mov    w8, #0x14
         0x1002ce780 <+32>:  stur   w8, [x29, #-0x14]
         0x1002ce784 <+36>:  mov    w8, #0xa
         0x1002ce788 <+40>:  stur   w8, [x29, #-0x18]
         0x1002ce78c <+44>:  ldur   w8, [x29, #-0x14]
         0x1002ce790 <+48>:  ldur   w9, [x29, #-0x18]
         0x1002ce794 <+52>:  cmp    w8, w9
         0x1002ce798 <+56>:  str    x0, [sp, #0x20]
         0x1002ce79c <+60>:  b.le   0x1002ce7b4               ; <+84> at main.m:20:13
         0x1002ce7a0 <+64>:  adrp   x0, 1
         0x1002ce7a4 <+68>:  add    x0, x0, #0xf14            ; =0xf14
         0x1002ce7a8 <+72>:  bl     0x1002ceb84               ; symbol stub for: printf
         0x1002ce7ac <+76>:  str    w0, [sp, #0x1c]
         0x1002ce7b0 <+80>:  b      0x1002ce7c0               ; <+96> at main.m:24:9
         0x1002ce7b4 <+84>:  adrp   x0, 2
         0x1002ce7b8 <+88>:  add    x0, x0, #0x68             ; =0x68
         0x1002ce7bc <+92>:  bl     0x1002ceb0c               ; symbol stub for: NSLog
         */
        
        test();
        NSLog(@"%d", add(2, 4));
        NSLog(@"%d", sub(6, 2));
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
