//
//  main.swift
//  15-错误处理
//
//  Created by 朱双泉 on 2019/8/13.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 自定义错误

enum SomeError: Error {
    case illegalArg(String)
    case outOfBounds(Int, Int)
    case outOfMemory
}

func divide(_ num1: Int, _ num2: Int) throws -> Int {
    if num2 == 0 {
        throw SomeError.illegalArg("0不能作为除数")
    }
    return num1 / num2
}

do {
    var result = try divide(20, 10)
}

// MARK: - do-catch

do {
    func test() {
        print("1")
        do {
            print("2")
            print(try divide(20, 0))
            print("3")
        } catch let SomeError.illegalArg(msg) {
            print("参数异常:", msg)
        } catch let SomeError.outOfBounds(size, index) {
            print("下标越界:", "size=\(size)", "index=\(index)")
        } catch SomeError.outOfMemory {
            print("内存溢出")
        } catch {
            print("其他错误")
        }
        print(4)
    }
    test()
}

do {
    do {
        try divide(20, 0)
    } catch let error {
        switch error {
        case let SomeError.illegalArg(msg):
            print("参数错误:", msg)
        default:
            print("其他错误")
        }
    }
}

// MARK: - 处理Error

do {
    func test() throws {
        print("1")
        print(try divide(20, 0))
        print("2")
    }
//    try test()
}

do {
    do {
        print(try divide(20, 0))
    } catch is SomeError {
        print("SomeError")
    }
}

do {
    func test() throws {
        print("1")
        do {
            print("2")
            print(try divide(20, 0))
            print("3")
        } catch let error as SomeError {
            print(error)
        }
        print("4")
    }
    try test()
}

// MARK: - try?, try!

do {
    func test() {
        print("1")
        var result1 = try? divide(20, 10)
        var result2 = try? divide(20, 0)
        var result3 = try! divide(20, 10)
        print("2")
    }
    test()
}

do {
    var a = try? divide(20, 0)
    var b: Int?
    do {
        b = try divide(20, 0)
    } catch {
        b = nil
    }
}

// MARK: - rethrows
// rethrows表明: 函数本身不会抛出错误, 但调用闭包参数抛出错误, 那么它会将错误向上抛

do {
    func exec(_ fn: (Int, Int) throws -> Int, _ num1: Int, _ num2: Int) rethrows {
        print(try fn(num1, num2))
    }
//    try exec(divide, 20, 0)
}

// MARK: - defer
/*
 defer语句: 用来定义以任何方式 (抛错误, return等) 离开代码块前必须要执行的代码
 defer语句将延迟至当前作用域结束之前执行
 defer语句的执行顺序与定义顺序相反
 */

do {
    func fn1() { print("fn1") }
    func fn2() { print("fn2") }
    func test() {
        defer { fn1() }
        defer { fn2() }
    }
    test()
}

do {
//    func processFile(_ filename: String) throws {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        try divide(20, 0)
//    }
//    try processFile("test.txt")
}

// MARK: - assert (断言)
// 默认情况下, Swift的断言只会在Debug模式下生效, Release模式下会忽略

do {
    func divide(_ v1: Int, _ v2: Int) -> Int {
        assert(v2 != 0, "除数不能为0")
        return v1 / v2
    }
//    print(divide(20, 0))
}

// MARK: - fatalError
/*
 如果遇到严重问题, 希望结束程序运行时, 可以直接使用fatalError函数抛出错误 (这是无法通过do-catch捕捉的错误)
 使用了fatalError函数, 就不需要再写return
 在某些不得不实现, 但不希望别人调用的方法, 可以考虑内部使用fatalError函数
 */

do {
    func test(_ num: Int) -> Int {
        if num >= 0 {
            return 1
        }
        fatalError("num不能小于0")
    }
}

do {
    class Person { required init() {} }
    class Student: Person {
        required init() { fatalError("don't call Student.init") }
        init(score: Int) {}
    }
//    var stu1 = Student(score: 98)
//    var stu2 = Student()
}

// MARK: - 局部作用域

do {
    class Dog {
        var age: Int?
        func run() {}
        deinit {
            print("release")
        }
    }
    do {
        let dog1 = Dog()
        dog1.age = 10
        dog1.run()
    }
    do {
        let dog2 = Dog()
        dog2.age = 10
        dog2.run()
    }
}
