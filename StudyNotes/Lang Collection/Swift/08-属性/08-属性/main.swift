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
            set {
                radius = newValue / 2
            }
            get {
                radius * 2
            }
        }
    }
    print(MemoryLayout<Circle>.stride)
    
    var circle = Circle(radius: 5)
    print(circle.radius)
    print(circle.diameter)
    
    circle.diameter = 12
    print(circle.radius)
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
    print(TestEnum.test3.rawValue)
}

// MARK: - 延迟存储属性 (Lazy Stored Property)

do {
    class Car {
        init() {
            print("Car init!")
        }
        func run() {
            print("Car is running!")
        }
    }
    
//    class PhotoView {
//        lazy var image: Image = {
//            let url = "https://xx.png"
//            let data = Data(url: url)
//            return Image(data: data)
//        }()
//    }
    
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
}

// MARK: - 延迟存储属性注意点
/*
 当结构体包含一个延迟存储属性时, 只有var才能访问延迟存储属性
 因为延迟属性s初始化时需要改变结构体的内存
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
    test(&s.width)
    s.show()
    print("------")
    test(&s.side)
    s.show()
    print("------")
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
        static var count: Int = 0
        init() {
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
