//
//  main.swift
//  06-结构体和类
//
//  Created by 朱双泉 on 2019/8/8.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 结构体

do {
    struct Date {
        var year: Int
        var month: Int
        var day: Int
    }
    var date = Date(year: 2019, month: 6, day: 23)
}


// MARK: - 结构体的初始化器

do {
    struct Point {
        var x: Int
        var y: Int
    }
    var p1 = Point(x: 10, y: 10)
}

do {
    struct Point {
        var x: Int = 0
        var y: Int
    }
    var p1 = Point(x: 10, y: 10)
    var p2 = Point(y: 10)
}

do {
    struct Point {
        var x: Int
        var y: Int = 0
    }
    var p1 = Point(x: 10, y: 10)
    var p2 = Point(x: 10)
}

do {
    struct Point {
        var x: Int = 0
        var y: Int = 0
    }
    var p1 = Point(x: 10, y: 10)
    var p2 = Point(y: 10)
    var p3 = Point(x: 10)
    var p4 = Point()
}

// MARK: - 思考: 下面代码能编译通过吗?

do {
    struct Point {
        var x: Int?
        var y: Int?
    }
    var p1 = Point(x: 10, y: 10)
    var p2 = Point(y: 10)
    var p3 = Point(x: 10)
    var p4 = Point()
}

// MARK: - 自定义初始化器
// 一旦在定义结构体时自定义了初始化器, 编译器就不会再帮它自动生成其他初始化器

do {
    struct Point {
        var x: Int = 0
        var y: Int = 0
        init(x: Int, y: Int) {
            self.x = x
            self.y = y
        }
    }
    var p1 = Point(x: 10, y: 10)
}

// MARK: -  窥探初始化器的本质

do {
    struct Point {
        var x: Int = 0
        var y: Int = 0
    }
    var p = Point()
}

do {
    struct Point {
        var x: Int
        var y: Int
        init() {
            x = 0
            y = 0
        }
    }
    var p = Point()
}

// MARK - 结构体内存结构

do {
    struct Point {
        var x: Int = 0
        var y: Int = 0
        var origin: Bool = false
    }
    print(MemoryLayout<Point>.size) // 17
    print(MemoryLayout<Point>.stride) // 24
    print(MemoryLayout<Point>.alignment) // 8
}

// MARK: -  类

do {
    class Point {
        var x: Int = 0
        var y: Int = 0
    }
    let p1 = Point()
}

do {
    struct Point {
        var x: Int = 0
        var y: Int = 0
    }
    let p1 = Point()
    let p2 = Point(x: 10, y: 20)
    let p3 = Point(x: 10)
    let p4 = Point(y: 20)
}

// MARK: - 类的初始化器

do {
    class Point {
        var x: Int = 10
        var y: Int = 20
    }
    let p1 = Point()
}

do {
    class Point {
        var x: Int
        var y: Int
        init() {
            x = 10
            y = 20
        }
    }
    let p1 = Point()
}

// MARK: - 结构体与类的本质区别

do {
    class Size {
        var width = 1
        var height = 2
    }
    
    struct Point {
        var x = 3
        var y = 4
    }
    
    func test() {
        var size = Size()
        var point = Point()
    }
}

// MARK: - 值类型

do {
    struct Point {
        var x: Int
        var y: Int
    }
    
    func test() {
        var p1 = Point(x: 10, y: 20)
        var p2 = p1
        p2.x = 11
        p2.y = 22
        print(p1.x, p1.y)
    }
    test()
}

// MARK: - 值类型的赋值操作

do {
    var s1 = "Jack"
    var s2 = s1
    s2.append("_Rose")
    print(s1)
    print(s2)
}

do {
    var a1 = [1, 2, 3]
    var a2 = a1
    a2.append(4)
    a1[0] = 2
    print(a1)
    print(a2)
}

do {
    var d1 = ["max": 10, "min": 2]
    var d2 = d1
    d1["other"] = 7
    d2["max"] = 12
    print(d1)
    print(d2)
}

do {
    struct Point {
        var x: Int
        var y: Int
    }
    var p1 = Point(x: 10, y: 20)
    p1 = Point(x: 11, y: 22)
}

// MARK: - 引用类型

do {
    class Size {
        var width: Int
        var height: Int
        init(width: Int, height: Int) {
            self.width = width
            self.height = height
        }
    }
    
    func test() {
        var s1 = Size(width: 10, height: 20)
        var s2 = s1
        s2.width = 11
        s2.height = 22
        print(s1.width, s1.height)
    }
    test()
}

// MARK: - 对象的堆空间申请过程

import Foundation

do {
    class Point {
        var x = 11
        var test = true
        var y = 22
    }
    var p = Point()
    print(class_getInstanceSize(type(of: p)))
    print(class_getInstanceSize(Point.self))
}

// MARK: - 引用类型的赋值操作

do {
    class Size {
        var width: Int
        var height: Int
        init(width: Int, height: Int) {
            self.width = width
            self.height = height
        }
    }
    var s1 = Size(width: 10, height: 20)
    s1 = Size(width: 11, height: 22)
}

// MARK: - 值类型, 引用类型的let

do {
    struct Point {
        var x: Int
        var y: Int
    }
    
    class Size {
        var width: Int
        var height: Int
        init(width: Int, height: Int) {
            self.width = width
            self.height = height
        }
    }

    let p = Point(x: 10, y: 20)
    
    let s = Size(width: 10, height: 20)
    s.width = 33
    s.height = 44
    
    let str = "Jack"
    
    let arr = [1, 2, 3]
}

// MARK: - 嵌套类型

do {
    struct Poker {
        enum Suit: Character {
            case spades = "♠", hearts = "♥", diamonds = "♦", clubs = "♣"
        }
        enum Rank: Int {
            case two = 2, three, four, five, six, seven, eight, nine, ten
            case jack, queen, king, ace
        }
    }
    print(Poker.Suit.hearts.rawValue)
    
    var suit = Poker.Suit.spades
    suit = .diamonds
    
    var rank = Poker.Rank.five
    rank = .king
}

// MARK: - 枚举, 结构体, 类都可以定义方法

do {
    class Size {
        var width = 10
        var height = 10
        func show() {
            print("width=\(width), height=\(height)")
        }
    }
    let s = Size()
    s.show()
}

do {
    struct Point {
        var x = 10
        var y = 10
        func show() {
            print("x=\(x), y=\(y)")
        }
    }
    let p = Point()
    p.show()
}

do {
    enum PokerFace: Character {
        case spades = "♠", hearts = "♥", diamonds = "♦", clubs = "♣"
        func show() {
            print("face is \(rawValue)")
        }
    }
    let pf = PokerFace.hearts
    pf.show()
}

// MARK: - 作业
// 思考以下结构体, 类对象的内存结构是怎样的

do {
    struct Point {
        var x: Int
        var b1: Bool
        var b2: Bool
        var y: Int
    }
    var p = Point(x: 10, b1: true, b2: true, y: 20)
}

do {
    class Size {
        var width: Int
        var b1: Bool
        var b2: Bool
        var height: Int
        init(width: Int, b1: Bool, b2: Bool, height: Int) {
            self.width = width
            self.b1 = b1
            self.b2 = b2
            self.height = height
        }
    }
    var s = Size(width: 10, b1: true, b2: true, height: 20)
}
