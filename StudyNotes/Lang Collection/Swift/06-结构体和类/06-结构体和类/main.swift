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
    /*
     06-结构体和类`init() in Point #7 in :
     ->  0x100002990 <+0>:  pushq  %rbp
     0x100002991 <+1>:  movq   %rsp, %rbp
     0x100002994 <+4>:  xorps  %xmm0, %xmm0
     0x100002997 <+7>:  movaps %xmm0, -0x10(%rbp)
     0x10000299b <+11>: movq   $0x0, -0x10(%rbp)
     0x1000029a3 <+19>: movq   $0x0, -0x8(%rbp)
     0x1000029ab <+27>: xorl   %eax, %eax
     0x1000029ad <+29>: movl   %eax, %ecx
     0x1000029af <+31>: movq   %rcx, %rax
     0x1000029b2 <+34>: movq   %rcx, %rdx
     0x1000029b5 <+37>: popq   %rbp
     0x1000029b6 <+38>: retq
     */
    struct Point {
        var x: Int = 0
        var y: Int = 0
    }
    /*
     ->  0x10000168d <+1773>: callq  0x100002990               ; init() -> Point #7 in _6_结构体和类 in Point #7 in _6_结构体和类 at main.swift:91
     */
    var p = Point()
}

do {
    /*
     06-结构体和类`init() in Point #8 in :
     ->  0x1000029c0 <+0>:  pushq  %rbp
     0x1000029c1 <+1>:  movq   %rsp, %rbp
     0x1000029c4 <+4>:  xorps  %xmm0, %xmm0
     0x1000029c7 <+7>:  movaps %xmm0, -0x10(%rbp)
     0x1000029cb <+11>: movq   $0x0, -0x10(%rbp)
     0x1000029d3 <+19>: movq   $0x0, -0x8(%rbp)
     0x1000029db <+27>: xorl   %eax, %eax
     0x1000029dd <+29>: movl   %eax, %ecx
     0x1000029df <+31>: movq   %rcx, %rax
     0x1000029e2 <+34>: movq   %rcx, %rdx
     0x1000029e5 <+37>: popq   %rbp
     0x1000029e6 <+38>: retq
     
     */
    struct Point {
        var x: Int
        var y: Int
        init() {
            x = 0
            y = 0
        }
    }
    /*
     ->  0x1000016a0 <+1792>: callq  0x1000029c0               ; init() -> Point #8 in _6_结构体和类 in Point #8 in _6_结构体和类 at main.swift:120
     */
    var p = Point()
    print(Mems.memStr(ofVal: &p))
    
    print(MemoryLayout<Point>.size) // 16
    print(MemoryLayout<Point>.stride) // 16
    print(MemoryLayout<Point>.alignment) // 8
}

// MARK - 结构体内存结构

do {
    struct Point {
        var x: Int = 0
        var y: Int = 0
        var origin: Bool = false
    }
    var p = Point()
    print(Mems.memStr(ofVal: &p))
    
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

import Foundation

do {
    class Size {
        var width = 1
        var height = 2
    }
    
    struct Point {
        var x = 3
        var y = 4
    }
    
    var size = Size()
    print(malloc_size(Mems.ptr(ofRef: size)))
    
    //    var ptr = malloc(16)
    //    print(malloc_size(ptr))
    
    print("MemoryLayout<Size>.stride", MemoryLayout<Size>.stride)
    print("MemoryLayout<Point>.stride", MemoryLayout<Point>.stride)
    
    func test() {
        /*
         0x100002d3d <+29>: callq  0x100007c40               ; type metadata accessor for Size #1 in _6_结构体和类 at <compiler-generated>
         0x100002d42 <+34>: movq   %rax, %r13
         0x100002d45 <+37>: movq   %rdx, -0x28(%rbp)
         0x100002d49 <+41>: callq  0x100002d70               ; __allocating_init() -> Size #1 in _6_结构体和类 in Size #1 in _6_结构体和类 at main.swift:214
         */
        /*
         0x100002d9f <+47>: callq  0x10000d7d2               ; symbol stub for: swift_allocObject
         0x7fff647fabdf <+15>: callq  0x7fff647fab50            ; swift_slowAlloc
         0x7fff647fab64 <+20>: callq  0x7fff648736d2            ; symbol stub for: malloc
         */
        var size = Size()
        print(Mems.size(ofRef: size))
        print("size变量的地址", Mems.ptr(ofVal: &size))
        print("size变量的内存", Mems.memStr(ofVal: &size))
        print("size所指向内存的地址", Mems.ptr(ofRef: size))
        print("size所指向内存的内容", Mems.memStr(ofRef: size))
        
        var point = Point()
        print("point变量的地址", Mems.ptr(ofVal: &point))
        print("point变量的内存", Mems.memStr(ofVal: &point))
    }
    test()
}

// MARK: - 值类型

do {
    /*
     06-结构体和类`init(x:y:) in Point #15 in :
     0x100004040 <+0>:  pushq  %rbp
     0x100004041 <+1>:  movq   %rsp, %rbp
     0x100004044 <+4>:  movq   %rdi, %rax
     0x100004047 <+7>:  movq   %rsi, %rdx
     0x10000404a <+10>: popq   %rbp
     0x10000404b <+11>: retq
     */
    struct Point {
        var x: Int
        var y: Int
    }
    
    func test() {
        /*
         0x100003d43 <+19>:  movl   $0xa, %edi
         0x100003d48 <+24>:  movl   $0x14, %esi
         0x100003d4d <+29>:  callq  0x100004040               ; init(x: Swift.Int, y: Swift.Int) -> Point #15 in _6_结构体和类 in Point #15 in _6_结构体和类 at main.swift:264
         */
        /*
         0x100003d52 <+34>:  movq   %rax, -0x10(%rbp)
         0x100003d56 <+38>:  movq   %rdx, -0x8(%rbp)
         */
        var p1 = Point(x: 10, y: 20)
        /*
         0x100003d5a <+42>:  movq   %rax, -0x20(%rbp)
         0x100003d5e <+46>:  movq   %rdx, -0x18(%rbp)
         */
        var p2 = p1
        /*
         0x100003d62 <+50>:  movq   $0xb, -0x20(%rbp)
         0x100003d6a <+58>:  movq   $0x16, -0x18(%rbp)
         */
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
        /*
         (lldb) register read rax
         rax = 0x000000010053aaa0
         */
        /*
         30 2E 01 00 01 00 00 00
         02 00 00 00 00 00 00 00
         0A 00 00 00 00 00 00 00
         14 00 00 00 00 00 00 00
         */
        /*
         (lldb) register read rbp
         rbp = 0x00007ffeefbfebd0
         */
        // 0x1000040a6 <+70>:  movq   %rax, -0x10(%rbp)
        var s1 = Size(width: 10, height: 20) // 0x00007ffeefbfebc0
        print("s1", Mems.ptr(ofVal: &s1))
        // 0x1000040ad <+77>:  movq   %rax, -0x90(%rbp)
        var s2 = s1
        print("s2", Mems.ptr(ofVal: &s2))
        /*
         0x100004109 <+169>: movq   -0x90(%rbp), %rax
         0x100004110 <+176>: movq   $0xb, 0x10(%rax)
         */
        s2.width = 11
        /*
         0x10000415a <+250>: movq   -0x90(%rbp), %rax
         0x100004161 <+257>: movq   $0x16, 0x18(%rax)
         */
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
    print(Mems.size(ofRef: p))
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
