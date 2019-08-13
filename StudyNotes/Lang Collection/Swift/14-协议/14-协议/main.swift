//
//  main.swift
//  14-协议
//
//  Created by 朱双泉 on 2019/8/13.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 协议 (Protocol)

protocol Drawable {
    func draw()
    var x: Int { get set }
    var y: Int { get }
    subscript(index: Int) -> Int { get set }
}

protocol Test1 {}
protocol Test2 {}
protocol Test3 {}

do {
    class TestClass: Test1, Test2, Test3 {}
}

// MARK: - 协议中的属性
/*
 协议中定义属性时必须用var关键字
 实现协议时的属性权限要不小于协议中定义的属性权限
 协议定义get, set, 用var存储属性或get, set计算属性去实现
 协议定义get, 用任何属性可以实现
 */

protocol Drawable2 {
    func draw()
    var x: Int { get set }
    var y: Int { get }
    subscript(index: Int) -> Int { get set }
}

do {
    class Person: Drawable2 {
        var x: Int = 0
        var y: Int = 0
        func draw() {
            print("Person draw")
        }
        subscript(index: Int) -> Int {
            set {}
            get { index }
        }
    }
}

do {
    class Person: Drawable2 {
        var x: Int {
            get { 0 }
            set {}
        }
        var y: Int { 0 }
        func draw() { print("Person draw") }
        subscript(index: Int) -> Int {
            set {}
            get { index }
        }
    }
}

// MARK: - static, class
// 为了保证通用, 协议中必须用static定义类型方法, 类型属性, 类型下标

protocol Drawable3 {
    static func draw()
}

do {
    class Person1: Drawable3 {
        class func draw() {
            print("Person1 draw")
        }
    }
    class Person2: Drawable3 {
        static func draw() {
            print("Person2 draw")
        }
    }
}

// MARK: - mutating
/*
 只有将协议中的实例方法标记为mutating
 才允许结构体, 枚举的具体实现修改自身内存
 类在实现方法时不用加mutating, 枚举 结构体才需要加mutating
 */

protocol Drawable4 {
    mutating func draw()
}

do {
    class Size: Drawable4 {
        var width: Int = 0
        func draw() {
            width = 10
        }
    }
    struct Point: Drawable4 {
        var x: Int = 0
        mutating func draw() {
            x = 10
        }
    }
}

// MARK: - init
/*
 协议中还可以定义初始化器init
 非final类实现时必须加上required
 如果从协议实现的初始化器, 刚好是重写了父类的制定初始化器
 那么这个初始化必须同时加required, override
 */

protocol Drawable5 {
    init(x: Int, y: Int)
}

do {
    class Point: Drawable5 {
        required init(x: Int, y: Int) {}
    }
    final class Size: Drawable5 {
        init(x: Int, y: Int) {}
    }
}

protocol Livable {
    init(age: Int)
}

do {
    class Person {
        init(age: Int) {}
    }
    class Student: Person, Livable {
        required override init(age: Int) {
            super.init(age: age)
        }
    }
}

// MARK: - init, init?, init!
/*
 协议中定义的init?, init!, 可以用init, init?, init!去实现
 协议中定义的init, 可以用init, init!去实现
 */

protocol Livable2 {
    init()
    init?(age: Int)
    init!(no: Int)
}

do {
    class Person: Livable2 {
        required init() {}
//        required init!() {}

        required init?(age: Int) {}
//        required init!(age: Int) {}
//        required init(age: Int) {}
        
        required init!(no: Int) {}
//        required init?(no: Int) {}
//        required init(no: Int) {}
    }
}

// MARK: - 协议的继承

protocol Runnable {
    func run()
}

protocol Livable3: Runnable {
    func breath()
}

do {
    class Person: Livable3 {
        func breath() {}
        func run() {}
    }
}

// MARK: - 协议组合
// 协议组合, 可以包含1个类类型 (最多1个)

protocol Livable4 {}
protocol Runnable2 {}

do {
    class Person {}
    
    func fn0(obj: Person) {}
    func fn1(obj: Livable4) {}
    func fn2(obj: Livable4 & Runnable2) {}
    func fn3(obj: Person & Livable4 & Runnable2) {}
    typealias RealPerson = Person & Livable4 & Runnable2
    func fn4(obj: RealPerson) {}
}

