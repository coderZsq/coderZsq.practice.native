//
//  main.swift
//  19-扩展
//
//  Created by 朱双泉 on 2019/8/15.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 计算属性, 下标, 方法, 嵌套类型

extension Double {
    var km: Double { self * 1_000.0 }
    var m: Double { self }
    var dm: Double { self / 10.0 }
    var cm: Double { self / 100.0 }
    var mm: Double { self / 1_000.0 }
}

extension Array {
    subscript(nullable idx: Int) -> Element? {
        if (startIndex..<endIndex).contains(idx) {
            return self[idx]
        }
        return nil
    }
}

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self { task() }
    }
    mutating func square() -> Int {
        self = self * self
        return self
    }
    enum Kind { case negative, zero, positive }
    var kind: Kind {
        switch self {
        case 0: return .zero
        case let x where x > 0: return .positive
        default: return .negative
        }
    }
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex { decimalBase *= 10 }
        return (self / decimalBase) % 10
    }
}

// MARK: - 协议, 初始化器
/*
 如果希望自定义初始化器的同时, 编译器也能够生成默认初始化器
 可以在扩展中编写自定义初始化器
 required 初始化器也不能写在扩展中
 */

class Person {
    var age: Int
    var name: String
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
}

extension Person: Equatable {
    static func ==(left: Person, right: Person) -> Bool {
        left.age == right.age && left.name == right.name
    }
    convenience init() {
        self.init(age: 0, name: "")
    }
}

struct Point {
    var x: Int = 0
    var y: Int = 0
}

extension Point {
    init(_ point: Point) {
        self.init(x: point.x, y: point.y)
    }
}

do {
    var p1 = Point()
    var p2 = Point(x: 10)
    var p3 = Point(y: 20)
    var p4 = Point(x: 10, y: 20)
    var p5 = Point(p4)
}

// MARK: - 协议
/*
 扩展可以给协议提供默认实现, 也间接实现[可选协议]的效果
 扩展可以给协议扩充[协议中从未声明的方法]
 */

protocol TestProtocol {
    func test()
}

class TestClass {
    func test() {
        print("test")
    }
}
extension TestClass: TestProtocol {}

func isOdd<T: BinaryInteger>(_ i: T) -> Bool {
    i % 2 != 0
}

extension BinaryInteger {
    func isOdd() -> Bool { self % 2 != 0 }
}

protocol TestProtocol2 {
    func test1()
}

extension TestProtocol2 {
    func test1() {
        print("TestProtocol test1")
    }
    func test2() {
        print("TestProtocol test2")
    }
}

class TestClass2: TestProtocol2 {
    func test1() { print("TestClass test1") }
    func test2() { print("TestClass test2") }
}

var cls = TestClass2()
cls.test1()
cls.test2()
var cls2: TestProtocol2 = TestClass2()
cls2.test1()
cls2.test2()

// MARK: - 泛型

class Stack<E> {
    var elements = [E]()
    func push(_ element: E) {
        elements.append(element)
    }
    func pop() -> E { elements.removeLast() }
    func size() -> Int { elements.count }
}

extension Stack {
    func top() -> E { elements.last! }
}

extension Stack: Equatable where E: Equatable {
    static func ==(left: Stack, right: Stack) -> Bool {
        left.elements == right.elements
    }
}
