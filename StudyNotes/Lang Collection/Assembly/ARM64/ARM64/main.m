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

void haha() {
    int a = 10;
    int b = 10;
}
/*
 0x10104a78c <+0>:  sub    sp, sp, #0x10             ; =0x10
 0x10104a790 <+4>:  mov    w8, #0xa
 0x10104a794 <+8>:  str    w8, [sp, #0xc]
 0x10104a798 <+12>: str    w8, [sp, #0x8]
 0x10104a79c <+16>: add    sp, sp, #0x10             ; =0x10
 0x10104a7a0 <+20>: ret
 */

void haha2() {
    int a = 10;
    int b = 10;
    printf("11");
}
/*
 0x101166754 <+0>:  sub    sp, sp, #0x20             ; =0x20
 0x101166758 <+4>:  stp    x29, x30, [sp, #0x10]
 0x10116675c <+8>:  add    x29, sp, #0x10            ; =0x10
 0x101166760 <+12>: mov    w8, #0xa
 0x101166764 <+16>: stur   w8, [x29, #-0x4]
 0x101166768 <+20>: str    w8, [sp, #0x8]
 0x10116676c <+24>: adrp   x0, 1
 0x101166770 <+28>: add    x0, x0, #0xf17            ; =0xf17
 0x101166774 <+32>: bl     0x101166b84               ; symbol stub for: printf
 0x101166778 <+36>: str    w0, [sp, #0x4]
 0x10116677c <+40>: ldp    x29, x30, [sp, #0x10]
 0x101166780 <+44>: add    sp, sp, #0x20             ; =0x20
 0x101166784 <+48>: ret
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
        
        /*
         int a = 8;
         mov x1, 0x000000016f8ff92c
         -> ldr x0, [x1]
         
         (lldb) p &a
         (int *) $0 = 0x000000016f8ff92c
         (lldb) c
         Process 1937 resuming
         (lldb) register read x1
         x1 = 0x000000016f8ff980
         (lldb) register write x1 0x000000016f8ff92c
         (lldb) register read x0
         x0 = 0x000000010096c048
         (lldb) si
         (lldb) register read x0
         x0 = 0x6f8ff98000000008
         (lldb) x 0x000000016f8ff92c
         0x16f8ff92c: 08 00 00 00 80 f9 8f 6f 01 00 00 00 01 00 00 00  .......o........
         0x16f8ff93c: 00 00 00 00 60 f9 8f 6f 01 00 00 00 b4 2b c7 a7  ....`..o.....+..
         */
        
        /*
         int a = 8;
         mov x2 0x000000016fa9792c
         -> ldp w0, w1, [x2, #0x10]
         (lldb) p &a
         (int *) $0 = 0x000000016fa9792c
         (lldb) c
         Process 1956 resuming
         (lldb) register write x2 0x000000016fa9792c
         (lldb) x 0x000000016fa9792c+0x10
         0x16fa9793c: 00 00 00 00 60 79 a9 6f 01 00 00 00 b4 2b c7 a7  ....`y.o.....+..
         0x16fa9794c: 01 00 00 00 b4 2b c7 a7 01 00 00 00 00 00 00 00  .....+..........
         (lldb) si
         (lldb) register read w0
         w0 = 0x00000000
         (lldb) register read w1
         w1 = 0x6fa97960
         */
        
        /*
         int a = 8;
         -> str w0, [x1]
         
         (lldb) p &a
         (int *) $0 = 0x000000016f6eb92c
         (lldb) c
         Process 1965 resuming
         (lldb) register write w0 5
         (lldb) register write x1 0x000000016f6eb92c
         (lldb) si
         
         a = 5
         */
        
        /*
         int a = 0;
         long b = 0;
         
         wzr 32bit 0寄存器
         xzr 64bit 0寄存器
         
         0x1005867c4 <+28>:  stur   wzr, [x29, #-0x14]
         0x1005867c8 <+32>:  stur   xzr, [x29, #-0x20]
         */
        
        /*
         pc = 8086 ip
         
         pc = 0x00000001006de7cc  ARM64`main + 28 at main.m:141:9
         ->  0x1006de7cc <+28>:  stur   x0, [x29, #-0x18]
         */
        
        /*
         lr / x30 链接寄存器 存储函数的返回地址
         
         (lldb) register read lr
         lr = 0x00000001007e27d4  ARM64`main + 36 at main.m:149:22
         (lldb) register read x30
         lr = 0x00000001007e27d4  ARM64`main + 36 at main.m:149:22
         
         0x1008d67d0 <+32>:  bl     0x1008d68b0               ; test
         
         (lldb) si
         (lldb) si
         (lldb) register read lr
         lr = 0x00000001008d67d4  ARM64`main + 36 at main.m:156:22
         (lldb) si
         (lldb) si
         
         0x1008d67d4 <+36>:  orr    w0, wzr, #0x2
         */
        
        test();
        NSLog(@"%d", add(2, 4));
        NSLog(@"%d", sub(6, 2));
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
