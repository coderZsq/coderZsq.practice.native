//
//  main.swift
//  03-函数
//
//  Created by 朱双泉 on 2019/8/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 函数的定义
// 形参默认是let, 也只能是let

do {
    func pi() -> Double {
        return 3.14
    }
    
    func sum(v1: Int, v2: Int) -> Int {
        return v1 + v2
    }
    sum(v1: 10, v2: 20)
    
    func sayHello() -> Void {
        print("Hello")
    }
    
    func sayHello2() -> () {
        print("Hello")
    }
    
    func sayHello3() {
        print("Hello")
    }
}

// MARK: - 隐式返回 (Implicit Return)
// 如果整个函数体是一个单一的表达式, 那么函数会隐式返回这个表达式

do {
    func sum(v1: Int, v2: Int) -> Int {
        v1 + v2
    }
    sum(v1: 10, v2: 20)
}

// MARK: - 返回元组: 实现多返回值

do {
    func calculate(v1: Int, v2: Int) -> (sum: Int, difference: Int, average: Int) {
        let sum = v1 + v2
        return (sum, v1 - v2, sum >> 1)
    }
    let result = calculate(v1: 20, v2: 10)
    print(result.sum)
    print(result.difference)
    print(result.average)
}

// MARK: - 函数的文档注释
// https://swift.org/documentation/api-design-guidelines/

do {
    /// 求和 [概述]
    ///
    /// 将2个整数相加 [更详细的描述]
    ///
    /// - Parameter v1: 第1个整数
    /// - Parameter v2: 第2个整数
    /// - Returns: 2个整数的和
    ///
    /// - Note: 传入2个整数即可 [批注]
    ///
    func sum(v1: Int, v2: Int) -> Int {
        v1 + v2
    }
}

// MARK: - 参数标签 (Argument Label)

do {
    func goToWork(at time: String) {
        print("this time is \(time)")
    }
    goToWork(at: "08:00")
    
    func sum(_ v1: Int, _ v2: Int) -> Int {
        v1 + v2
    }
    sum(10, 20)
}

// MARK: - 默认参数值 (Default Parameter Value)
/*
 参数可以有默认值
 C++的默认参数值有个限制: 必须从右往左设置, 由于Swift拥有参数标签, 因此并没有此类限制
 但是在省略参数标签时, 需要特别注意, 避免出错
 */

do {
    // 这里的middle不可以省略参数标签
    func test(_ first: Int = 10, middle: Int, _ last: Int = 30) {}
    test(middle: 20)
}

// MARK: - 可变参数 (Variadic Parameter)
/*
 一个函数最多只能有1个可变参数
 紧跟在可变参数后面的参数不能省略参数标签
 */

do {
    func test(_ numbers: Int..., string: String, _ other: String) {}
    test(10, 20, 30, string: "Jack", "Rose")
}

// MARK: - Swift自带的print函数

do {
    /// - Parameters:
    ///   - items: Zero or more items to print.
    ///   - separator: A string to print between each item. The default is a single
    ///     space (`" "`).
    ///   - terminator: The string to print after all items have been printed. The
    ///     default is a newline (`"\n"`).
    ///   public func print(_ items: Any..., separator: String = " ", terminator: String = "\n")
    
    print(1, 2, 3, 4, 5)
    print(1, 2, 3, 4, 5, separator: "_")
    print("My name is Jack", terminator: "")
    print("My age is 18.")
}

// MARK: - 输入输出参数 (In-Out Parameter)
/*
 可以用inout定义一个输入输出参数: 可以在函数内部修改外部实参的值
 可变参数不能标记为inout
 inout参数不能有默认值
 inout参数只能传入可以被多次赋值的值
 inout参数的本质是地址传递(引用传递)
 */

do {
    func swapValues(_ v1: inout Int, _ v2: inout Int) {
        let tmp = v1
        v1 = v2
        v2 = tmp
    }
    var num1 = 10
    var num2 = 20
    swapValues(&num1, &num2)
}

do {
    func swapValues(_ v1: inout Int, _ v2: inout Int) {
        (v1, v2) = (v2, v1)
    }
}

// MARK: - 函数重载 (Function Overload)

