//
//  main.swift
//  08-属性
//
//  Created by 朱双泉 on 2019/8/9.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 属性
// 枚举不可以定义存储属性

do {
    struct Circle {
        var radius: Double
        var diameter: Double {
            /*
             08-属性`diameter.setter in Circle #1 in :
             0x1000019f0 <+0>:  pushq  %rbp
             0x1000019f1 <+1>:  movq   %rsp, %rbp
             0x1000019f4 <+4>:  movq   $0x0, -0x8(%rbp)
             0x1000019fc <+12>: movq   $0x0, -0x10(%rbp)
             0x100001a04 <+20>: movsd  %xmm0, -0x8(%rbp)
             0x100001a09 <+25>: movq   %r13, -0x10(%rbp)
             0x100001a0d <+29>: movsd  0x28c3(%rip), %xmm1       ; xmm1 = mem[0],zero
             0x100001a15 <+37>: divsd  %xmm1, %xmm0
             0x100001a19 <+41>: movsd  %xmm0, (%r13)
             0x100001a1f <+47>: popq   %rbp
             0x100001a20 <+48>: retq
             */
            set {
                radius = newValue / 2
            }
            /*
             08-属性`diameter.getter in Circle #1 in :
             0x1000019d0 <+0>:  pushq  %rbp
             0x1000019d1 <+1>:  movq   %rsp, %rbp
             0x1000019d4 <+4>:  movq   $0x0, -0x8(%rbp)
             0x1000019dc <+12>: movsd  %xmm0, -0x8(%rbp)
             0x1000019e1 <+17>: addsd  %xmm0, %xmm0
             0x1000019e5 <+21>: popq   %rbp
             0x1000019e6 <+22>: retq
             */
            get {
                radius * 2
            }
        }
    }
    print(MemoryLayout<Circle>.stride)
    
    var circle = Circle(radius: 5)
    print(circle.radius)
    print(circle.diameter)
    
    /*
     0x1000011cc <+668>:  callq  0x1000019f0               ; diameter.setter : Swift.Double in Circle #1 in _8_属性 at main.swift:16
     */
    circle.diameter = 12
    print(circle.radius)
    /*
     0x100001299 <+873>:  callq  0x1000019d0               ; diameter.getter : Swift.Double in Circle #1 in _8_属性 at main.swift:33
     */
    print(circle.diameter)
}

// MARK: - 计算属性
// 定义计算属性只能用var, 不能用let

do {
    struct Circle {
        var radius: Double
        var diameter: Double {
            set(newDiameter) {
                radius = newDiameter / 2
            }
            get {
                radius * 2
            }
        }
    }
}

do {
    struct Circle {
        var radius: Double
        var diameter: Double {
            get {
                radius * 2
            }
        }
    }
}

do {
    struct Circle {
        var radius: Double
        var diameter: Double { radius * 2 }
    }
}

// MARK: - 枚举rawValue原理
// 枚举原始值rawValue的本质是: 只读计算属性

do {
    enum TestEnum: Int {
        case test1 = 1, test2 = 2, test3 = 3
        var rawValue: Int {
            switch self {
            case .test1:
                return 10
            case .test2:
                return 11
            case .test3:
                return 12
            }
        }
    }
    /*
     0x100001349 <+1049>: callq  0x100001a30               ; rawValue.getter : Swift.Int in TestEnum #1 in _8_属性 at main.swift:106
     0x100001349 <+1049>: callq  0x100001a30               ; rawValue.getter : Swift.Int in TestEnum #1 in _8_属性 at <compiler-generated>
     */
    print(TestEnum.test3.rawValue)
}

// MARK: - 延迟存储属性 (Lazy Stored Property)
/*
 lazy属性必须是var, 不能是let
 let必须在实例的初始化方法完成之前就拥有值
 
 如果多条线程同时第一次访问lazy属性
 无法保证属性只被初始化1次
 */

do {
    class Car {
        init() {
            print("Car init!")
        }
        func run() {
            print("Car is running!")
        }
    }
    
    class Person {
        lazy var car = Car()
        init() {
            print("Person init!")
        }
        func goOut() {
            car.run()
        }
    }
    
    let p = Person()
    print("------")
    p.goOut()
    
    //    class PhotoView {
    //        lazy var image: Image = {
    //            let url = "https://xx.png"
    //            let data = Data(url: url)
    //            return Image(data: data)
    //        }()
    //    }
}

// MARK: - 延迟存储属性注意点
/*
 当结构体包含一个延迟存储属性时, 只有var才能访问延迟存储属性
 因为延迟属性初始化时需要改变结构体的内存
 */

do {
    struct Point {
        var x = 0
        var y = 0
        lazy var z = 0
    }
    let p = Point()
    //    Cannot use mutating getter on immutable value: 'p' is a 'let' constant
    //    print(p.z)
}

// MARK: - 属性观察器 (Property Observer)
/*
 可以为非lazy的var存储属性设置属性观察器
 在初始化器中设置属性不会触发willSet和didSet
 在属性定义时设置初始值也不会触发willSet和didSet
 */

