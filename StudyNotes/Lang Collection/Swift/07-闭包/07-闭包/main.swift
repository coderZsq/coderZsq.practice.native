//
//  main.swift
//  07-闭包
//
//  Created by 朱双泉 on 2019/8/8.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 闭包表达式 (Closure Expression)

do {
    func sum(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
}

do {
    var fn = {
        (v1: Int, v2: Int) -> Int in
        return v1 + v2
    }
    fn(10, 20)
}

do {
    {
        (v1: Int, v2: Int) -> Int in
        return v1 + v2
    }(10, 20)
}

// MARK: - 闭包表达式的简写

do {
    func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
        print(fn(v1, v2))
    }
    
    exec(v1: 10, v2: 20, fn: {
        (v1: Int, v2: Int) -> Int in
        return v1 + v2
    })
    
    exec(v1: 10, v2: 20, fn: {
        v1, v2 in return v1 + v2
    })
    
    exec(v1: 10, v2: 20, fn: {
        v1, v2 in v1 + v2
    })
    
    exec(v1: 10, v2: 20, fn: { $0 + $1 })
    
    exec(v1: 10, v2: 20, fn: +)
}

// MARK: - 尾随闭包

do {
    func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
        print(fn(v1, v2))
    }
    
    exec(v1: 10, v2: 20) {
        $0 + $1
    }
}

do {
    func exec(fn: (Int, Int) -> Int) {
        print(fn(1, 2))
    }
    
    exec(fn: { $0 + $1 })
    exec() { $0 + $1 }
    exec { $0 + $1 }
}

// MARK: - 示例 - 数组的排序

do {
    // @inlinable public mutating func sort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows
    
    func cmp(i1: Int, i2: Int) -> Bool {
        // 大的排在前面
        return i1 > i2
    }
    
    var nums = [11, 2, 18, 6, 5, 68, 45]
    nums.sort(by: cmp)
    print(nums)
    
    nums.sort(by: {
        (i1: Int, i2: Int) -> Bool in
        return i1 < i2
    })
    
    nums.sort(by: { i1, i2 in return i1 < i2 })
    nums.sort(by: { i1, i2 in i1 < i2 })
    nums.sort(by: { $0 < $1 })
    nums.sort(by: <)
    nums.sort() { $0 < $1 }
    nums.sort { $0 < $1 }
    print(nums)
}

// MARK: - 忽略参数

do {
    func exec(fn: (Int, Int) -> Int) {
        print(fn(1, 2))
    }
    exec { _, _ in 10 }
}

// MARK: - 闭包 (Closure)

do {
    /*
     07-闭包`getFn #1 () in :
     0x100004e30 <+0>:  pushq  %rbp
     0x100004e31 <+1>:  movq   %rsp, %rbp
     0x100004e34 <+4>:  subq   $0x20, %rsp
     0x100004e38 <+8>:  leaq   0x32c1(%rip), %rdi
     0x100004e3f <+15>: movl   $0x18, %esi // 分配空间
     0x100004e44 <+20>: movl   $0x7, %edx
     0x100004e49 <+25>: callq  0x1000078e6               ; symbol stub for: swift_allocObject
     0x100004e4e <+30>: movq   %rax, %rdx
     0x100004e51 <+33>: addq   $0x10, %rdx
     0x100004e55 <+37>: movq   %rdx, %rsi
     0x100004e58 <+40>: movq   $0x0, 0x10(%rax) // 赋值 num 0
     0x100004e60 <+48>: movq   %rax, %rdi
     0x100004e63 <+51>: movq   %rax, -0x8(%rbp)
     0x100004e67 <+55>: movq   %rdx, -0x10(%rbp)
     0x100004e6b <+59>: callq  0x10000792e               ; symbol stub for: swift_retain
     0x100004e70 <+64>: movq   -0x8(%rbp), %rdi
     0x100004e74 <+68>: movq   %rax, -0x18(%rbp)
     0x100004e78 <+72>: callq  0x100007928               ; symbol stub for: swift_release
     0x100004e7d <+77>: movq   -0x10(%rbp), %rax
     0x100004e81 <+81>: leaq   0x29e8(%rip), %rax        ; partial apply forwarder for plus #1 (Swift.Int) -> Swift.Int in getFn #1 () -> (Swift.Int) -> Swift.Int in _7_闭包 at <compiler-generated>
     0x100004e88 <+88>: movq   -0x8(%rbp), %rdx
     0x100004e8c <+92>: addq   $0x20, %rsp
     0x100004e90 <+96>: popq   %rbp
     0x100004e91 <+97>: retq
     */
    typealias Fn = (Int) -> Int
    func getFn() -> Fn {
        var num = 0
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
        return plus
    }
    var fn = getFn()
    print(fn(1))
    print(fn(2))
    print(fn(3))
    print(fn(4))
}

