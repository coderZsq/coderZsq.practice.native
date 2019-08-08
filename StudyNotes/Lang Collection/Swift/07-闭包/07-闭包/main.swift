//
//  main.swift
//  07-闭包
//
//  Created by 朱双泉 on 2019/8/8.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 闭包表达式

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
    typealias Fn = (Int) -> Int
    func getFn() -> Fn {
        var num = 0
        func plus(_ i: Int) -> Int {
            num += i
            return num
        }
        return plus
    }
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
    
    var fn1 = getFn()
    var fn2 = getFn()
    print(fn1(1))
    print(fn2(2))
    print(fn1(3))
    print(fn2(4))
    print(fn1(5))
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
