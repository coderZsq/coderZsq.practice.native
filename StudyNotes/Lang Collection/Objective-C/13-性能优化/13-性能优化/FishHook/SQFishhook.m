//
//  SQFishhook.m
//  Interview
//
//  Created by 朱双泉 on 2020/11/20.
//

#import "SQFishhook.h"
#import "fishhook.h"

@implementation SQFishhook

+ (void)hook {
    // 需求! HOOK 系统的NSLog玩一下!
    // fishhook只能HOOK外部函数, 外部函数具有动态的特性!
    
    // 1. 查看mach-o, Lasy Symbol Pointers 的Offset
    // Offset 0x8000
    
    // 2. 通过lldb 查看当前载入内存的mach-o的内存地址
    // 地址 0x000000010e3f8000
//    (lldb) image list
//    [  0] D2F4B84C-F915-3D3E-93CA-C274A8940B9F 0x000000010e3f8000 /Users/zhushuangquan/Library/Developer/Xcode/DerivedData/Interview-enldaohnitllhlaxwvdhiyadsgao/Build/Products/Debug-iphonesimulator/Interview.app/Interview
    
    // 3. 调用NSLog系统进行符号绑定
    NSLog(@"1");
    
    // 4. 根据内存地址加偏移地址获取到绑定后的函数地址
//    (lldb) x 0x000000010e3f8000+0x8000
//    0x10e400000: b5 c3 81 20 ff 7f 00 00 74 91 80 20 ff 7f 00 00  ... ....t.. ....
//    0x10e400010: 9f 59 66 24 ff 7f 00 00 f4 a3 3f 0e 01 00 00 00  .Yf$......?.....
    
    // 5. 查看绑定后的汇编 小端模式, 从右往左
//    (lldb) dis -s 0x7fff2081c3b5
//    Foundation`NSLog:
//        0x7fff2081c3b5 <+0>:  pushq  %rbp
//        0x7fff2081c3b6 <+1>:  movq   %rsp, %rbp
//        0x7fff2081c3b9 <+4>:  subq   $0xd0, %rsp
//        0x7fff2081c3c0 <+11>: testb  %al, %al
//        0x7fff2081c3c2 <+13>: je     0x7fff2081c3ea            ; <+53>
//        0x7fff2081c3c4 <+15>: movaps %xmm0, -0xa0(%rbp)
//        0x7fff2081c3cb <+22>: movaps %xmm1, -0x90(%rbp)
    struct rebinding nslog;
    nslog.name = "NSLog";
    nslog.replacement = my_NSLog;
    nslog.replaced = (void *)&sys_nslog;
    
    struct rebinding rebs[1] = {nslog};
    
    // 6. fishhook进行重绑定符号
    rebind_symbols(rebs, 1);
    
    // 7. 再次查看符号表
//    (lldb) x 0x000000010e3f8000+0x8000
//    0x10e400000: 20 94 3f 0e 01 00 00 00 74 91 80 20 ff 7f 00 00   .?.....t.. ....
//    0x10e400010: 9f 59 66 24 ff 7f 00 00 ba 8a 0f 20 ff 7f 00 00  .Yf$....... ....
    
    // 8. 显示重绑定后的汇编函数
//    (lldb) dis -s 010e3f9420
//    Interview`my_NSLog:
//        0x10e3f9420 <+0>:  pushq  %rbp
//        0x10e3f9421 <+1>:  movq   %rsp, %rbp
//        0x10e3f9424 <+4>:  subq   $0x30, %rsp
//        0x10e3f9428 <+8>:  movq   $0x0, -0x8(%rbp)
//        0x10e3f9430 <+16>: leaq   -0x8(%rbp), %rax
//        0x10e3f9434 <+20>: movq   %rdi, -0x10(%rbp)
//        0x10e3f9438 <+24>: movq   %rax, %rdi
//        0x10e3f943b <+27>: movq   -0x10(%rbp), %rsi
    NSLog(@"2");
}

// 函数指针!
static void (*sys_nslog)(NSString *format, ...);

void my_NSLog(NSString *format, ...) {
    format = [format stringByAppendingString:@"\n勾上了!"];
    // 如何走到真正的NSLog去??
     sys_nslog(format);
}

+ (void)action {
    NSLog(@"屏幕被点击!");
}

@end