do {
    /*
     07-闭包`getFn #2 () in :
     0x100004e90 <+0>:  pushq  %rbp
     0x100004e91 <+1>:  movq   %rsp, %rbp
     0x100004e94 <+4>:  subq   $0x20, %rsp
     0x100004e98 <+8>:  leaq   0x3289(%rip), %rdi
     0x100004e9f <+15>: movl   $0x18, %esi
     0x100004ea4 <+20>: movl   $0x7, %edx
     0x100004ea9 <+25>: callq  0x1000078a6               ; symbol stub for: swift_allocObject
     0x100004eae <+30>: movq   %rax, %rdx
     0x100004eb1 <+33>: addq   $0x10, %rdx
     0x100004eb5 <+37>: movq   %rdx, %rsi
     0x100004eb8 <+40>: movq   $0x0, 0x10(%rax) // 捕获参数
     0x100004ec0 <+48>: movq   %rax, %rdi
     0x100004ec3 <+51>: movq   %rax, -0x8(%rbp)
     0x100004ec7 <+55>: movq   %rdx, -0x10(%rbp)
     0x100004ecb <+59>: callq  0x1000078f4               ; symbol stub for: swift_retain
     0x100004ed0 <+64>: movq   -0x8(%rbp), %rdi
     0x100004ed4 <+68>: movq   %rax, -0x18(%rbp)
     0x100004ed8 <+72>: callq  0x1000078ee               ; symbol stub for: swift_release
     0x100004edd <+77>: movq   -0x10(%rbp), %rax
     0x100004ee1 <+81>: leaq   0x2938(%rip), %rax        ; partial apply forwarder for closure #1 (Swift.Int) -> Swift.Int in getFn #2 () -> (Swift.Int) -> Swift.Int in _7_闭包 at <compiler-generated>
     0x100004ee8 <+88>: movq   -0x8(%rbp), %rdx
     0x100004eec <+92>: addq   $0x20, %rsp
     0x100004ef0 <+96>: popq   %rbp
     0x100004ef1 <+97>: retq
     */
    typealias Fn = (Int) -> Int
    func getFn() -> Fn {
        /*
         07-闭包`closure #1 in getFn #2 () in :
         0x100004f00 <+0>:   pushq  %rbp
         0x100004f01 <+1>:   movq   %rsp, %rbp
         0x100004f04 <+4>:   subq   $0x90, %rsp
         0x100004f0b <+11>:  xorl   %eax, %eax
         0x100004f0d <+13>:  movl   %eax, %ecx
         0x100004f0f <+15>:  xorl   %eax, %eax
         0x100004f11 <+17>:  leaq   -0x8(%rbp), %rdx
         0x100004f15 <+21>:  movq   %rdi, -0x48(%rbp) // 传入参数
         0x100004f19 <+25>:  movq   %rdx, %rdi // 堆空间的地址值
         0x100004f1c <+28>:  movq   %rsi, -0x50(%rbp) // 堆空间的地址值
         0x100004f20 <+32>:  movl   %eax, %esi
         0x100004f22 <+34>:  movl   $0x8, %edx
         0x100004f27 <+39>:  movq   %rdx, -0x58(%rbp)
         0x100004f2b <+43>:  movq   %rcx, -0x60(%rbp)
         0x100004f2f <+47>:  movl   %eax, -0x64(%rbp)
         0x100004f32 <+50>:  callq  0x1000078a0               ; symbol stub for: memset
         0x100004f37 <+55>:  leaq   -0x10(%rbp), %rcx
         0x100004f3b <+59>:  movq   %rcx, %rdi
         0x100004f3e <+62>:  movl   -0x64(%rbp), %esi
         0x100004f41 <+65>:  movq   -0x58(%rbp), %rdx
         0x100004f45 <+69>:  callq  0x1000078a0               ; symbol stub for: memset
         0x100004f4a <+74>:  movq   -0x48(%rbp), %rcx
         0x100004f4e <+78>:  movq   %rcx, -0x8(%rbp)
         0x100004f52 <+82>:  movq   -0x50(%rbp), %rdx
         0x100004f56 <+86>:  addq   $0x10, %rdx
         0x100004f5a <+90>:  movq   %rdx, -0x10(%rbp)
         0x100004f5e <+94>:  movq   %rdx, %rdi
         0x100004f61 <+97>:  leaq   -0x28(%rbp), %rsi
         0x100004f65 <+101>: movl   $0x21, %r8d
         0x100004f6b <+107>: movq   %rdx, -0x70(%rbp)
         0x100004f6f <+111>: movq   %r8, %rdx
         0x100004f72 <+114>: movq   -0x60(%rbp), %rcx
         0x100004f76 <+118>: callq  0x1000078ac               ; symbol stub for: swift_beginAccess
         0x100004f7b <+123>: movq   -0x48(%rbp), %rcx // 传入参数
         0x100004f7f <+127>: movq   -0x50(%rbp), %rdx // 堆空间的地址值
         0x100004f83 <+131>: addq   0x10(%rdx), %rcx // 相加操作 (从堆空间地址值进行偏移找到 num 并和传入参数相加)
         0x100004f87 <+135>: seto   %r9b
         0x100004f8b <+139>: movq   %rcx, -0x78(%rbp)
         0x100004f8f <+143>: movb   %r9b, -0x79(%rbp)
         0x100004f93 <+147>: jo     0x100004ff3               ; <+243> at main.swift:165:17
         0x100004f95 <+149>: movq   -0x70(%rbp), %rax
         0x100004f99 <+153>: movq   -0x78(%rbp), %rcx
         0x100004f9d <+157>: movq   %rcx, (%rax)
         0x100004fa0 <+160>: leaq   -0x28(%rbp), %rdi
         0x100004fa4 <+164>: callq  0x1000078ca               ; symbol stub for: swift_endAccess
         0x100004fa9 <+169>: xorl   %edx, %edx
         0x100004fab <+171>: movl   %edx, %ecx
         0x100004fad <+173>: leaq   -0x40(%rbp), %rax
         0x100004fb1 <+177>: movl   $0x20, %edx
         0x100004fb6 <+182>: movq   -0x70(%rbp), %rdi
         0x100004fba <+186>: movq   %rax, %rsi
         0x100004fbd <+189>: movq   %rax, -0x88(%rbp)
         0x100004fc4 <+196>: callq  0x1000078ac               ; symbol stub for: swift_beginAccess
         0x100004fc9 <+201>: movq   -0x70(%rbp), %rax
         0x100004fcd <+205>: movq   (%rax), %rax
         0x100004fd0 <+208>: movq   -0x88(%rbp), %rdi
         0x100004fd7 <+215>: movq   %rax, -0x90(%rbp)
         0x100004fde <+222>: callq  0x1000078ca               ; symbol stub for: swift_endAccess
         0x100004fe3 <+227>: movq   -0x90(%rbp), %rax
         0x100004fea <+234>: addq   $0x90, %rsp
         0x100004ff1 <+241>: popq   %rbp
         0x100004ff2 <+242>: retq
         0x100004ff3 <+243>: ud2
         */
        var num = 0
        return {
            num += $0
            return num
        }
    }
    /* swift_allocObject
     (lldb) register read rax
     rax = 0x00000001006000a0
     */
    /* fn1
     0x100001e49 <+3177>:  movq   %rax, -0x50(%rbp)
     0x100001e4d <+3181>:  movq   %rdx, -0x48(%rbp)
     */
    /*
     (lldb) register read rax
     rax = 0x0000000100007820  07-闭包`partial apply forwarder for closure #1 (Swift.Int) -> Swift.Int in getFn #2 () -> (Swift.Int) -> Swift.Int in _7_闭包 at <compiler-generated>
     (lldb) register read rdx
     rdx = 0x0000000103140bd0 // swift_allocObject
     */
    var fn1 = getFn()
    /*
     0x100001e2c <+3196>:  movl   $0x1, %edi // 传入参数
     0x100001e31 <+3201>:  movq   -0x4a0(%rbp), %r13 // 堆空间的地址值
     0x100001e38 <+3208>:  movq   -0x498(%rbp), %rcx // 函数地址
     0x100001e3f <+3215>:  movq   %rax, -0x4a8(%rbp)
     0x100001e46 <+3222>:  callq  *%rcx
     (lldb) register read rcx
     rcx = 0x0000000100007820  07-闭包`partial apply forwarder for closure #1 (Swift.Int) -> Swift.Int in getFn #2 () -> (Swift.Int) -> Swift.Int in _7_闭包 at <compiler-generated>
     */
    /*
     07-闭包`partial apply for closure #1 in getFn #2 () in :
     0x100007820 <+0>: pushq  %rbp
     0x100007821 <+1>: movq   %rsp, %rbp
     0x100007824 <+4>: movq   %r13, %rsi // 堆空间的地址值
     0x100007827 <+7>: popq   %rbp
     0x100007828 <+8>: jmp    0x100004f00               ; closure #1 (Swift.Int) -> Swift.Int in getFn #2 () -> (Swift.Int) -> Swift.Int in _7_闭包 at main.swift:164
     */
    fn1(1)
    print(MemoryLayout.stride(ofValue: fn1))
    
    /* swift_allocObject
     (lldb) register read rax
     rax = 0x00000001005009c0
     */
    var fn2 = getFn()
    /*
     (lldb) x/4xg 0x00000001006000a0
     0x1006000a0: 0x0000000100008100 0x0000000200000002
     0x1006000b0: 0x0000000000000001 0x00027fff7016fd38
     */
    print(fn1(1))
    /*
     (lldb) x/4xg 0x00000001005009c0
     0x1005009c0: 0x0000000100008100 0x0000000200000002
     0x1005009d0: 0x0000000000000002 0x0000000000000000
     */
    print(fn2(2))
    /*
     (lldb) x/4xg 0x00000001006000a0
     0x1006000a0: 0x0000000100008100 0x0000000200000002
     0x1006000b0: 0x0000000000000004 0x00027fff7016fd38
     */
    print(fn1(3))
    /*
     (lldb) x/4xg 0x00000001005009c0
     0x1005009c0: 0x0000000100008100 0x0000000200000002
     0x1005009d0: 0x0000000000000006 0x0000000000000000
     */
    print(fn2(4))
    /*
     (lldb) x/4xg 0x00000001006000a0
     0x1006000a0: 0x0000000100008100 0x0000000200000002
     0x1006000b0: 0x0000000000000009 0x00027fff7016fd38
     */
    print(fn1(5))
    /*
     (lldb) x/4xg 0x00000001005009c0
     0x1005009c0: 0x0000000100008100 0x0000000200000002
     0x1005009d0: 0x000000000000000c 0x0000000000000000
     */
    print(fn2(6))
}

