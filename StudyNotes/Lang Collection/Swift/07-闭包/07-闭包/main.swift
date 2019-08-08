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
    typealias Fn = (Int) -> Int
    func getFn() -> Fn {
        var num = 0
        return {
            num += $0
            return num
        }
    }
    /*
     (lldb) register read rax
     rax = 0x00000001006000a0
     */
    var fn1 = getFn()
    /*
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
