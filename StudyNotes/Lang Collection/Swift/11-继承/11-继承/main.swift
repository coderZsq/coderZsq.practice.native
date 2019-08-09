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
    SubCircle.radius = 10
}