do {
    class Closure {
        var num = 0
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
    }
    var cs1 = Closure()
    var cs2 = Closure()
    print(cs1.plus(1))
    print(cs2.plus(2))
    print(cs1.plus(3))
    print(cs2.plus(4))
    print(cs1.plus(5))
    print(cs2.plus(6))
}

// MARK: - 练习

do {
    typealias Fn = (Int) -> (Int, Int)
    func getFns() -> (Fn, Fn) {
        /*
         0x10000519b <+43>:  callq  0x1000078a6               ; symbol stub for: swift_allocObject
         (lldb) register read rax
         rax = 0x00000001006000a0
         */
        var num1 = 0
        /*
         0x1000051c6 <+86>:  callq  0x1000078a6               ; symbol stub for: swift_allocObject
         (lldb) register read rax
         rax = 0x0000000101910ca0
         */
        var num2 = 0
        func plus(_ i: Int) -> (Int, Int) {
            num1 += i
            num2 += i << 1
            return (num1, num2)
        }
        func minus(_ i: Int) -> (Int, Int) {
            num1 -= i
            num2 -= i << 1
            return (num1, num2)
        }
        return (plus, minus)
    }
    
    let (p, m) = getFns()
    print(p(5))
    print(m(4))
    print(p(3))
    print(m(2))
}

