//
//  main.swift
//  22-字面量
//
//  Created by 朱双泉 on 2019/8/19.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 字面量 (Literal)

do {
    var age = 10
    var isRed = false
    var name = "Jack"
}

do {
    typealias FloatLiteralType = Float
    typealias IntegerLiteralType = UInt8
    var age = 10
    var height = 1.68
}

// MARK: - 字面量协议

do {
    var b: Bool = false // ExpressibleByBooleanLiteral
    var i: Int = 10 // ExpressibleByIntegerLiteral
    var f0: Float = 10 // ExpressibleByIntegerLiteral
    var f1: Float = 10.0 // ExpressibleByFloatLiteral
    var d0: Double = 10 // ExpressibleByIntegerLiteral
    var d1: Double = 10.0 // ExpressibleByFloatLiteral
    var s: String = "jack" // ExpressibleByStringLiteral
    var arr: Array = [1, 2, 3] // ExpressibleByArrayLiteral
    var set: Set = [1, 2, 3] // ExpressibleByArrayLiteral
    var dict: Dictionary = ["jack": 60] // ExpressibleByDictionaryLiteral
    var o: Optional<Int> = nil // ExpressibleByNilLiteral
}

// MARK: - 字面量协议应用

extension Int: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Bool) { self = value ? 1 : 0 }
}

do {
    var num: Int = true
    print(num)
}

do {
    class Student: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral, ExpressibleByStringLiteral, CustomStringConvertible {
        var name: String = ""
        var score: Double = 0
        required init(floatLiteral value: Double) { self.score = value }
        required init(integerLiteral value: Int) { self.score = Double(value) }
        required init(stringLiteral value: String) { self.name = value }
        required init(unicodeScalarLiteral value: String) { self.name = value }
        required init(extendedGraphemeClusterLiteral value: String) { self.name = value }
        var description: String { "name=\(name), score=\(score)" }
    }
    var stu: Student = 90
    print(stu)
    stu = 98.5
    print(stu)
    stu = "Jack"
    print(stu)
}

struct Point {
    var x = 0.0, y = 0.0
}

extension Point: ExpressibleByArrayLiteral, ExpressibleByDictionaryLiteral {
    init(arrayLiteral elements: Double...) {
        guard elements.count > 0 else { return }
        self.x = elements[0]
        guard elements.count > 1 else { return }
        self.y = elements[1]
    }
    init(dictionaryLiteral elements: (String, Double)...) {
        for (k, v) in elements {
            if k == "x" { self.x = v }
            else if k == "y" { self.y = v }
        }
    }
}

do {
    var p: Point = [10.5, 20.5]
    print(p)
    p = ["x": 11, "y": 22]
    print(p)
}

