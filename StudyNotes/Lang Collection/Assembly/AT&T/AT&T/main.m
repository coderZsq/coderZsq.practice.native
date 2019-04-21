//
//  main.m
//  AT&T
//
//  Created by 朱双泉 on 2019/4/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

int sum(int a, int b) {
    return a + b;
}
/*
 0x100000ef0 <+0>:  pushq  %rbp
 0x100000ef1 <+1>:  movq   %rsp, %rbp
 0x100000ef4 <+4>:  movl   %edi, -0x4(%rbp)
 0x100000ef7 <+7>:  movl   %esi, -0x8(%rbp)
 0x100000efa <+10>: movl   -0x4(%rbp), %esi
 0x100000efd <+13>: addl   -0x8(%rbp), %esi
 0x100000f00 <+16>: movl   %esi, %eax
 0x100000f02 <+18>: popq   %rbp
 0x100000f03 <+19>: retq
 */
/*
 (lldb) register read/d
 General Purpose Registers:
 rax = 3
 rbx = 0
 rcx = 4303368256
 rdx = 140732920755656
 rdi = 1
 rsi = 3
 rbp = 140732920755552
 rsp = 140732920755552
 r8 = 0
 r9 = 0
 r10 = 140732920755952
 r11 = 140734893379407  libobjc.A.dylib`objc_autoreleasePoolPush
 r12 = 0
 r13 = 0
 r14 = 0
 r15 = 0
 rip = 4294971138  AT&T`sum + 18 at main.m:12:5
 rflags = 518
 cs = 43
 fs = 0
 gs = 0
 */

int sum2(int a, int b, int c, int d, int e, int f, int g) {
    return a + b;
}
/*
 0x100000ec0 <+0>:  pushq  %rbp
 0x100000ec1 <+1>:  movq   %rsp, %rbp
 0x100000ec4 <+4>:  movl   0x10(%rbp), %eax
 0x100000ec7 <+7>:  movl   %edi, -0x4(%rbp)
 0x100000eca <+10>: movl   %esi, -0x8(%rbp)
 0x100000ecd <+13>: movl   %edx, -0xc(%rbp)
 0x100000ed0 <+16>: movl   %ecx, -0x10(%rbp)
 0x100000ed3 <+19>: movl   %r8d, -0x14(%rbp)
 0x100000ed7 <+23>: movl   %r9d, -0x18(%rbp)
 0x100000edb <+27>: movl   -0x4(%rbp), %ecx
 0x100000ede <+30>: addl   -0x8(%rbp), %ecx
 0x100000ee1 <+33>: movl   %eax, -0x1c(%rbp)
 0x100000ee4 <+36>: movl   %ecx, %eax
 0x100000ee6 <+38>: popq   %rbp
 0x100000ee7 <+39>: retq
 */