do {
    class Closure {
        var num1 = 0
        var num2 = 0
        func plus(_ i: Int) -> (Int, Int) {
            num1 += i
            num2 += i << 1
            return (num1, num2)
        }
        func minus(_ i: Int) -> (Int, Int) {
            num1 -= i
            num2 -= i << 1
            return (num1, num2)
        }
    }
    
    var cs = Closure()
    print(cs.plus(5))
    print(cs.minus(4))
    print(cs.plus(3))
    print(cs.minus(2))
}

do {
    var functions: [() -> Int] = []
    for i in 1...3 {
        functions.append { i }
    }
    for f in functions {
        print(f())
    }
}

do {
    class Closure {
        var i: Int
        init(_ i: Int) {
            self.i = i
        }
        func get() -> Int {
            return i
        }
    }
    
    var clses: [Closure] = []
    for i in 1...3 {
        clses.append(Closure(i))
    }
    for cls in clses {
        print(cls.get())
    }
}

// MARK: - 注意

do {
    func add(_ num: Int) -> (inout Int) -> Void {
        func plus(v: inout Int) {
            v += num
        }
        return plus
    }
    var num = 5
    add(20)(&num)
    print(num)
}

// MARK: -  自动闭包

do {
    func getFirstPositive(_ v1: Int, _ v2: Int) -> Int {
        return v1 > 0 ? v1 : v2
    }
    print(getFirstPositive(10, 20))
    print(getFirstPositive(-2, 20))
    print(getFirstPositive(0, -4))
}

do {
    // 全局作用域构成函数重载, 局部作用域不构成函数重载
    //    func getFirstPositive(_ v1: Int, _ v2: () -> Int) -> Int? {
    //        return v1 > 0 ? v1 : v2()
    //    }
    //    print(getFirstPositive(-4){ 20 })
    
    func getFirstPositive(_ v1: Int, _ v2: @autoclosure () -> Int) -> Int? {
        return v1 > 0 ? v1 : v2()
    }
    print(getFirstPositive(-4, 20))
}
