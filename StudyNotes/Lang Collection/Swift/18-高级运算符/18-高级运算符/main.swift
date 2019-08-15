//
//  main.swift
//  18-高级运算符
//
//  Created by 朱双泉 on 2019/8/15.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 溢出运算符 (Overflow Operator)

do {
    var min = UInt8.min
    print(min &- 1)
    
    var max = UInt8.max
    print(max &+ 1)
    print(max &* 2)
}

// MARK: - 运算符重载 (Operator Overload)

struct Point {
    var x: Int, y: Int
}

func +(p1: Point, p2: Point) -> Point {
    Point(x: p1.x + p2.x, y: p1.y + p2.y)
}

do {
    let p = Point(x: 10, y: 20) + Point(x: 11, y: 22)
    print(p)
}

struct Point2 {
    var x: Int, y: Int
    static func +(p1: Point2, p2: Point2) -> Point2 {
        Point2(x: p1.x + p2.x, y: p1.y + p2.y)
    }
    static func -(p1: Point2, p2: Point2) -> Point2 {
        Point2(x: p1.x - p2.x, y: p1.y - p2.y)
    }
    static prefix func -(p: Point2) -> Point2 {
        Point2(x: -p.x, y: -p.y)
    }
    static func +=(p1: inout Point2, p2: Point2) {
        p1 = p1 + p2
    }
    static prefix func ++(p: inout Point2) -> Point2 {
        p += Point2(x: 1, y: 1)
        return p
    }
    static postfix func ++(p: inout Point2) -> Point2 {
        let tmp = p
        p += Point2(x: 1, y: 1)
        return tmp
    }
    static func ==(p1: Point2, p2: Point2) -> Bool {
        (p1.x == p2.x) && (p1.y == p2.y)
    }
}

// MARK: - Equatable
/*
 想要得知2个实例是否相等, 一般做法是遵守Equatable协议, 重载 == 运算符
 与此同时, 等价于重载了 != 运算符
 
 Swift 为以下类型提供默认的 Equatable 实现
 没有关联类型的枚举
 只拥有遵守 Equatable 协议关联类型的枚举
 只拥有遵守 Equatable 协议存储属性的结构体
 
 引用类型比较存储的地址值是否相等(是否引用着同一个对象), 使用恒等运算符 ===, !==
 */

do {
    struct Point: Equatable {
        var x: Int, y: Int
    }
    var p1 = Point(x: 10, y: 20)
    var p2 = Point(x: 11, y: 22)
    print(p1 == p2)
    print(p1 != p2)
}

class Person: Equatable {
    var age: Int
    init(age: Int) {
        self.age = age
    }
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.age == rhs.age
    }
}

do {
    var p1 = Person(age: 10)
    var p2 = Person(age: 11)
    print(p1 == p2)
    print(p1 != p2)
}

do {
    enum Answer: String {
        case wrong
        case right
    }
    var s1 = Answer.wrong
    var s2 = Answer.right
    print(s1 == s2)
}

do {
    enum Answer: Equatable {
        case wrong(Int)
        case right
    }
    var s1 = Answer.wrong(10)
    var s2 = Answer.right
    print(s1 == s2)
}

// MARK: - Comparable

struct Student: Comparable {
    var age: Int
    var score: Int
    init(score: Int, age: Int) {
        self.score = score
        self.age = age
    }
    static func < (lhs: Student, rhs: Student) -> Bool {
        (lhs.score < rhs.score) || (lhs.score == rhs.score && lhs.age > rhs.age)
    }
    static func > (lhs: Student, rhs: Student) -> Bool {
        (lhs.score > rhs.score) || (lhs.score == rhs.score && lhs.age < rhs.age)
    }
    static func <= (lhs: Student, rhs: Student) -> Bool {
        !(lhs > rhs)
    }
    static func >= (lhs: Student, rhs: Student) -> Bool {
        !(lhs < rhs)
    }
}

do {
    var stu1 = Student(score: 100, age: 20)
    var stu2 = Student(score: 98, age: 18)
    var stu3 = Student(score: 100, age: 20)
    print(stu1 > stu2)
    print(stu1 >= stu2)
    print(stu1 >= stu3)
    print(stu1 <= stu3)
    print(stu2 < stu1)
    print(stu2 <= stu1)
}

// MARK: - 自定义运算符 (Custom Operator)

prefix operator +++
infix operator +-: PlusMinusPrecedence
precedencegroup PlusMinusPrecedence { // 优先级组
    associativity: none // 结合性(left/right/none)
    higherThan: AdditionPrecedence // 比谁的优先级高
    lowerThan: MultiplicationPrecedence // 比谁的优先级低
    assignment: true // 代表在可选链操作中拥有跟赋值运算符一样的优先级
}

struct Point3 {
    var x: Int, y: Int
    static prefix func +++(point: inout Point3) -> Point3 {
        point = Point3(x: point.x + point.x, y: point.y + point.y)
        return point
    }
    static func +-(left: Point3, right: Point3) -> Point3 {
        return Point3(x: left.x + right.x, y: left.y - right.y)
    }
    static func +-(left: Point3?, right: Point3) -> Point3 {
        print("+-")
        return Point3(x: left?.x ?? 0 + right.x, y: left?.y ?? 0 - right.y)
    }
}

do {
    struct Person {
        var point: Point3
    }
    var person: Person? = nil
    person?.point +- Point3(x: 10, y: 20)
}