do {
    struct Circle {
        var radius: Double {
            willSet {
                print("willSet", newValue)
            }
            didSet {
                print("didSet", oldValue, radius)
            }
        }
        init() {
            self.radius = 1.0
            print("Circle init!")
        }
    }
    
    var circle = Circle()
    circle.radius = 10.5
    print(circle.radius)
}

// MARK: - 全局变量, 局部变量
// 属性观察器, 计算属性的功能, 同样可以应用在全局变量, 局部变量身上

do {
    var num: Int {
        get {
            return 10
        }
        set {
            print("setNum", newValue)
        }
    }
    num = 11
    print(num)
    
    func test() {
        var age = 10 {
            willSet {
                print("willSet", newValue)
            }
            didSet {
                print("didSet", oldValue, age)
            }
        }
        age = 11
    }
    test()
}

// MARK: - inout的再次研究
/*
 如果实参有物理内存地址, 且没有设置属性观察器
 直接将实参的内存地址传入函数 (实参进行引用传递)
 
 如果实参是计算属性 或者 设置了属性观察器
 采取了Copy In Copy Out的做法
 调用该函数时, 先复制实参的值, 产生副本 [get]
 将副本的内存地址传入函数 (副本进行引用传递), 在函数内部可以修改副本的值
 函数返回后, 再将副本的值覆盖实参的值 [set]
 
 总结: inout的本质就是引用传递 (地址传递)
 */

do {
    struct Shape {
        var width: Int
        /*
         08-属性`side.setter in Shape #1 in :
         0x1000023d0 <+0>:  pushq  %rbp
         0x1000023d1 <+1>:  movq   %rsp, %rbp
         0x1000023d4 <+4>:  pushq  %r13
         0x1000023d6 <+6>:  subq   $0x28, %rsp
         0x1000023da <+10>: movq   $0x0, -0x10(%rbp)
         0x1000023e2 <+18>: movq   $0x0, -0x18(%rbp)
         0x1000023ea <+26>: movq   %rdi, -0x10(%rbp)
         0x1000023ee <+30>: movq   %r13, -0x18(%rbp)
         0x1000023f2 <+34>: movq   0x8(%r13), %rax
         0x1000023f6 <+38>: movq   %rax, %rcx
         0x1000023f9 <+41>: movq   %rdi, -0x20(%rbp)
         0x1000023fd <+45>: movq   %r13, -0x28(%rbp)
         0x100002401 <+49>: movq   %rax, -0x30(%rbp)
         0x100002405 <+53>: callq  0x100003bb0               ; side.willset : Swift.Int in Shape #1 in _8_属性 at main.swift:258
         0x10000240a <+58>: movq   -0x28(%rbp), %rax
         0x10000240e <+62>: movq   -0x20(%rbp), %rcx
         0x100002412 <+66>: movq   %rcx, 0x8(%rax)
         0x100002416 <+70>: movq   -0x30(%rbp), %rdi
         0x10000241a <+74>: movq   %rax, %r13
         0x10000241d <+77>: callq  0x100003c90               ; side.didset : Swift.Int in Shape #1 in _8_属性 at main.swift:261
         0x100002422 <+82>: movq   -0x30(%rbp), %rax
         0x100002426 <+86>: addq   $0x28, %rsp
         0x10000242a <+90>: popq   %r13
         0x10000242c <+92>: popq   %rbp
         0x10000242d <+93>: retq
         */
        var side: Int {
            willSet {
                print("willSetSide", newValue)
            }
            didSet {
                print("didSetSide", oldValue, side)
            }
        }
        var girth: Int {
            set {
                width = newValue / side
                print("setGirth",  newValue)
            }
            get {
                print("getGirth")
                return width * side
            }
        }
        func show() {
            print("width=\(width), side=\(side), girth=\(girth)")
        }
    }
    
    func test(_ num: inout Int) {
        num = 20
    }
    
    var s = Shape(width: 10, side: 4)
    /*
     0x100001668 <+1848>: leaq   -0x48(%rbp), %rdi
     0x10000166c <+1852>: movq   %rax, -0x48(%rbp)
     0x100001670 <+1856>: movq   %rdx, -0x40(%rbp)
     0x100001674 <+1860>: callq  0x100002100               ; test #2 (inout Swift.Int) -> () in _8_属性 at main.swift:280
     */
    test(&s.width)
    s.show()
    print("------")
    /*
     0x100001749 <+2073>: movq   -0x40(%rbp), %rax
     0x10000174d <+2077>: movq   %rax, -0x50(%rbp)
     0x100001751 <+2081>: leaq   -0x50(%rbp), %rdi
     0x100001755 <+2085>: callq  0x100002100               ; test #2 (inout Swift.Int) -> () in _8_属性 at main.swift:280
     0x10000175a <+2090>: movq   -0x50(%rbp), %rdi
     0x10000175e <+2094>: leaq   -0x48(%rbp), %r13
     0x100001762 <+2098>: callq  0x1000023d0               ; side.setter : Swift.Int in Shape #1 in _8_属性 at <compiler-generated>
     */
    test(&s.side)
    s.show()
    print("------")
    /*
     0x100001837 <+2311>: movq   -0x48(%rbp), %rdi
     0x10000183b <+2315>: movq   -0x40(%rbp), %rsi
     0x10000183f <+2319>: callq  0x100002430               ; girth.getter : Swift.Int in Shape #1 in _8_属性 at main.swift:270
     0x100001844 <+2324>: movq   %rax, -0x58(%rbp)
     0x100001848 <+2328>: leaq   -0x58(%rbp), %rdi
     0x10000184c <+2332>: callq  0x100002100               ; test #2 (inout Swift.Int) -> () in _8_属性 at main.swift:280
     0x100001851 <+2337>: movq   -0x58(%rbp), %rdi
     0x100001855 <+2341>: leaq   -0x48(%rbp), %r13
     0x100001859 <+2345>: callq  0x100002530               ; girth.setter : Swift.Int in Shape #1 in _8_属性 at main.swift:266
     */
    test(&s.girth)
    s.show()
}

