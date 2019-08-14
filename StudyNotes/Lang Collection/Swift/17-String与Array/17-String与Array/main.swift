//
//  main.swift
//  17-String与Array
//
//  Created by 朱双泉 on 2019/8/14.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 关于String的思考

do {
    /*
     0x100000f04 <+36>: leaq   0x8f(%rip), %rdi          ; "0123456789"
     0x100000f0b <+43>: movl   $0xa, %esi
     0x100000f10 <+48>: movl   $0x1, %edx
     0x100000f15 <+53>: callq  0x100000f58               ; symbol stub for: Swift.String.init(_builtinStringLiteral: Builtin.RawPointer, utf8CodeUnitCount: Builtin.Word, isASCII: Builtin.Int1) -> Swift.String
     0x100000f1a <+58>: movq   %rax, -0x10(%rbp)
     0x100000f1e <+62>: movq   %rdx, -0x8(%rbp)
     
     (lldb) register read rax
     rax = 0x3736353433323130
     (lldb) register read rdx
     rdx = 0xea00000000003938
     (lldb) register read rbp
     rbp = 0x00007ffeefbff4d0
     (lldb) x/2xg 0x00007ffeefbff4d0-0x10
     0x7ffeefbff4c0: 0x3736353433323130 0xea00000000003938
     (lldb) x 0x7ffeefbff4c0
     0x7ffeefbff4c0: 30 31 32 33 34 35 36 37 38 39 00 00 00 00 00 ea  0123456789......
     */
    var str1 = "0123456789"
    // 0x3736353433323130 0xea00000000003938
    print(Mems.memStr(ofVal: &str1))
    print(MemoryLayout.stride(ofValue: str1))
    
    /*
     (lldb) register read rbp
     rbp = 0x00007ffeefbff4d0
     (lldb) x/2xg 0x00007ffeefbff4d0-0x10
     0x7ffeefbff4c0: 0x3736353433323130 0xe900000000000038
     (lldb) x 0x7ffeefbff4c0
     0x7ffeefbff4c0: 30 31 32 33 34 35 36 37 38 00 00 00 00 00 00 e9  012345678.......
     */
    str1 = "012345678"
    
    /*
     0x7ffeefbff4c0: 30 31 32 33 34 35 36 37 38 39 41 42 43 44 45 ef  0123456789ABCDE.
     */
    str1 = "0123456789ABCDE"
    
    /*
     0x100000dc9 <+441>: leaq   0x39f0(%rip), %rdi        ; "0123456789ABCDEF"
     
     (lldb) x 0x100000d00+0x3ac0
     0x1000047c0: 30 31 32 33 34 35 36 37 38 39 41 42 43 44 45 46  0123456789ABCDEF
     
     0x100000dd0 <+448>: movl   $0x10, %esi // 字符串长度
     0x100000dd5 <+453>: movl   $0x1, %edx
     0x100000dda <+458>: callq  0x1000044e6               ; symbol stub for: Swift.String.init(_builtinStringLiteral: Builtin.RawPointer, utf8CodeUnitCount: Builtin.Word, isASCII: Builtin.Int1) -> Swift.String
     
     ->
     0x7fff66f57d55 <+37>:  cmpq   $0xf, %rsi // rsi 字符串长度 和 0xf 进行比较
     ...
     0x7fff66f57d7b <+75>:  movabsq $0x7fffffffffffffe0, %rdx ; imm = 0x7FFFFFFFFFFFFFE0
     0x7fff66f57d85 <+85>:  addq   %rdx, %rdi // rdi 字符串真实地址, rdx = rdi + 0x7fffffffffffffe0
     <-
     
     0x100000ddf <+463>: movq   %rax, -0x10(%rbp)
     0x100000de3 <+467>: movq   %rdx, -0x8(%rbp)
     
     (lldb) x 0x80000001000047a0-0x7fffffffffffffe0 // 字符串真实地址 = rdx - 0x7fffffffffffffe0
     0x1000047c0: 30 31 32 33 34 35 36 37 38 39 41 42 43 44 45 46  0123456789ABCDEF
     */
    str1 = "0123456789ABCDEF"
    // 0xd000000000000010 0x80000001000047a0
    print(Mems.memStr(ofVal: &str1))
}

