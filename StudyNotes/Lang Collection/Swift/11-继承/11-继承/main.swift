//
//  main.swift
//  11-继承
//
//  Created by 朱双泉 on 2019/8/9.
//  Copyright © 2019 Castie!. All rights reserved.
//

import Foundation

// MARK: - 内存结构

do {
    class Animal {
        var age = 0
    }
    class Dog: Animal {
        var weight = 0
    }
    class ErHa: Dog {
        var iq = 0
    }
    let a = Animal()
    a.age = 10
    print(Mems.size(ofRef: a)) // 32
    /*
     0x00000001000073e8
     0x0000000000000002
     0x000000000000000a
     0x00000001005882c0
     */
    print(Mems.memStr(ofRef: a))
    
    let d = Dog()
    d.age = 10
    d.weight = 20
    print(Mems.size(ofRef: d)) // 32
    /*
     0x0000000100007498
     0x0000000000000002
     0x000000000000000a
     0x0000000000000014
     */
    print(Mems.memStr(ofRef: d))
    
    let e = ErHa()
    e.age = 10
    e.weight = 20
    e.iq = 30
    print(Mems.size(ofRef: e)) // 48
    /*
     0x0000000100007568
     0x0000000000000002
     0x000000000000000a
     0x0000000000000014
     0x000000000000001e
     0x0003000010065ceb
     */
    print(Mems.memStr(ofRef: e))
}

// MARK: - 重写实例方法, 下标

do {
    class Animal {
        func speak() {
            print("Animal speak")
        }
        subscript(index: Int) -> Int {
            return index
        }
    }
    var anim: Animal
    anim = Animal()
    anim.speak()
    print(anim[6])
    
    class Cat: Animal {
        override func speak() {
            super.speak()
            print("Cat speak")
        }
        override subscript(index: Int) -> Int {
            return super[index] + 1
        }
    }
    anim = Cat()
    anim.speak()
    print(anim[6])
}

// MARK: - 重写类型方法, 下标
/*
 被class修饰的类型方法, 下标, 允许被子类重写
 被static修饰的类型方法, 下标, 不允许被子类重写
 */

do {
    class Animal {
        class func speak() {
            print("Animal speak")
        }
        class subscript(index: Int) -> Int {
            return index
        }
    }
    Animal.speak()
    print(Animal[6])
    
    class Cat: Animal {
        override class func speak() {
            super.speak()
            print("Cat speak")
        }
        override class subscript(index: Int) -> Int {
            return super[index] + 1
        }
    }
    Cat.speak()
    print(Cat[6])
}

// MARK: - 重写实例属性
/*
 子类可以将父类的属性(存储, 计算)重写为计算属性
 子类不可以将父类属性重写为存储属性
 只能重写var属性, 不能重写let属性
 重写时, 属性名, 类型要一致
 
 子类重写后的属性权限不能小于父类属性的权限
 如果父类属性是只读的, 那么子类重写后的属性可以是只读的, 也可以是读写的
 如果父类属性是可读写的, 那么子类重写后的属性也必须是可读写的
 */

do {
    class Circle {
        var radius: Int = 0
        var diameter: Int {
            set {
                print("Circle setDiameter")
                radius = newValue / 2
            }
            get {
                print("Circle getDiameter")
                return radius * 2
            }
        }
    }
    var circle: Circle
    circle = Circle()
    circle.radius = 6
    print(circle.diameter)
    circle.diameter = 20
    print(circle.radius)
    
    class SubCircle: Circle {
        override var radius: Int {
            set {
                print("SubCircle setRadius")
                super.radius = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getRadius")
                return super.radius
            }
        }
        override var diameter: Int {
            set {
                print("SubCircle setDiameter")
                super.diameter = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getDiameter")
                return super.diameter
            }
        }
    }
    circle = SubCircle()
    circle.radius = 6
    print(circle.diameter)
    circle.diameter = 20
    print(circle.radius)
}

// MARK: - 重写类型属性
/*
 被class修饰的计算类型属性, 可以被子类重写
 被static修饰的类型属性(存储, 计算), 不可以被子类重写
 */

do {
    class Circle {
        static var radius: Int = 0
        class var diameter: Int {
            set {
                print("Circle setDiameter")
                radius = newValue / 2
            }
            get {
                print("Circle getDiameter")
                return radius * 2
            }
        }
    }
    
    class SubCircle: Circle {
        override class var diameter: Int {
            set {
                print("SubCircle setDiameter")
                super.diameter = newValue > 0 ? newValue : 0
            }
            get {
                print("SubCircle getDiameter")
                return super.diameter
            }
        }
    }
    
    Circle.radius = 6
    print(Circle.diameter)
    Circle.diameter = 20
    print(Circle.radius)
    
    SubCircle.radius = 6
    print(SubCircle.diameter)
    SubCircle.diameter = 20
    print(SubCircle.radius)
}

// MARK: - 属性观察器
// 可以在子类中为父类属性(除了只读计算属性, let属性)增加属性观察器