// MARK: - CaseIterable
// 让枚举遵守CaseIterable协议, 可以实现遍历枚举值

do {
    enum Season: CaseIterable {
        case spring, summer, autumn, winter
    }
    let seasons = Season.allCases
    print(seasons.count)
    for season in seasons {
        print(season)
    }
}

// MARK: - CustomStringConvertible
/*
 遵守CustomStringConvertible, CustomDebugStringConvertible协议, 都可以自定义实例的打印字符串
 print 调用的是 CustomStringConvertible 协议的 description
 debugPrint, po 调用的是 CustomDebugStringConvertible协议的 debugDescription
 */

do {
    class Person: CustomStringConvertible, CustomDebugStringConvertible {
        var age = 0
        var description: String { "person_\(age)" }
        var debugDescription: String { "debug_person_\(age)" }
    }
    var person = Person()
    print(person)
    debugPrint(person)
}

// MARK: - Any, AnyObject
/*
 Swift提供了2种特殊的类型: Any, AnyObject
 Any: 可以代表任意类型 (枚举, 结构体, 类, 也包括函数类型)
 AnyObject: 可以代表任意类类型 (在协议后面写上: AnyObject代表只有类能遵守这个协议)
 在协议后面写上: class也代表只有类能遵守这个协议
 */

do {
    class Student {}
    var stu: Any = 10
    stu = "Jack"
    stu = Student()
    var data = [Any]()
    data.append(1)
    data.append(3.14)
    data.append(Student())
    data.append("Jack")
    data.append({ 10 })
}

// MARK: - is, as?, as!, as
// is用来判断是否为某种类型, as用来做强制类型转换

protocol Runnable3 { func run() }

do {
    class Person {}
    class Student: Person, Runnable3 {
        func run() {
            print("Student run")
        }
        func study() {
            print("Student study")
        }
    }
    var stu: Any = 10
    print(stu is Int)
    stu = "Jack"
    print(stu is String)
    stu = Student()
    print(stu is Person)
    print(stu is Student)
    print(stu is Runnable3)
    (stu as? Student)?.study()
    stu = Student()
    (stu as? Student)?.study()
    (stu as! Student).study()
    (stu as? Runnable3)?.run()
    var data = [Any]()
    data.append(Int("123") as Any)
    var d = 10 as Double
    print(d)
}

// MARK: - X.self, X.Type, AnyClass
/*
 X.self是一个元类型(metadata)的指针, metadata存放着类型相关信息
 X.self属于X.Type类型
 */

do {
    class Person {}
    class Student: Person {}
    var perType: Person.Type = Person.self
    var stuType: Student.Type = Student.self
    perType = Student.self
    
    var anyType: AnyObject.Type = Person.self
    anyType = Student.self
    
    typealias AnyClass = AnyObject.Type
    var anyType2: AnyClass = Person.self
    anyType2 = Student.self
    
    var per = Person()
    perType = type(of: per)
    print(Person.self == type(of: per))
}

// MARK: - 元类型的应用

do {
    class Animal { required init() {} }
    class Cat: Animal {}
    class Dog: Animal {}
    class Pig: Animal {}
    
    func create(_ clses: [Animal.Type]) -> [Animal] {
        var arr = [Animal]()
        for cls in clses {
            arr.append(cls.init())
        }
        return arr
    }
    print(create([Cat.self, Dog.self, Pig.self]))
}

import Foundation
do {
    class Person {
        var age: Int = 0
    }
    class Student: Person {
        var no: Int = 0
    }
    print(class_getInstanceSize(Student.self))
    print(class_getSuperclass(Student.self)!)
    print(class_getSuperclass(Person.self)!)
}

// MARK: - Self

do {
    class Person {
        var age = 1
        static var count = 2
        func run() {
            print(self.age)
            print(Self.count)
        }
    }
}

protocol Runnable4 {
    func test() -> Self
}

do {
    class Person: Runnable4 {
        required init() {}
        func test() -> Self { type(of: self).init() }
    }
    class Student: Person {}
    var p = Person()
    print(p.test())
    var stu = Student()
    print(stu.test())
}
