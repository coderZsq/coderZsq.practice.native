//
//  main.swift
//  25-函数式编程
//
//  Created by 朱双泉 on 2019/8/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - Array的常见操作

do {
    var arr = [1, 2, 3, 4]
    var arr2 = arr.map { $0 * 2 }
    var arr3 = arr.filter { $0 % 2 == 0 }
    var arr4 = arr.reduce(0) { $0 + $1 }
    var arr5 = arr.reduce(0, +)
}

do {
    func double(_ i: Int) -> Int { i * 2 }
    var arr = [1, 2, 3, 4]
    print(arr.map(double))
}

do {
    var arr = [1, 2, 3]
    var arr2 = arr.map { Array.init(repeating: $0, count: $0) }
    var arr3 = arr.flatMap { Array.init(repeating: $0, count: $0) }
}

do {
    var arr = ["123", "test", "jack", "-30"]
    var arr2 = arr.map { Int($0) }
    var arr3 = arr.compactMap { Int($0) }
}

do {
    var arr = [1, 2, 3, 4]
    print(arr.map { $0 * 2 })
    print(arr.reduce([]) { $0 + [$1 * 2]})
    
    print(arr.filter { $0 % 2 == 0 })
    print(arr.reduce([]) { $1 % 2 == 0 ? $0 + [$1] : $0 })
}

// MARK: - lazy的优化

do {
    let arr = [1, 2, 3]
    let result = arr.lazy.map {
        (i: Int) -> Int in
        print("mapping \(i)")
        return i * 2
    }
    print("begin-----")
    print("mapped", result[0])
    print("mapped", result[1])
    print("mapped", result[2])
    print("end----")
}

// MARK: - Optional的map和flatMap

do {
    var num1: Int? = 10
    var num2 = num1.map { $0 * 2 }
    var num3: Int? = nil
    var num4 = num3.map { $0 * 2 }
}

do {
    var num1: Int? = 10
    var num2 = num1.map { Optional.some($0 * 2) }
    var num3 = num1.flatMap { Optional.some($0 * 2) }
}

do {
    var num1: Int? = 10
    var num2 = (num1 != nil) ? (num1! + 10) : nil
    var num3 = num1.map { $0 + 10 }
}

import Foundation
do {
    var fmt = DateFormatter()
    fmt.dateFormat = "yyyy-MM-dd"
    var str: String? = "2011-09-10"
    var date1 = str != nil ? fmt.date(from: str!) : nil
    var date2 = str.flatMap(fmt.date)
}

do {
    var score: Int? = 98
    var str1 = score != nil ? "score is \(score!)" : "No score"
    var str2 = score.map { "score is \($0)" } ?? "No score"
}

do {
    struct Person {
        var name: String
        var age: Int
    }
    var items = [
        Person(name: "jack", age: 20),
        Person(name: "rose", age: 21),
        Person(name: "kate", age: 22)
    ]
    func getPerson1(_ name: String) -> Person? {
        let index = items.firstIndex { $0.name == name }
        return index != nil ? items[index!] : nil
    }
    func getPerson2(_ name: String) -> Person? {
        return items.firstIndex { $0.name == name }.map { items[$0] }
    }
}

do {
    struct Person {
        var name: String
        var age: Int
        init?(_ json: [String: Any]) {
            guard let name = json["name"] as? String,
            let age = json["age"] as? Int  else {
                return nil
            }
            self.name = name
            self.age = age
        }
    }
    var json: Dictionary? = ["name": "jack", "age": 10]
    var p1 = json != nil ? Person(json!) : nil
    var p2 = json.flatMap(Person.init)
}

// MARK: - FP实践 - 传统写法

