//
//  main.swift
//  04-枚举
//
//  Created by 朱双泉 on 2019/8/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 枚举的基本用法

do {
    enum Direction {
        case north
        case south
        case east
        case west
    }
}

do {
    enum Direction {
        case north, south, east, west
    }
    
    var dir = Direction.west
    dir = Direction.east
    dir = .north
    print(dir)
    
    switch dir {
    case .north:
        print("north")
    case .south:
        print("south")
    case .east:
        print("east")
    case .west:
        print("west")
    }
}

// MARK: - 关联值 (Associated Values)
// 有时候枚举的成员值跟其他类型的值关联存储在一起, 会非常有用
// 有必要是let也可以改成var

do {
    enum Score {
        case point(Int)
        case grade(Character)
    }
    
    var score = Score.point(96)
    score = .grade("A")
    
    switch score {
    case let .point(i):
        print(i, "points")
    case let .grade(i):
        print("grade", i)
    }
}

do {
    enum Date {
        case digit(year: Int, month: Int, day: Int)
        case string(String)
    }
    
    var date = Date.digit(year: 2011, month: 9, day: 10)
    date = .string("2011-09-10")
    
    switch date {
    case .digit(let year, let month, let day):
        print(year, month, day)
    case let .string(value):
        print(value)
    }
}

// MARK: - 关联值举例

do {
    enum Password {
        case number(Int, Int, Int, Int)
        case gesture(String)
    }
    
    var pwd = Password.number(3, 5, 7, 8)
    pwd = .gesture("12369")
    
    switch pwd {
    case let .number(n1, n2, n3, n4):
        print("number is ", n1, n2, n3, n4)
    case let .gesture(str):
        print("gesture is", str)
    }
}

// MARK: - 原始值 (Raw Values)
// 枚举成员可以使用相同类型的默认值预先对应, 这个默认值叫做: 原始值
// 原始值不占用枚举变量的内存

do {
    enum PokerSuit: Character {
        case spade = "♠"
        case heart = "♥"
        case diamond = "♦"
        case club = "♣"
    }
    
    var suit = PokerSuit.spade
    print(suit)
    print(suit.rawValue)
    print(PokerSuit.club.rawValue)
}

do {
    enum Grade: String {
        case perfect = "A"
        case great = "B"
        case good = "C"
        case bad = "D"
    }
    
    print(Grade.perfect.rawValue)
    print(Grade.great.rawValue)
    print(Grade.good.rawValue)
    print(Grade.bad.rawValue)
}

// MARK: - 隐式原始值 (Implicitly Assigned Raw Values)
// 如果枚举的原始值类型是Int, String, Swift会自动分配原始值

do {
    enum Direction: String {
        case north = "north"
        case south = "south"
        case east = "east"
        case west = "west"
    }
}

do {
    enum Direction: String {
        case north, south, east, west
    }
    print(Direction.north)
    print(Direction.north.rawValue)
}

do {
    enum Season: Int {
        case spring, summer, autumn, winter
    }
    print(Season.spring.rawValue)
    print(Season.summer.rawValue)
    print(Season.autumn.rawValue)
    print(Season.winter.rawValue)
}

do {
    enum Season: Int {
        case spring = 1, summer, autumn = 4, winter
    }
    print(Season.spring.rawValue)
    print(Season.summer.rawValue)
    print(Season.autumn.rawValue)
    print(Season.winter.rawValue)
}

// MARK: - 递归枚举 (Recursive Enumeration)

do {
    indirect enum ArithExpr {
        case number(Int)
        case sum(ArithExpr, ArithExpr)
        case difference(ArithExpr, ArithExpr)
    }
}

