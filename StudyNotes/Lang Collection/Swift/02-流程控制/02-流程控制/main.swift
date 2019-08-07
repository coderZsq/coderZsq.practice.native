//
//  main.swift
//  02-流程控制
//
//  Created by 朱双泉 on 2019/8/6.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - if-else
// if 后面的条件只能是Bool类型

do {
    let age = 4
    if age >= 22 {
        print("Get married")
    } else if age >= 18 {
        print("Being a adult")
    } else if age >= 7 {
        print("Go to school")
    } else {
        print("Just a child")
    }
}

// MARK: - while

do {
    var num = 5
    while num > 0 {
        print("num is \(num)")
        num -= 1
    }
}

do {
    var num = -1
    repeat {
        print("num is \(num)")
    } while num > 0
}

// MARK: - for

do {
    let names = ["Anna", "Alex", "Brian", "Jack"]
    for i in 0...3 {
        print(names[i])
    }
    
    let range = 1...3
    for i in range {
        print(names[i])
    }
    
    let a = 1
    let b = 2
    for i in a...b {
        print(names[i])
    }
    
    for i in a...3 {
        print(names[i])
    }
    
    // i 默认是let, 有需要时可声明为var
    for var i in 1...3 {
        i += 5
        print(i)
    }
    
    for _ in 1...3 {
        print("for")
    }
}

// MARK: - for - 区间运算符用在数组上

do {
    let names = ["Anna", "Alex", "Brian", "Jack"]
    for name in names[0...3] {
        print(name)
    }
    
    for name in names[2...] {
        print(name)
    }
    
    for name in names[...2] {
        print(name)
    }
    
    for name in names[..<2] {
        print(name)
    }
    
    let range = ...5
    print(range.contains(7))
    print(range.contains(4))
    print(range.contains(-3))
}

// MARK: - 区间类型
// 字符, 字符串也能使用区间运算符, 但默认不能用在for-in中

do {
    let range1: ClosedRange<Int> = 1...3
    let range2: Range<Int> = 1..<3
    let range3: PartialRangeThrough<Int> = ...5
    
    let stringRange1 = "cc"..."ff"
    print(stringRange1.contains("cb"))
    print(stringRange1.contains("dz"))
    print(stringRange1.contains("fg"))
    
    let stringRange2 = "a"..."f"
    print(stringRange2.contains("d"))
    print(stringRange2.contains("h"))
    
    let charaterRange: ClosedRange<Character> = "\0"..."~"
    print(charaterRange.contains("G"))
}

// MARK: - 带间隔的区间值

do {
    let hours = 11
    let hourInterval = 2
    // 从4开始累加2不超过11
    for tickMark in stride(from: 4, through: hours, by: hourInterval) {
        print(tickMark)
    }
}


// MARK: - switch

do {
    // case, default 后面不能写大括号{}
    var number = 1
    switch number {
    case 1:
        print("number is 1")
        break
    case 2:
        print("number is 2")
        break
    default:
        print("number is other")
        break
    }
}

do {
    // 默认可以不写break, 并不会贯穿到后面的条件
    var number = 1
    switch number {
    case 1:
        print("number is 1")
    case 2:
        print("number is 2")
    default:
        print("number is other")
    }
}

// MARK: - fallthrough
// 使用fallthrough可以实现贯穿效果

do {
    var number = 1
    switch number {
    case 1:
        print("number is 1")
        fallthrough
    case 2:
        print("number is 2")
    default:
        print("number is other")
    }
}

// MARK: - switch注意点
/*
 switch必须要保证能处理所有情况
 case, default后面至少要有一条语句
 如果不想做任何事, 加个break即可
 如果能保证已处理所有情况, 也可以不必使用default
 */

do {
    var number = 1
    switch number {
    case 1:
        print("number is 1")
    case 2:
        print("number is 2")
    default:
        break
    }
}

do {
    enum Answer { case right, wrong }
    let answer = Answer.right
    switch answer {
    case Answer.right:
        print("right")
    case Answer.wrong:
        print("wrong")
    }
    
    switch answer {
    case .right:
        print("right")
    case .wrong:
        print("wrong")
    }
}

// MARK: - 复合条件

do {
    let string = "Jack"
    switch string {
    case "Jack":
        fallthrough
    case "Rose":
        print("Right person")
    default:
        break
    }
    
    switch string {
    case "Jack", "Rose":
        print("Right person")
    default:
        break
    }
    
    let character: Character = "a"
    switch character {
    case "a", "A":
        print("The letter A")
    default:
        print("Not the letter A")
    }
}

// MARK: - 区间匹配, 元组匹配

do {
    let count = 62
    switch count {
    case 0:
        print("none")
    case 1..<5:
        print("a few")
    case 5..<12:
        print("serveral")
    case 12..<100:
        print("dozens of")
    default:
        print("many")
    }
}

do {
    let point = (1, 1)
    switch point {
    case (0, 0):
        print("the origin")
    case (_, 0):
        print("on the x-axis")
    case (0, _):
        print("on the y-axis")
    case (-2...2, -2...2):
        print("inside the box")
    default:
        print("outside of the box")
    }
}

// MARK: - 值绑定

do {
    let point = (2, 0)
    switch point {
    case (let x, 0):
        print("on the x-axis with x value of \(x)")
    case (0, let y):
        print("on the y-axis with y value of \(y)")
    case let (x, y):
        print("somewhere else at \(x), \(y)")
    }
}

// MARK: - where

do {
    let point = (1, -1)
    switch point {
    case let (x, y) where x == y:
        print("on the line x == y")
    case let (x, y) where x == -y:
        print("on the line x == -y")
    case let (x, y):
        print("\(x), \(y) is just some arbitrary point")
    }
}

do {
    var numbers = [10, 20, -10, -20, 30, -30]
    var sum = 0
    for num in numbers where num > 0 { // 使用where来过滤num
        sum += num;
    }
    print(sum)
}

// MARK: - 标签语句

do {
    outer: for i in 1...4 {
        for k in 1...4 {
            if k == 3 {
                continue outer
            }
            if i == 3 {
                break outer
            }
            print("i == \(i), k == \(k)")
        }
    }
}