int sum3(int a, int b, int c, int d, int e, int f, int g, int h, int i, int j, int k) {
    return a + b;
}
/*
 0x100000e80 <+0>:  pushq  %rbp
 0x100000e81 <+1>:  movq   %rsp, %rbp
 0x100000e84 <+4>:  pushq  %r14
 0x100000e86 <+6>:  pushq  %rbx
 0x100000e87 <+7>:  movl   0x30(%rbp), %eax
 0x100000e8a <+10>: movl   0x28(%rbp), %r10d
 0x100000e8e <+14>: movl   0x20(%rbp), %r11d
 0x100000e92 <+18>: movl   0x18(%rbp), %ebx
 0x100000e95 <+21>: movl   0x10(%rbp), %r14d
 0x100000e99 <+25>: movl   %edi, -0x14(%rbp)
 0x100000e9c <+28>: movl   %esi, -0x18(%rbp)
 0x100000e9f <+31>: movl   %edx, -0x1c(%rbp)
 0x100000ea2 <+34>: movl   %ecx, -0x20(%rbp)
 0x100000ea5 <+37>: movl   %r8d, -0x24(%rbp)
 0x100000ea9 <+41>: movl   %r9d, -0x28(%rbp)
 0x100000ead <+45>: movl   -0x14(%rbp), %ecx
 0x100000eb0 <+48>: addl   -0x18(%rbp), %ecx
 0x100000eb3 <+51>: movl   %eax, -0x2c(%rbp)
 0x100000eb6 <+54>: movl   %ecx, %eax
 0x100000eb8 <+56>: movl   %r14d, -0x30(%rbp)
 0x100000ebc <+60>: movl   %ebx, -0x34(%rbp)
 0x100000ebf <+63>: movl   %r11d, -0x38(%rbp)
 0x100000ec3 <+67>: movl   %r10d, -0x3c(%rbp)
 0x100000ec7 <+71>: popq   %rbx
 0x100000ec8 <+72>: popq   %r14
 0x100000eca <+74>: popq   %rbp
 0x100000ecb <+75>: retq
 */

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /*
         int a = 10;
         int b = 10;
         int c = a + b;
         NSLog(@"%d", c);
         0x100000f32 <+34>: movl   $0xa, -0x14(%rbp)
                            mov    [rbp - 0x14], 0xa
         0x100000f39 <+41>: movl   $0xa, -0x18(%rbp)
         0x100000f40 <+48>: movl   -0x14(%rbp), %edi
         0x100000f43 <+51>: addl   -0x18(%rbp), %edi
         */
        
        /*
         int c = sum(1, 2);
         NSLog(@"%d", c);
         0x100000f2b <+27>: movl   $0x1, %edi
         0x100000f30 <+32>: movl   $0x2, %esi
         0x100000f35 <+37>: movq   %rax, -0x20(%rbp)
         0x100000f39 <+41>: callq  0x100000ef0
         */
        
        /*
         int c = sum2(1, 2, 3, 4, 5, 6, 7);
         NSLog(@"%d", c);
         0x100000f0b <+27>:  movl   $0x1, %edi
         0x100000f10 <+32>:  movl   $0x2, %esi
         0x100000f15 <+37>:  movl   $0x3, %edx
         0x100000f1a <+42>:  movl   $0x4, %ecx
         0x100000f1f <+47>:  movl   $0x5, %r8d
         0x100000f25 <+53>:  movl   $0x6, %r9d
         0x100000f2b <+59>:  movl   $0x7, (%rsp)
         0x100000f32 <+66>:  movq   %rax, -0x20(%rbp)
         0x100000f36 <+70>:  callq  0x100000ec0               ; sum2 at main.m:51
         */
        
        /*
         int c = sum3(LONG_MAX, LONG_MAX, LONG_MAX, LONG_MAX, LONG_MAX, LONG_MAX, LONG_MAX, LONG_MAX, LONG_MAX, LONG_MAX, LONG_MAX);
         NSLog(@"%d", c);
         0x100000eeb <+27>:  movl   $0xffffffff, %edi         ; imm = 0xFFFFFFFF
         0x100000ef0 <+32>:  movl   %edi, -0x18(%rbp)
         0x100000ef3 <+35>:  movl   -0x18(%rbp), %esi
         0x100000ef6 <+38>:  movl   -0x18(%rbp), %edx
         0x100000ef9 <+41>:  movl   -0x18(%rbp), %ecx
         0x100000efc <+44>:  movl   -0x18(%rbp), %r8d
         0x100000f00 <+48>:  movl   -0x18(%rbp), %r9d
         0x100000f04 <+52>:  movl   $0xffffffff, (%rsp)       ; imm = 0xFFFFFFFF
         0x100000f0b <+59>:  movl   $0xffffffff, 0x8(%rsp)    ; imm = 0xFFFFFFFF
         0x100000f13 <+67>:  movl   $0xffffffff, 0x10(%rsp)   ; imm = 0xFFFFFFFF
         0x100000f1b <+75>:  movl   $0xffffffff, 0x18(%rsp)   ; imm = 0xFFFFFFFF
         0x100000f23 <+83>:  movl   $0xffffffff, 0x20(%rsp)   ; imm = 0xFFFFFFFF
         0x100000f2b <+91>:  movq   %rax, -0x20(%rbp)
         0x100000f2f <+95>:  callq  0x100000e80               ; sum3 at main.m:72
         */
        
        /*
         NSLog(@"%ld", sizeof(int));
         0x100000f32 <+34>: movl   $0x4, %edi
         */
        
        /*
         NSLog(@"%ld", sizeof(long));
         0x100000f32 <+34>: movl   $0x8, %edi
         */
        
        /*
         int a = 1;
         int c = a++ + a++ + a++;
         NSLog(@"%d", c);
         
         -0x14(%rbp) = 4 // a 的值
         %edi = 6 // 表达式之前的值
         %ecx = 3 // 表达式之后的值
         %edx = 4 // 记录 a 的值
         -0x18(%rbp) = 6 // c 的值
         
         0x100000f12 <+34>:  movl   $0x1, -0x14(%rbp)
         0x100000f19 <+41>:  movl   -0x14(%rbp), %edi
         0x100000f1c <+44>:  movl   %edi, %ecx
         0x100000f1e <+46>:  addl   $0x1, %ecx
         0x100000f21 <+49>:  movl   %ecx, -0x14(%rbp)
         0x100000f24 <+52>:  movl   -0x14(%rbp), %ecx
         0x100000f27 <+55>:  movl   %ecx, %edx
         0x100000f29 <+57>:  addl   $0x1, %edx
         0x100000f2c <+60>:  movl   %edx, -0x14(%rbp)
         0x100000f2f <+63>:  addl   %ecx, %edi
         0x100000f31 <+65>:  movl   -0x14(%rbp), %ecx
         0x100000f34 <+68>:  movl   %ecx, %edx
         0x100000f36 <+70>:  addl   $0x1, %edx
         0x100000f39 <+73>:  movl   %edx, -0x14(%rbp)
         0x100000f3c <+76>:  addl   %ecx, %edi
         0x100000f3e <+78>:  movl   %edi, -0x18(%rbp)
         */
        
        /*
         int a = 1;
         int c = ++a + ++a + ++a;
         NSLog(@"%d", c);
         
         -0x14(%rbp) = 4
         %edi = 9
         %ecx 4
         
         0x100000f12 <+34>:  movl   $0x1, -0x14(%rbp)
         0x100000f19 <+41>:  movl   -0x14(%rbp), %edi
         0x100000f1c <+44>:  addl   $0x1, %edi
         0x100000f1f <+47>:  movl   %edi, -0x14(%rbp)
         0x100000f22 <+50>:  movl   -0x14(%rbp), %ecx
         0x100000f25 <+53>:  addl   $0x1, %ecx
         0x100000f28 <+56>:  movl   %ecx, -0x14(%rbp)
         0x100000f2b <+59>:  addl   %ecx, %edi
         0x100000f2d <+61>:  movl   -0x14(%rbp), %ecx
         0x100000f30 <+64>:  addl   $0x1, %ecx
         0x100000f33 <+67>:  movl   %ecx, -0x14(%rbp)
         0x100000f36 <+70>:  addl   %ecx, %edi
         0x100000f38 <+72>:  movl   %edi, -0x18(%rbp)
         */
    }
    return 0;
}