do {
    class Circle {
        var radius: Int = 1
    }
    class SubCircle: Circle {
        override var radius: Int {
            willSet {
                print("SubCircle willSetRadius", newValue)
            }
            didSet {
                print("SubCircle didSetRadius", oldValue, radius)
            }
        }
    }
    var circle = SubCircle()
    circle.radius = 10
}

do {
    class Circle {
        var radius: Int = 1 {
            willSet {
                print("Circle willSetRadius", newValue)
            }
            didSet {
                print("Circle didSetRadius", oldValue, radius)
            }
        }
    }
    class SubCircle: Circle {
        override var radius: Int {
            willSet {
                print("SubCircle willSetRadius", newValue)
            }
            didSet {
                print("SubCircle didSetRadius", oldValue, radius)
            }
        }
    }
    var circle = SubCircle()
    circle.radius = 10
}

do {
    class Circle {
        var radius: Int {
            set {
                print("Circle setRadius", newValue)
            }
            get {
                print("Circle getRadius")
                return 20
            }
        }
    }
    class SubCircle: Circle {
        override var radius: Int {
            willSet {
                print("SubCircle willSetRadius", newValue)
            }
            didSet {
                print("SubCircle didSetRadius", oldValue, radius)
            }
        }
    }
    var circle = SubCircle()
    circle.radius = 10
}

do {
    class Circle {
        class var radius: Int {
            set {
                print("Circle setRadius", newValue)
            }
            get {
                print("Circle getRadius")
                return 20
            }
        }
    }
    class SubCircle: Circle {
        override static var radius: Int {
            willSet {
                print("SubCircle willSetRadius", newValue)
            }
            didSet {
                print("SubCircle didSetRadius", oldValue, radius)
            }
        }
    }
    /*
     Circle getRadius // oldValue
     SubCircle willSetRadius 10
     Circle setRadius 10
     Circle getRadius
     SubCircle didSetRadius 20 20
     */
    SubCircle.radius = 10
}

// MARK: - 多态的实现原理
/*
 1. OC: Runtime
 2. C++: 虚表 (虚函数表)
 
 Swift中多态的实现原理
 */

do {
    struct Animal {
        func speak() {
            print("Animal speak")
        }
        func eat() {
            print("Animal eat")
        }
        func sleep() {
            print("Animal sleep")
        }
    }
    /*
     0x10000308b <+5771>: callq  0x1000036b0               ; init() -> Animal #4 in _1_继承 in Animal #4 in _1_继承 at main.swift:343
     0x100003090 <+5776>: callq  0x1000036c0               ; speak() -> () in Animal #4 in _1_继承 at main.swift:344
     0x100003095 <+5781>: callq  0x100003770               ; eat() -> () in Animal #4 in _1_继承 at main.swift:347
     0x10000309a <+5786>: callq  0x100003820               ; sleep() -> () in Animal #4 in _1_继承 at main.swift:350
     */
    var anim = Animal()
    anim.speak()
    anim.eat()
    anim.sleep()
}

