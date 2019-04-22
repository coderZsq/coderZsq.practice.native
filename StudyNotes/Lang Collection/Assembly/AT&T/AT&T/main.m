//
//  main.m
//  AT&T
//
//  Created by 朱双泉 on 2019/4/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sum.h"

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

int sum4(int a, int b) {
    int c = a + b;
    int d = c + 10;
    return d;
}
/*
 0x100000ee0 <+0>:  pushq  %rbp
 0x100000ee1 <+1>:  movq   %rsp, %rbp
 0x100000ee4 <+4>:  movl   %edi, -0x4(%rbp)
 0x100000ee7 <+7>:  movl   %esi, -0x8(%rbp)
 
 General Purpose Registers:
 rax = 0x0000000101006038
 rbx = 0x0000000000000000
 rcx = 0x0000000101006040
 rdx = 0x00007ffeefbff5c8
 rdi = 0x00000000 00000001
 rsi = 0x0000000000000002
 rbp = 0x00007ffeefbff560
 rsp = 0x00007ffeefbff560
 r8 = 0x0000000000000000
 r9 = 0x0000000000000000
 r10 = 0x00007ffeefbff6f0
 r11 = 0x00007fff6553cf4f  libobjc.A.dylib`objc_autoreleasePoolPush
 r12 = 0x0000000000000000
 r13 = 0x0000000000000000
 r14 = 0x0000000000000000
 r15 = 0x0000000000000000
 rip = 0x0000000100000eea  AT&T`sum4 + 10 at main.m:106:13
 rflags = 0x0000000000000202
 cs = 0x000000000000002b
 fs = 0x0000000000000000
 gs = 0x0000000000000000
 
 0x100000eea <+10>: movl   -0x4(%rbp), %esi
 0x100000eed <+13>: addl   -0x8(%rbp), %esi
 0x100000ef0 <+16>: movl   %esi, -0xc(%rbp)
 0x100000ef3 <+19>: movl   -0xc(%rbp), %esi
 0x100000ef6 <+22>: addl   $0xa, %esi
 0x100000ef9 <+25>: movl   %esi, -0x10(%rbp)
 0x100000efc <+28>: movl   -0x10(%rbp), %eax
 0x100000eff <+31>: popq   %rbp
 0x100000f00 <+32>: retq
 */

void test() {}