do {
    // 假设要实现以下功能: [(num + 3) * 5 - 1] % 10 / 2
    var num = 1
    func add(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
    func sub(_ v1: Int, _ v2: Int) -> Int { v1 - v2 }
    func multipe(_ v1: Int, _ v2: Int) -> Int { v1 * v2 }
    func divide(_ v1: Int, _ v2: Int) -> Int { v1 / v2 }
    func mod(_ v1: Int, _ v2: Int) -> Int { v1 % v2 }
    print(divide(mod(sub(multipe(add(num, 3), 5), 1), 10), 2))
}

// MARK: - FP实践 - 函数式写法

infix operator >>>: AdditionPrecedence
func >>><A, B, C>(_ f1: @escaping (A) -> B,
                  _ f2: @escaping (B) -> C) -> (A) -> C { { f2(f1($0)) } }

do {
    var num = 1
    func add(_ v: Int) -> (Int) -> Int { { $0 + v } }
    func sub(_ v: Int) -> (Int) -> Int { { $0 - v } }
    func multiple(_ v: Int) -> (Int) -> Int { { $0 * v } }
    func divide(_ v: Int) -> (Int) -> Int { { $0 / v } }
    func mod(_ v: Int) -> (Int) -> Int { { $0 % v } }
    
    var fn = add(3) >>> multiple(5) >>> sub(1) >>> mod(10) >>> divide(2)
    print(fn(num))
}
    
// MARK: - 柯里化 (Currying)
// 将一个接受多参数的函数变换为一系列只接受单个参数的函数

do {
    func add(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
    add(10, 20)
}

do {
    func add(_ v: Int) -> (Int) -> Int { { $0 + v } }
    add(10)(20)
}

do {
    func add1(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
    func currying<A, B, C>(_ fn: @escaping (A, B) -> C)
        -> (B) -> (A) -> C {
        { b in { a in fn(a, b) } }
    }
    let curriedAdd1 = currying(add1)
    print(curriedAdd1(10)(20))
}

do {
    func add2(_ v1: Int, _ v2: Int, _ v3: Int) { v1 + v2 + v3 }
    func currying<A, B, C, D>(_ fn: @escaping (A, B, C) -> D)
        -> (C) -> (B) -> (A) -> D {
        { c in { b in { a in fn(a, b, c) } } }
    }
    let curriedAdd2 = currying(add2)
    print(curriedAdd2(10)(20)(30))
}

prefix func ~<A, B, C>(_ fn: @escaping (A, B) -> C) -> (B) -> (A) -> C { { b in { a in fn(a, b) } } }

do {
    func add(_ v1: Int, _ v2: Int) -> Int { v1 + v2 }
    func sub(_ v1: Int, _ v2: Int) -> Int { v1 - v2 }
    func multiple(_ v1: Int, _ v2: Int) -> Int { v1 * v2 }
    func divide(_ v1: Int, _ v2: Int) -> Int { v1 / v2 }
    func mod(_ v1: Int, _ v2: Int) -> Int { v1 % v2 }
    
    var num = 1
    var fn = (~add)(3) >>> (~multiple)(5) >>> (~sub)(1) >>> (~mod)(10) >>> (~divide)(2)
    print(fn(num))
}

// MARK: - 函子 (Functor)
// 像Array, Optional这样支持map运算的类型, 称为函子 (Functor)

do {
//    @inlinable public func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]

//    @inlinable public func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U?
}

// MARK: - 适用函子 (Applicative Functor)
// 对任意一个函子F, 如果能支持以下运算, 该函子就是一个适用函子

do {
//    func pure<A>(_ value: A) -> F<A>
//    func <*><A, B>(fn: F<(A) -> B>, value: F<A>) -> F<B>
}

infix operator <*>: AdditionPrecedence

// Optional可以成为适用函子

func pure<A>(_ value: A) -> A? { value }
func <*><A, B>(fn: ((A) -> B)?, value: A?) -> B? {
    guard let f = fn, let v = value else { return nil }
    return f(v)
}

// Array 可以成为适用函子

func pure<A>(_ value: A) -> [A] { [value] }
func <*><A, B>(fn: [((A) -> B)], value: [A]) -> [B] {
    var arr: [B] = []
    if fn.count == value.count {
        for i in fn.startIndex..<fn.endIndex {
            arr.append(fn[i](value[i]))
        }
    }
    return arr
}

// MARK: - 单子 (Monad)
// 对任意一个类型F, 如果能支持以下运算, 那么久可以称为是一个单子(Monad)
// 很显然, Array, Optional都是单子

do {
//    func pure<A>(_ value: A) -> F<A>
//    func flatMap<A, B>(_ value: F<A>, _ fn: (A) -> F<B>) -> F<B>
}