do {
    enum ArithExpr {
        case number(Int)
        indirect case sum(ArithExpr, ArithExpr)
        indirect case difference(ArithExpr, ArithExpr)
    }
    
    let five = ArithExpr.number(5)
    let four = ArithExpr.number(4)
    let two = ArithExpr.number(2)
    let sum = ArithExpr.sum(five, four)
    let difference = ArithExpr.difference(sum, two)
    
    func calculate(_ expr: ArithExpr) -> Int {
        switch expr {
        case let .number(value):
            return value
        case let .sum(left, right):
            return calculate(left) + calculate(right)
        case let .difference(left, right):
            return calculate(left) - calculate(right)
        }
    }
    
    print(calculate(difference))
}

// MARK: - MemoryLayout

do {
    enum Password {
        case number(Int, Int, Int, Int)
        case other
    }
    
    print(MemoryLayout<Password>.stride) // 分配占用的空间大小
    print(MemoryLayout<Password>.size) // 实际用到的空间大小
    print(MemoryLayout<Password>.alignment) // 对齐参数
    
    var pwd = Password.number(9, 8, 6, 4)
    pwd = .other
    print(MemoryLayout.stride(ofValue: pwd))
    print(MemoryLayout.size(ofValue: pwd))
    print(MemoryLayout.alignment(ofValue: pwd))
}

// MARK: - 思考下面枚举变量的内存布局

do {
    enum TestEnum {
        case test1, test2, test3
    }
    var t = TestEnum.test1
    print(Mems.ptr(ofVal: &t))
    print(Mems.memStr(ofVal: &t))
    t = .test2
    t = .test3
    
    print(MemoryLayout<TestEnum>.size)
    print(MemoryLayout<TestEnum>.stride)
    print(MemoryLayout<TestEnum>.alignment)
    
    switch t {
    case .test1:
        print("test1")
    case .test2:
        print("test2")
    case .test3:
        print("test3")
    }
}

do {
    enum TestEnum: Int {
        case test1 = 1, test2 = 2, test3 = 3
    }
    var t = TestEnum.test1
    print(Mems.ptr(ofVal: &t))
    print(Mems.memStr(ofVal: &t))
    t = .test2
    t = .test3
    
    print(MemoryLayout<TestEnum>.size)
    print(MemoryLayout<TestEnum>.stride)
    print(MemoryLayout<TestEnum>.alignment)
}

do {
    enum TestEnum: Int {
        case test
    }
    var t = TestEnum.test
    print(Mems.memStr(ofVal: &t)) // 没有内存
    print(MemoryLayout<TestEnum>.size) // 0
    print(MemoryLayout<TestEnum>.stride) // 1
    print(MemoryLayout<TestEnum>.alignment) // 1
}

do {
    enum TestEnum {
        case test(Int)
    }
    var t = TestEnum.test(10)
    print(Mems.memStr(ofVal: &t))
    print(MemoryLayout<TestEnum>.size) // 8
    print(MemoryLayout<TestEnum>.stride) // 8
    print(MemoryLayout<TestEnum>.alignment) // 8
}

do {
    enum TestEnum {
        case test1(Int, Int, Int)
        case test2(Int, Int)
        case test3(Int)
        case test4(Bool)
        case test5
    }
    /*
     01 00 00 00 00 00 00 00
     02 00 00 00 00 00 00 00
     03 00 00 00 00 00 00 00
     00
     */
    /*
     0x100003216 <+9894>:  movq   $0x1, -0x150(%rbp)
     0x100003221 <+9905>:  movq   $0x2, -0x148(%rbp)
     0x10000322c <+9916>:  movq   $0x3, -0x140(%rbp)
     0x100003237 <+9927>:  movb   $0x0, -0x138(%rbp)
     */
    /*
     (lldb) register read rbp
     rbp = 0x00007ffeefbff520
     */
    var e = TestEnum.test1(1, 2, 3)
    print(Mems.ptr(ofVal: &e))
    print(Mems.memStr(ofVal: &e))
    
    switch e {
    case let .test1(v1, v2, v3):
        print("test1", v1, v2, v3)
    case let .test2(v1, v2):
        print("test2", v1, v2)
    case let .test3(v1):
        print("test3", v1)
    case let .test4(v1):
        print("test4", v1)
    case .test5:
        print("test5")
    }
    
    /*
     04 00 00 00 00 00 00 00
     05 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     01
     */
    e = .test2(4, 5)
    /*
     06 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     02
     */
    e = .test3(6)
    /*
     01 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     03
     */
    e = .test4(true)
    /*
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     04
     */
    e = .test5
    
    print(MemoryLayout<TestEnum>.size)
    print(MemoryLayout<TestEnum>.stride)
    print(MemoryLayout<TestEnum>.alignment)
}