int sum5(int a, int b) {
    int c = a + b;
    int d = c + 10;
    test();
    return d;
}
/*
 0x100000ee0 <+0>:  pushq  %rbp
 0x100000ee1 <+1>:  movq   %rsp, %rbp
 0x100000ee4 <+4>:  subq   $0x10, %rsp
 -> 0x100000ee8 <+8>:  movl   %edi, -0x4(%rbp)
 0x100000eeb <+11>: movl   %esi, -0x8(%rbp)
 0x100000eee <+14>: movl   -0x4(%rbp), %esi
 0x100000ef1 <+17>: addl   -0x8(%rbp), %esi
 0x100000ef4 <+20>: movl   %esi, -0xc(%rbp)
 0x100000ef7 <+23>: movl   -0xc(%rbp), %esi
 0x100000efa <+26>: addl   $0xa, %esi
 0x100000efd <+29>: movl   %esi, -0x10(%rbp)
 0x100000f00 <+32>: callq  0x100000ed0               ; test at main.m:150
 0x100000f05 <+37>: movl   -0x10(%rbp), %eax
 -> 0x100000f08 <+40>: addq   $0x10, %rsp
 0x100000f0c <+44>: popq   %rbp
 0x100000f0d <+45>: retq
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
        
        /*
         int a = 10;
         if (a > 10) {
         NSLog(@"1");
         } else {
         NSLog(@"2");
         }
         0x100000f0b <+27>:  movl   $0xa, -0x14(%rbp)
         0x100000f12 <+34>:  cmpl   $0xa, -0x14(%rbp)
         0x100000f16 <+38>:  movq   %rax, -0x20(%rbp)
         0x100000f1a <+42>:  jle    0x100000f36               ; <+70> at main.m
         0x100000f20 <+48>:  leaq   0x101(%rip), %rax         ; @"'1'"
         0x100000f27 <+55>:  movq   %rax, %rdi
         0x100000f2a <+58>:  movb   $0x0, %al
         0x100000f2c <+60>:  callq  0x100000f58               ; symbol stub for: NSLog
         0x100000f31 <+65>:  jmp    0x100000f47               ; <+87> at main.m:230:5
         0x100000f36 <+70>:  leaq   0x10b(%rip), %rax         ; @"'2'"
         0x100000f3d <+77>:  movq   %rax, %rdi
         0x100000f40 <+80>:  movb   $0x0, %al
         0x100000f42 <+82>:  callq  0x100000f58               ; symbol stub for: NSLog
         */
        
        /*
         int a = 10;
         if (a > 10) {
         NSLog(@"1");
         } else if (a > 5) {
         NSLog(@"2");
         } else {
         NSLog(@"3");
         }
         0x100000eeb <+27>:  movl   $0xa, -0x14(%rbp)
         0x100000ef2 <+34>:  cmpl   $0xa, -0x14(%rbp)
         0x100000ef6 <+38>:  movq   %rax, -0x20(%rbp)
         0x100000efa <+42>:  jle    0x100000f16               ; <+70> at main.m:249:22
         0x100000f00 <+48>:  leaq   0x121(%rip), %rax         ; @"'1'"
         0x100000f07 <+55>:  movq   %rax, %rdi
         0x100000f0a <+58>:  movb   $0x0, %al
         0x100000f0c <+60>:  callq  0x100000f5e               ; symbol stub for: NSLog
         0x100000f11 <+65>:  jmp    0x100000f4c               ; <+124> at main.m:255:5
         0x100000f16 <+70>:  cmpl   $0x5, -0x14(%rbp)
         0x100000f1a <+74>:  jle    0x100000f36               ; <+102> at main.m
         0x100000f20 <+80>:  leaq   0x121(%rip), %rax         ; @"'2'"
         0x100000f27 <+87>:  movq   %rax, %rdi
         0x100000f2a <+90>:  movb   $0x0, %al
         0x100000f2c <+92>:  callq  0x100000f5e               ; symbol stub for: NSLog
         0x100000f31 <+97>:  jmp    0x100000f47               ; <+119> at main.m
         0x100000f36 <+102>: leaq   0x12b(%rip), %rax         ; @"'3'"
         0x100000f3d <+109>: movq   %rax, %rdi
         0x100000f40 <+112>: movb   $0x0, %al
         0x100000f42 <+114>: callq  0x100000f5e               ; symbol stub for: NSLog
         0x100000f47 <+119>: jmp    0x100000f4c               ; <+124> at main.m:255:5
         */
        
        /*
         for (int i = 0; i < 5; i++) {
         NSLog(@"1");
         }
         0x100000f1b <+27>: movl   $0x0, -0x14(%rbp)
         0x100000f22 <+34>: movq   %rax, -0x20(%rbp)
         0x100000f26 <+38>: cmpl   $0x5, -0x14(%rbp)
         0x100000f2a <+42>: jge    0x100000f4f               ; <+79> at main.m:281:5
         0x100000f30 <+48>: leaq   0xf1(%rip), %rax          ; @"'1'"
         0x100000f37 <+55>: movq   %rax, %rdi
         0x100000f3a <+58>: movb   $0x0, %al
         0x100000f3c <+60>: callq  0x100000f60               ; symbol stub for: NSLog
         0x100000f41 <+65>: movl   -0x14(%rbp), %eax
         0x100000f44 <+68>: addl   $0x1, %eax
         0x100000f47 <+71>: movl   %eax, -0x14(%rbp)
         0x100000f4a <+74>: jmp    0x100000f26               ; <+38> at main.m:278:27
         */
        
        /*
         int a = 4;
         if (a == 1) {
             NSLog(@"1");
         } else if (a == 2) {
             NSLog(@"2");
         } else if (a == 3) {
             NSLog(@"3");
         } else if (a == 4) {
             NSLog(@"4");
         } else if (a == 5) {
             NSLog(@"5");
         } else {
             NSLog(@"else");
         }
         0x100000e6b <+27>:  movl   $0x4, -0x14(%rbp)
         0x100000e72 <+34>:  cmpl   $0x1, -0x14(%rbp)
         0x100000e76 <+38>:  movq   %rax, -0x20(%rbp)
         0x100000e7a <+42>:  jne    0x100000e96               ; <+70> at main.m:300:22
         0x100000e80 <+48>:  leaq   0x1a1(%rip), %rax         ; @"'1'"
         0x100000e87 <+55>:  movq   %rax, %rdi
         0x100000e8a <+58>:  movb   $0x0, %al
         0x100000e8c <+60>:  callq  0x100000f4c               ; symbol stub for: NSLog
         0x100000e91 <+65>:  jmp    0x100000f3b               ; <+235> at main.m:376:5
         0x100000e96 <+70>:  cmpl   $0x2, -0x14(%rbp)
         0x100000e9a <+74>:  jne    0x100000eb6               ; <+102> at main.m:302:22
         0x100000ea0 <+80>:  leaq   0x1a1(%rip), %rax         ; @"'2'"
         0x100000ea7 <+87>:  movq   %rax, %rdi
         0x100000eaa <+90>:  movb   $0x0, %al
         0x100000eac <+92>:  callq  0x100000f4c               ; symbol stub for: NSLog
         0x100000eb1 <+97>:  jmp    0x100000f36               ; <+230> at main.m
         0x100000eb6 <+102>: cmpl   $0x3, -0x14(%rbp)
         0x100000eba <+106>: jne    0x100000ed6               ; <+134> at main.m:304:22
         0x100000ec0 <+112>: leaq   0x1a1(%rip), %rax         ; @"'3'"
         0x100000ec7 <+119>: movq   %rax, %rdi
         0x100000eca <+122>: movb   $0x0, %al
         0x100000ecc <+124>: callq  0x100000f4c               ; symbol stub for: NSLog
         0x100000ed1 <+129>: jmp    0x100000f31               ; <+225> at main.m
         0x100000ed6 <+134>: cmpl   $0x4, -0x14(%rbp)
         0x100000eda <+138>: jne    0x100000ef6               ; <+166> at main.m:306:22
         0x100000ee0 <+144>: leaq   0x1a1(%rip), %rax         ; @"'4'"
         0x100000ee7 <+151>: movq   %rax, %rdi
         0x100000eea <+154>: movb   $0x0, %al
         0x100000eec <+156>: callq  0x100000f4c               ; symbol stub for: NSLog
         0x100000ef1 <+161>: jmp    0x100000f2c               ; <+220> at main.m
         0x100000ef6 <+166>: cmpl   $0x5, -0x14(%rbp)
         0x100000efa <+170>: jne    0x100000f16               ; <+198> at main.m
         0x100000f00 <+176>: leaq   0x1a1(%rip), %rax         ; @"'5'"
         0x100000f07 <+183>: movq   %rax, %rdi
         0x100000f0a <+186>: movb   $0x0, %al
         0x100000f0c <+188>: callq  0x100000f4c               ; symbol stub for: NSLog
         0x100000f11 <+193>: jmp    0x100000f27               ; <+215> at main.m
         0x100000f16 <+198>: leaq   0x1ab(%rip), %rax         ; @"else"
         0x100000f1d <+205>: movq   %rax, %rdi
         0x100000f20 <+208>: movb   $0x0, %al
         0x100000f22 <+210>: callq  0x100000f4c               ; symbol stub for: NSLog
         0x100000f27 <+215>: jmp    0x100000f2c               ; <+220> at main.m
         0x100000f2c <+220>: jmp    0x100000f31               ; <+225> at main.m
         0x100000f31 <+225>: jmp    0x100000f36               ; <+230> at main.m
         0x100000f36 <+230>: jmp    0x100000f3b               ; <+235> at main.m:376:5
         */
        
        /*
        int a = 4;
        switch (a) {
            case 1:
                NSLog(@"1");
                break;
            case 2:
                NSLog(@"2");
                break;
            case 3:
                NSLog(@"3");
                break;
            case 4:
                NSLog(@"4");
                break;
            case 5:
                NSLog(@"5");
                break;
            default:
                break;
        }
         0x100000e8b <+27>:  movl   $0x4, -0x14(%rbp)
         0x100000e92 <+34>:  movl   -0x14(%rbp), %edi
         0x100000e95 <+37>:  decl   %edi
         0x100000e97 <+39>:  movl   %edi, %esi
         0x100000e99 <+41>:  subl   $0x4, %edi
         0x100000e9c <+44>:  movq   %rax, -0x20(%rbp)
         0x100000ea0 <+48>:  movq   %rsi, -0x28(%rbp)
         0x100000ea4 <+52>:  movl   %edi, -0x2c(%rbp)
         -> 0x100000ea7 <+55>:  ja     0x100000f2f               ; <+191> at main.m:377:17
         0x100000ead <+61>:  leaq   0x94(%rip), %rax          ; main + 216
         0x100000eb4 <+68>:  movq   -0x28(%rbp), %rcx
                             (lldb) po/d $rcx -> 3 //变量和最小条件的差值
         0x100000eb8 <+72>:  movslq (%rax,%rcx,4), %rdx
                             mov    rax, [rax + rcx * 4] //连续的地址 空间换时间
         0x100000ebc <+76>:  addq   %rax, %rdx
         0x100000ebf <+79>:  jmpq   *%rdx
                             (lldb) po/x $rdx -> 0x0000000100000f03
         0x100000ec1 <+81>:  leaq   0x160(%rip), %rax         ; @"'1'"
         0x100000ec8 <+88>:  movq   %rax, %rdi
         0x100000ecb <+91>:  movb   $0x0, %al
         0x100000ecd <+93>:  callq  0x100000f5c               ; symbol stub for: NSLog
         0x100000ed2 <+98>:  jmp    0x100000f34               ; <+196> at main.m:382:5
         0x100000ed7 <+103>: leaq   0x16a(%rip), %rax         ; @"'2'"
         0x100000ede <+110>: movq   %rax, %rdi
         0x100000ee1 <+113>: movb   $0x0, %al
         0x100000ee3 <+115>: callq  0x100000f5c               ; symbol stub for: NSLog
         0x100000ee8 <+120>: jmp    0x100000f34               ; <+196> at main.m:382:5
         0x100000eed <+125>: leaq   0x174(%rip), %rax         ; @"'3'"
         0x100000ef4 <+132>: movq   %rax, %rdi
         0x100000ef7 <+135>: movb   $0x0, %al
         0x100000ef9 <+137>: callq  0x100000f5c               ; symbol stub for: NSLog
         0x100000efe <+142>: jmp    0x100000f34               ; <+196> at main.m:382:5
         0x100000f03 <+147>: leaq   0x17e(%rip), %rax         ; @"'4'"
         0x100000f0a <+154>: movq   %rax, %rdi
         0x100000f0d <+157>: movb   $0x0, %al
         0x100000f0f <+159>: callq  0x100000f5c               ; symbol stub for: NSLog
         0x100000f14 <+164>: jmp    0x100000f34               ; <+196> at main.m:382:5
         0x100000f19 <+169>: leaq   0x188(%rip), %rax         ; @"'5'"
         0x100000f20 <+176>: movq   %rax, %rdi
         0x100000f23 <+179>: movb   $0x0, %al
         0x100000f25 <+181>: callq  0x100000f5c               ; symbol stub for: NSLog
         0x100000f2a <+186>: jmp    0x100000f34               ; <+196> at main.m:382:5
         0x100000f2f <+191>: jmp    0x100000f34               ; <+196> at main.m:382:5
         */
        
        /*
        NSLog(@"%d", sum6(1, 2));
        AT&T`sum6:
        0x100000f52 <+0>: movq   %rdi, %rax
        0x100000f55 <+3>: addq   %rsi, %rax
        0x100000f58 <+6>: retq
         */
        
        int num1 = 1;
        int num2 = 2;
        int result;
        __asm__(
            "addq %%rbx, %%rax"
                : "=a"(result)
                : "a"(num1), "b"(num2)
        );
        NSLog(@"%d", result);
     }
    return 0;
}