// MARK: - 类型属性 (Type Property)
/*
 可以通过static定义类型属性
 如果是类, 也可以用关键字class
 
 不同于存储实例属性, 你必须给存储类型属性设定初始值
 因为类型没有像实例那样的init初始化器来初始化存储属性
 
 存储类型属性默认就是lazy, 会在第一次使用的时候才初始化
 就算被多个线程同时访问, 保证只会初始化一次
 存储类型属性可以是let
 
 枚举类型也可以定义类型属性 (存储类型属性, 计算类型属性)
 */

do {
    struct Car {
        /*
         08-属性`count.unsafeMutableAddressor in Car #2 in :
         0x1000027c0 <+0>:  pushq  %rbp
         0x1000027c1 <+1>:  movq   %rsp, %rbp
         0x1000027c4 <+4>:  cmpq   $-0x1, 0x3df4(%rip)
         0x1000027cc <+12>: je     0x1000027e4               ; <+36> at main.swift:366:20
         0x1000027ce <+14>: leaq   0x15ab(%rip), %rax        ; globalinit_33_6BB0BA36906D5AB6097CF2AEF4F40154_func0 at main.swift
         0x1000027d5 <+21>: leaq   0x3de4(%rip), %rdi        ; globalinit_33_6BB0BA36906D5AB6097CF2AEF4F40154_token0
         0x1000027dc <+28>: movq   %rax, %rsi
         
         (lldb) register read rsi
         rsi = 0x0000000100003d80  08-属性`globalinit_33_6BB0BA36906D5AB6097CF2AEF4F40154_func0 at main.swift
         
         0x1000027df <+31>: callq  0x100004186               ; symbol stub for: swift_once
         0x1000027e4 <+36>: leaq   0x3ddd(%rip), %rax        ; static count : Swift.Int in Car #2 in _8_属性
         0x1000027eb <+43>: popq   %rbp
         0x1000027ec <+44>: retq
         
         libswiftCore.dylib`swift_once:
         0x7fff6481fa10 <+0>:  cmpq   $-0x1, (%rdi)
         0x7fff6481fa14 <+4>:  jne    0x7fff6481fa17            ; <+7>
         0x7fff6481fa16 <+6>:  retq
         0x7fff6481fa17 <+7>:  pushq  %rbp
         0x7fff6481fa18 <+8>:  movq   %rsp, %rbp
         0x7fff6481fa1b <+11>: movq   %rsi, %rax
         0x7fff6481fa1e <+14>: movq   %rdx, %rsi
         0x7fff6481fa21 <+17>: movq   %rax, %rdx
         0x7fff6481fa24 <+20>: callq  0x7fff648735e2            ; symbol stub for: dispatch_once_f
         0x7fff6481fa29 <+25>: popq   %rbp
         0x7fff6481fa2a <+26>: retq
         0x7fff6481fa2b <+27>: nop
         0x7fff6481fa2c <+28>: nop
         0x7fff6481fa2d <+29>: nop
         0x7fff6481fa2e <+30>: nop
         0x7fff6481fa2f <+31>: nop
         */
        /*
         08-属性`globalinit_33_6BB0BA36906D5AB6097CF2AEF4F40154_func0:
         0x100003d80 <+0>:  pushq  %rbp
         0x100003d81 <+1>:  movq   %rsp, %rbp
         0x100003d84 <+4>:  movq   $0x0, 0x2839(%rip)        ; globalinit_33_6BB0BA36906D5AB6097CF2AEF4F40154_token0 + 4
         0x100003d8f <+15>: popq   %rbp
         0x100003d90 <+16>: retq
         */
        static var count: Int = 0
        init() {
            /*
             0x100002758 <+8>:   callq  0x1000027c0               ; count.unsafeMutableAddressor : Swift.Int in Car #2 in _8_属性 at main.swift
             */
            Car.count += 1
        }
    }
    let c1 = Car()
    let c2 = Car()
    let c3 = Car()
    print(Car.count)
}

// MARK: - 单例模式

do {
    class FileManager {
        public static let shared = FileManager()
        private init() {}
    }
}

do {
    class FileManager {
        public static let shared = {
            return FileManager()
        }()
        private init() {}
    }
}