// MARK: - 进一步观察下面枚举的内存布局

do {
    enum TestEnum {
        case test0
        case test1
        case test2
        case test4(Int)
        case test5(Int, Int)
        case test6(Int, Int, Int, Bool)
    }
    /*
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     C0 
     */
    var e = TestEnum.test0
    print(Mems.ptr(ofVal: &e))
    print(Mems.memStr(ofVal: &e))
    /*
     01 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     C0
     */
    e = .test1
    /*
     02 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     C0
     */
    e = .test2
    /*
     01 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00
     */
    e = .test4(1)
    /*
     02 00 00 00 00 00 00 00
     03 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     40
     */
    e = .test5(2, 3)
    /*
     04 00 00 00 00 00 00 00
     05 00 00 00 00 00 00 00
     06 00 00 00 00 00 00 00
     80
     */
    e = .test6(4, 5, 6, false)
    
    print(MemoryLayout<TestEnum>.size) // 25
    print(MemoryLayout<TestEnum>.stride) // 32
    print(MemoryLayout<TestEnum>.alignment) // 8
}

do {
    enum TestEnum {
        case test0
        case test1
        case test2
        case test4(Int)
        case test5(Int, Int)
        case test6(Int, Bool, Int)
    }
    /*
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     03
     */
    var e = TestEnum.test0
    print(Mems.ptr(ofVal: &e))
    print(Mems.memStr(ofVal: &e))
    /*
     01 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     03
     */
    e = .test1
    /*
     02 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     03
     */
    e = .test2
    /*
     01 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00
     */
    e = .test4(1)
    /*
     02 00 00 00 00 00 00 00
     03 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     01
     */
    e = .test5(2, 3)
    /*
     04 00 00 00 00 00 00 00
     01 00 00 00 00 00 00 00
     05 00 00 00 00 00 00 00
     02
     */
    e = .test6(4, true, 5)
    
    print(MemoryLayout<TestEnum>.size) // 25
    print(MemoryLayout<TestEnum>.stride) // 32
    print(MemoryLayout<TestEnum>.alignment) // 8
}

do {
    enum TestEnum {
        case test0
        case test1
        case test2
        case test4(Int)
        case test5(Int, Int)
        case test6(Int, Int, Bool, Int)
    }
    /*
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 C0
     00 00 00 00 00 00 00 00
     */
    var e = TestEnum.test0
    print(Mems.ptr(ofVal: &e))
    print(Mems.memStr(ofVal: &e))
    /*
     01 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 C0
     00 00 00 00 00 00 00 00
     */
    e = .test1
    /*
     02 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 C0
     00 00 00 00 00 00 00 00
     */
    e = .test2
    /*
     01 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     */
    e = .test4(1)
    /*
     02 00 00 00 00 00 00 00
     03 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 40
     00 00 00 00 00 00 00 00
     */
    e = .test5(2, 3)
    /*
     04 00 00 00 00 00 00 00
     05 00 00 00 00 00 00 00
     01 00 00 00 00 00 00 80
     06 00 00 00 00 00 00 00
     */
    e = .test6(4, 5, true, 6)
    
    print(MemoryLayout<TestEnum>.size) // 32
    print(MemoryLayout<TestEnum>.stride) // 32
    print(MemoryLayout<TestEnum>.alignment) // 8
    
}