do {
    func sum(v1: Int, v2: Int) -> Int {
        v1 + v2
    }
    
    func sum(v1: Int, v2: Int, v3: Int) -> Int {
        v1 + v2 + v3
    }
    
    print(sum(v1: 10, v2: 20))
    print(sum(v1: 10, v2: 20, v3: 30))
}

do {
    // 全局作用域可以, 局部作用域报错
//    func sum(v1: Int, v2: Double) -> Double {
//        Double(v1) + v2
//    }
//
//    func sum(v1: Double, v2: Int) -> Double {
//        v1 + Double(v2)
//    }
}

do {
    func sum(_ v1: Int, _ v2: Int) -> Int {
        v1 + v2
    }
    
    func sum(a: Int, b: Int) -> Int {
        a + b
    }
    
    print(sum(10, 20))
    print(sum(a: 10, b: 20))
}

// MARK: - 函数重载注意点
/*
 返回值类型与函数重载无关
 默认参数值和函数重载一起使用产生二义性时, 编译器并不会报错 (在C++中会报错)
 可变参数, 省略参数标签, 函数重载一起使用产生二义性时, 编译器有可能会报错
 */

do {
    func sum(v1: Int, v2: Int) -> Int {
        v1 + v2
    }
    
    func sum(v1: Int, v2: Int, v3: Int = 10) -> Int {
        v1 + v2 + v3
    }
    
    // 会调用sum(v1: Int, v2: Int)
    sum(v1: 10, v2: 20)
}

do {
    func sum(v1: Int, v2: Int) -> Int {
        v1 + v2
    }

    func sum(_ v1: Int, _ v2: Int) -> Int {
        v1 + v2
    }
    
    func sum(_ numbers: Int...) -> Int {
        var total = 0
        for number in numbers {
            total += number
        }
        return total
    }
    
    // Ambiguous use of 'sum'
    // sum(10, 20)
}

// MARK: - @inline

do {
    // 永远不会被内联 (即使开启了编译器优化)
    @inline(never) func test() {
        print("test")
    }
}

do {
    // 开启编译器优化后, 即使代码很长, 也会被内联 (递归调用函数, 动态派发的函数除外)
    @inline(__always) func test() {
        print("test")
    }
}

// MARK: - 函数类型 (Function Type)
// 每一个函数都是有类型的, 函数类型由形式参数类型, 返回值类型组成

do {
    func test() {}
    
    func sum(a: Int, b: Int) -> Int {
        a + b
    }
    
    var fn: (Int, Int) -> Int = sum
    fn(2, 3)
}

// MARK: - 函数类型作为函数参数

do {
    func sum(v1: Int, v2: Int) -> Int {
        v1 + v2
    }
    
    func difference(v1: Int, v2: Int) -> Int {
        v1 - v2
    }
    
    func printResult(_ mathFn: (Int, Int) -> Int, _ a: Int, _ b: Int) {
        print("Result: \(mathFn(a, b))")
    }
    
    printResult(sum, 5, 2)
    printResult(difference, 5, 2)
}

// MARK: - 函数类型作为函数返回值

do {
    func next(_ input: Int) -> Int {
        input + 1
    }
    
    func previous(_ input: Int) -> Int {
        input - 1
    }
    
    func forward(_ forward: Bool) -> (Int) -> Int {
        forward ? next : previous
    }
    
    print(forward(true)(3))
    print(forward(false)(3))
}

// MARK: - typealias

do {
    typealias Byte = Int8
    typealias Short = Int16
    typealias Long = Int64
    
    typealias Date = (year: Int, month: Int, day: Int)
    func test(_ date: Date) {
        print(date.0)
        print(date.year)
    }
    test((2011, 9, 10))
    
    typealias IntFn = (Int, Int) -> Int
    
    func difference(v1: Int, v2: Int) -> Int {
        v1 - v2
    }
    
    let fn: IntFn = difference
    fn(20, 10)
    
    func setFn(_ fn: IntFn) {}
    setFn(difference)
    
    func getFn() -> IntFn { difference }
    
//    public typealias Void = ()
}

// MARK: - 嵌套函数 (Nested Function)

do {
    func forward(_ forward: Bool) -> (Int) -> Int {
        func next(_ input: Int) -> Int {
            input + 1
        }
        func previous(_ input: Int) -> Int {
            input - 1
        }
        return forward ? next : previous
    }
    print(forward(true)(3))
    print(forward(false)(3))
}