do {
    /*
     0x100001c08 <+776>:  leaq   0x3bc2(%rip), %rdi        ; "01234567"
     0x100001c0f <+783>:  movl   $0x8, %esi
     
     (lldb) x 0x100001c0f+0x3bc2
     0x1000057d1: 30 31 32 33 34 35 36 37 00 0a 00 20 00 00 00 43  01234567... ...C
     */
    var str1 = "01234567"
    print(Mems.memStr(ofVal: &str1))
    
    /*
     0x100001c2d <+813>:  leaq   0x3b8c(%rip), %rdi        ; "0123456789ABCDEF"
     0x100001c34 <+820>:  movl   $0x10, %esi
     
     (lldb) x 0x100001c34+0x3b8c
     0x1000057c0: 30 31 32 33 34 35 36 37 38 39 41 42 43 44 45 46  0123456789ABCDEF
     */
    var str2 = "0123456789ABCDEF"
    // 0xd000000000000010 0x8000000100005780
    print(Mems.memStr(ofVal: &str2))
    
    var str3 = "0123456789ABCDEFGHIJ"
    // 0xd000000000000014 0x80000001000057a0
    print(Mems.memStr(ofVal: &str3))
}

do {
    var str1 = "01234567"
    // 0x3736353433323130 0xe800000000000000
    print(Mems.memStr(ofVal: &str1))
    str1.append("G")
    // 0x3736353433323130 0xe900000000000047
    print(Mems.memStr(ofVal: &str1))
    
    var str2 = "0123456789ABCDEF"
    /*
     字符串的真实地址 + 0x7fffffffffffffe0 = 0x8000000100005770
     字符串的真实地址 = 0x8000000100005770 - 0x7fffffffffffffe0
     0xd000000000000010 0x8000000100005770
     */
    print(Mems.memStr(ofVal: &str2))
    /*
     0x100001cac <+2380>: leaq   0x3b12(%rip), %rdi        ; "'G'"
     0x100001cb3 <+2387>: movl   $0x1, %esi
     0x100001cb8 <+2392>: movl   $0x1, %edx
     0x100001cbd <+2397>: callq  0x1000054b6               ; symbol stub for: Swift.String.init(_builtinStringLiteral: Builtin.RawPointer, utf8CodeUnitCount: Builtin.Word, isASCII: Builtin.Int1) -> Swift.String
     0x100001cc2 <+2402>: movq   %rax, %rdi
     0x100001cc5 <+2405>: movq   %rdx, %rsi
     0x100001cc8 <+2408>: leaq   -0x68(%rbp), %r13
     0x100001ccc <+2412>: movq   %rdx, -0x228(%rbp)
     0x100001cd3 <+2419>: callq  0x1000054bc               ; symbol stub for: Swift.String.append(Swift.String) -> ()
     */
    /*
     libsystem_malloc.dylib`malloc:
     0x7fff67c98766 <+0>:  pushq  %rbp
     0x7fff67c98767 <+1>:  movq   %rsp, %rbp
     0x7fff67c9876a <+4>:  pushq  %rbx
     0x7fff67c9876b <+5>:  pushq  %rax
     0x7fff67c9876c <+6>:  movq   %rdi, %rsi
     0x7fff67c9876f <+9>:  leaq   0x2c6d288a(%rip), %rdi    ; virtual_default_zone
     0x7fff67c98776 <+16>: callq  0x7fff67c98798            ; malloc_zone_malloc
     0x7fff67c9877b <+21>: movq   %rax, %rbx
     0x7fff67c9877e <+24>: testq  %rax, %rax
     0x7fff67c98781 <+27>: jne    0x7fff67c9878e            ; <+40>
     0x7fff67c98783 <+29>: callq  0x7fff67cb8204            ; symbol stub for: __error
     0x7fff67c98788 <+34>: movl   $0xc, (%rax)
     0x7fff67c9878e <+40>: movq   %rbx, %rax
     0x7fff67c98791 <+43>: addq   $0x8, %rsp
     0x7fff67c98795 <+47>: popq   %rbx
     0x7fff67c98796 <+48>: popq   %rbp
     0x7fff67c98797 <+49>: retq
     
     (lldb) bt
     * thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 3.1
     * frame #0: 0x00007fff67c98767 libsystem_malloc.dylib`malloc + 1
     frame #1: 0x00007fff67217b69 libswiftCore.dylib`swift_slowAlloc + 25
     frame #2: 0x00007fff67217be4 libswiftCore.dylib`_swift_allocObject_(swift::TargetHeapMetadata<swift::InProcess> const*, unsigned long, unsigned long) + 20
     frame #3: 0x00007fff67174aee libswiftCore.dylib`function signature specialization <Arg[2] = Dead> of static Swift.__StringStorage.(create in _A317BBF16F3432B4D1DDED3E0452DA4D)(capacity: Swift.Int, countAndFlags: Swift._StringObject.CountAndFlags) -> Swift.__StringStorage + 94
     frame #4: 0x00007fff670d6e45 libswiftCore.dylib`Swift._StringGuts.(prepareForAppendInPlace in _408A76AB043BD3EFBAB6FAAAAA9B4914)(otherUTF8Count: Swift.Int) -> () + 613
     frame #5: 0x00007fff670d7053 libswiftCore.dylib`Swift._StringGuts.append(Swift._StringGutsSlice) -> () + 227
     frame #6: 0x00007fff6717af8e libswiftCore.dylib`function signature specialization <Arg[0] = Exploded> of Swift._StringGuts.append(Swift._StringGuts) -> () + 142
     frame #7: 0x0000000100001d9d 17-String与Array`main at main.swift:153:10
     frame #8: 0x00007fff67ada2f5 libdyld.dylib`start + 1
     */
    /*
     (lldb) register read rbp
          rbp = 0x00007ffeefbff4d0
     (lldb) x/2xg 0x00007ffeefbff4d0-0x68
     0x7ffeefbff468: 0x0000000000000000 0x0000000000000000
     0xd000000000000010 0x8000000100005770
     (lldb) register read rax
          rax = 0x0000000100601450
     (lldb) x/2gx 0x7ffeefbff468
     0x7ffeefbff468: 0xf000000000000011 0x0000000100601450
     (lldb) x/10xg 0x0000000100601450
     0x100601450: 0x00007fff942a2f48 0x0000000000000002
     0x100601460: 0x0000000000000018 0xf000000000000011
     0x100601470: 0x3736353433323130 0x4645444342413938
     0x100601480: 0x00007fff8dbe0047 0x0000000000000000
     0x100601490: 0x000000000000000a 0x00007fff8ecbb020
     (lldb) x/100xb 0x0000000100601450
     0x100601450: 0x48 0x2f 0x2a 0x94 0xff 0x7f 0x00 0x00
     0x100601458: 0x02 0x00 0x00 0x00 0x00 0x00 0x00 0x00
     0x100601460: 0x18 0x00 0x00 0x00 0x00 0x00 0x00 0x00
     0x100601468: 0x11 0x00 0x00 0x00 0x00 0x00 0x00 0xf0
     0x100601470: 0x30 0x31 0x32 0x33 0x34 0x35 0x36 0x37
     0x100601478: 0x38 0x39 0x41 0x42 0x43 0x44 0x45 0x46
     0x100601480: 0x47 0x00 0xbe 0x8d 0xff 0x7f 0x00 0x00
     0x100601488: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
     0x100601490: 0x0a 0x00 0x00 0x00 0x00 0x00 0x00 0x00
     0x100601498: 0x20 0xb0 0xcb 0x8e 0xff 0x7f 0x00 0x00
     0x1006014a0: 0xc8 0x3c 0x3e 0x8f 0xff 0x7f 0x00 0x00
     0x1006014a8: 0x60 0x04 0x6a 0x8c 0xff 0x7f 0x00 0x00
     0x1006014b0: 0x58 0xf5 0xff 0x8d
     */
    str2.append("G")
    /*
     字符串的真实地址 = 0x000000010305fe00 + 0x20
     0xf000000000000011 0x0000000100601450
     
     (lldb) x 0x0000000100601450+0x20
     0x100601470: 30 31 32 33 34 35 36 37 38 39 41 42 43 44 45 46  0123456789ABCDEF
     0x100601480: 47 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00  G. .............
     */
    print(Mems.memStr(ofVal: &str2))
}