do {
    class Animal {
        func speak() {
            print("Animal speak")
        }
        func eat() {
            print("Animal eat")
        }
        func sleep() {
            print("Animal sleep")
        }
    }
    /*
     0x100002bc1 <+5825>: callq  0x100006ea0               ; type metadata accessor for Animal #5 in _1_继承 at <compiler-generated>
     0x100002bc6 <+5830>: movq   %rax, %r13
     0x100002bc9 <+5833>: movq   %rdx, -0x640(%rbp)
     0x100002bd0 <+5840>: callq  0x1000034a0               ; __allocating_init() -> Animal #5 in _1_继承 in Animal #5 in _1_继承 at main.swift:367
     0x100002bd5 <+5845>: movq   %rax, -0x158(%rbp)
     0x100002bdc <+5852>: movq   %rax, %rcx
     0x100002bdf <+5855>: movq   %rcx, %rdi
     0x100002be2 <+5858>: movq   %rax, -0x648(%rbp)
     0x100002be9 <+5865>: callq  0x10000b20e               ; symbol stub for: swift_retain
     0x100002bee <+5870>: movq   -0x648(%rbp), %r13
     0x100002bf5 <+5877>: movq   %rax, -0x650(%rbp)
     0x100002bfc <+5884>: callq  0x100007640               ; speak() -> () in Animal #5 in _1_继承 at main.swift:368
     0x100002c01 <+5889>: movq   -0x648(%rbp), %rdi
     0x100002c08 <+5896>: callq  0x10000b208               ; symbol stub for: swift_release
     0x100002c0d <+5901>: movq   -0x648(%rbp), %rax
     0x100002c14 <+5908>: movq   %rax, %rdi
     0x100002c17 <+5911>: callq  0x10000b20e               ; symbol stub for: swift_retain
     0x100002c1c <+5916>: movq   -0x648(%rbp), %r13
     0x100002c23 <+5923>: movq   %rax, -0x658(%rbp)
     0x100002c2a <+5930>: callq  0x100007700               ; eat() -> () in Animal #5 in _1_继承 at main.swift:371
     0x100002c2f <+5935>: movq   -0x648(%rbp), %rdi
     0x100002c36 <+5942>: callq  0x10000b208               ; symbol stub for: swift_release
     0x100002c3b <+5947>: movq   -0x648(%rbp), %rax
     0x100002c42 <+5954>: movq   %rax, %rdi
     0x100002c45 <+5957>: callq  0x10000b20e               ; symbol stub for: swift_retain
     0x100002c4a <+5962>: movq   -0x648(%rbp), %r13
     0x100002c51 <+5969>: movq   %rax, -0x660(%rbp)
     0x100002c58 <+5976>: callq  0x1000077c0               ; sleep() -> () in Animal #5 in _1_继承 at main.swift:374
     0x100002c5d <+5981>: movq   -0x648(%rbp), %rdi
     0x100002c64 <+5988>: callq  0x10000b208               ; symbol stub for: swift_release
     0x100002c69 <+5993>: movq   -0x158(%rbp), %rdi
     0x100002c70 <+6000>: callq  0x10000b208               ; symbol stub for: swift_release
     */
    var anim = Animal()
    anim.speak()
    anim.eat()
    anim.sleep()
    
    class Dog: Animal {
        override func speak() {
            print("Dog speak")
        }
        override func eat() {
            print("Dog eat")
        }
        func run() {
            print("Dog run")
        }
    }
    /*
     0x100002737 <+6007>: callq  0x100007470               ; type metadata accessor for Dog #2 in _1_继承 at <compiler-generated>
     
     (lldb) register read rax
     rax = 0x000000010000fc58  type metadata for Dog #2 in _1_继承
     
     0x10000273c <+6012>: movq   %rax, %r13
     0x10000273f <+6015>: movq   %rdx, -0x668(%rbp)
     0x100002746 <+6022>: callq  0x100003090               ; __allocating_init() -> Dog #2 in _1_继承 in Dog #2 in _1_继承 at main.swift:417
     0x10000274b <+6027>: movq   %rax, %rcx
     0x10000274e <+6030>: movq   %rcx, -0x158(%rbp)
     0x100002755 <+6037>: movq   -0x648(%rbp), %rdi
     0x10000275c <+6044>: movq   %rax, -0x670(%rbp)
     0x100002763 <+6051>: movq   %rcx, -0x678(%rbp)
     0x10000276a <+6058>: callq  0x10000b128               ; symbol stub for: swift_release
     0x10000276f <+6063>: movq   -0x678(%rbp), %rax
     0x100002776 <+6070>: movq   %rax, %rdi
     0x100002779 <+6073>: callq  0x10000b12e               ; symbol stub for: swift_retain
     0x10000277e <+6078>: movq   -0x670(%rbp), %rcx
     0x100002785 <+6085>: movq   (%rcx), %rdx
     0x100002788 <+6088>: movq   -0x678(%rbp), %r13
     0x10000278f <+6095>: movq   %rax, -0x680(%rbp)
     
     (lldb) register read rdx
     rdx = 0x000000010000fc58  type metadata for Dog #2 in _1_继承
     
     0x100002796 <+6102>: callq  *0x50(%rdx) // Dog.speak() 0x50 为类型信息固定偏移量
     0x100002799 <+6105>: movq   -0x678(%rbp), %rdi
     0x1000027a0 <+6112>: callq  0x10000b128               ; symbol stub for: swift_release
     0x1000027a5 <+6117>: movq   -0x678(%rbp), %rax
     0x1000027ac <+6124>: movq   %rax, %rdi
     0x1000027af <+6127>: callq  0x10000b12e               ; symbol stub for: swift_retain
     0x1000027b4 <+6132>: movq   -0x670(%rbp), %rcx
     0x1000027bb <+6139>: movq   (%rcx), %rdx
     0x1000027be <+6142>: movq   -0x678(%rbp), %r13
     0x1000027c5 <+6149>: movq   %rax, -0x688(%rbp)
     0x1000027cc <+6156>: callq  *0x58(%rdx) // Dog.eat()
     0x1000027cf <+6159>: movq   -0x678(%rbp), %rdi
     0x1000027d6 <+6166>: callq  0x10000b128               ; symbol stub for: swift_release
     0x1000027db <+6171>: movq   -0x678(%rbp), %rax
     0x1000027e2 <+6178>: movq   %rax, %rdi
     0x1000027e5 <+6181>: callq  0x10000b12e               ; symbol stub for: swift_retain
     0x1000027ea <+6186>: movq   -0x678(%rbp), %r13
     0x1000027f1 <+6193>: movq   %rax, -0x690(%rbp)
     0x1000027f8 <+6200>: callq  0x1000073b0               ; sleep() -> () in Animal #5 in _1_继承 at main.swift:374
     0x1000027fd <+6205>: movq   -0x678(%rbp), %rdi
     0x100002804 <+6212>: callq  0x10000b128               ; symbol stub for: swift_release
     0x100002809 <+6217>: movq   -0x158(%rbp), %rdi
     0x100002810 <+6224>: callq  0x10000b128               ; symbol stub for: swift_release
     */
    anim = Dog()
    anim.speak()
    anim.eat()
    anim.sleep()
}

