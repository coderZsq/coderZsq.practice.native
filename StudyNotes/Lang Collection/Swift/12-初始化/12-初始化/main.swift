//
//  main.swift
//  12-初始化
//
//  Created by 朱双泉 on 2019/8/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 初始化器
/*
 初始化器的相互调用规则
 指定初始化器必须从它的直系父类调用指定初始化器
 便捷初始化器必须从相同的类里调用另一个初始化器
 便捷初始化器最终必须调用一个指定初始化器
 */

do {
    class Size {
        var width: Int = 0
        var height: Int = 0
        init(width: Int, height: Int) {
            self.width = width
            self.height = height
        }
        convenience init(width: Int) {
            self.init(width: width, height: 0)
        }
        convenience init(height: Int) {
            self.init(width: 0, height: height)
        }
        convenience init() {
            self.init(width: 0, height: 0)
        }
    }
    var s1 = Size(width: 10, height: 20)
    var s2 = Size(width: 10)
    var s3 = Size(height: 20)
    var s4 = Size()
}

// MARK: - 两段式初始化
/*
 Swift在编码安全方面是煞费苦心, 为了保证初始化过程的安全, 设定了两段式初始化, 安全检查
 
 两段式初始化
 第1阶段: 初始化所有存储属性
 1. 外层调用指定, 便捷初始化器
 2. 分配内存给实例, 但未初始化
 3. 指定初始化器确保当前类定义的存储属性都初始化
 4. 指定初始化器调用父类的初始化器, 不断向上调用, 形成初始化器链
 
 第2阶段: 设置新的存储属性值
 1. 从顶部初始化器往下, 链中的每一个指定初始化器都有机会进一步定制实例
 2. 初始化器现在能够使用self(访问, 修改它的属性, 调用它的实例方法等等)
 3. 最终, 链中任何便捷初始化器都有机会定制实例以及使用self
 */

do {
    class Person {
        var age: Int
        init(age: Int) {
            print(#line, #function)
            self.age = age
            print(#line, "step2")
            print(#line, #function)
            self.test()
        }
        convenience init() {
            print(#line, #function)
            self.init(age: 0)
            print(#line, #function)
        }
        func test() {
            
        }
    }
    class Student: Person {
        var score: Int
        init(age: Int, score: Int) {
            print(#line, #function)
            self.score = score
            super.init(age: age)
            print(#line, #function)
        }
//        init() {
//            self.score = 0
//            super.init(age: 0)
//        }
        convenience init() {
            print(#line, #function)
            self.init(score: 0)
            print(#line, #function)
        }
        convenience init(score: Int) {
            print(#line, #function)
            self.init(age: 0, score: score)
            print(#line, #function)
        }
    }
    print(#line, "step1")
    var stu = Student()
}

// MARK: - 重写

do {
    class Person {
        var age: Int
        init(age: Int) {
            self.age = age
        }
        convenience init() {
            self.init(age: 0)
        }
    }
    class Student: Person {
        var score: Int
        init(age: Int, score: Int) {
            self.score = score
            super.init(age: age)
        }
//        override init(age: Int) {
//            self.score = 0
//            super.init(age: age)
//        }
        override convenience init(age: Int) {
            self.init(age: age, score: 0)
        }
//        init() {
//            self.score = 0
//            super.init(age: 0)
//        }
//        convenience init() {
//            self.init(age: 0, score: 0)
//        }
    }
}

// MARK: - 自动继承

do {
    class Person {
        var age: Int
        var name: String
        init(age: Int, name: String) {
            self.age = age
            self.name = name
        }
        init(age: Int) {
            self.age = age
            self.name = ""
        }
    }
    class Student: Person {
//        init() {
//
//        }
        convenience init(no: Int) {
            self.init(age: 0)
        }
    }
    var stu1 = Student(age: 10)
    var stu2 = Student(age: 10, name: "Jack")
    var stu3 = Student(no: 20)
}

do {
    class Person {
        var age: Int
        var name: String
        init(age: Int, name: String) {
            self.age = age
            self.name = name
        }
        init() {
            self.age = 0
            self.name = ""
        }
        convenience init(age: Int) {
            self.init(age: age, name: "")
        }
        convenience init(name: String) {
            self.init(age: 0, name: name)
        }
    }
    class Student: Person {
        init(no: Int) {
            super.init()
        }
//        override init(age: Int, name: String) {
//            super.init(age: age, name: name)
//        }
//        override init() {
//            super.init(age: 0, name: "")
//        }
        override convenience init(age: Int, name: String) {
            self.init(no: 0)
        }
        override convenience init() {
            self.init(no: 0)
        }
    }
    var stu1 = Student(age: 0, name: "")
    var stu2 = Student(age: 0)
    var stu3 = Student(name: "")
    var stu4 = Student(no: 0)
    var stu5 = Student()
}

do {
    class Person {
        var age: Int
        var name: String
        init(age: Int, name: String) {
            self.age = age
            self.name = name
        }
        init() {
            self.age = 0
            self.name = ""
        }
        convenience init(age: Int) {
            self.init(age: age, name: "")
        }
        convenience init(name: String) {
            self.init(age: 0, name: name)
        }
    }
    class Student: Person {
        convenience init(no: Int) {
            self.init()
        }
    }
    var stu1 = Student(age: 0, name: "")
    var stu2 = Student(age: 0)
    var stu3 = Student(name: "")
    var stu4 = Student(no: 0)
    var stu5 = Student()
}

// MARK: - required
/*
 用required修饰指定初始化器, 表明其所有子类都必须实现该初始化器 (通过继承或者重写实现)
 如果子类重写了required初始化器, 也必须加上required, 不用加override
 */

do {
    class Person {
        required init() {}
        init(age: Int) {}
    }
    class Student: Person {
        required init() {
            super.init()
        }
    }
}

// MARK: - 属性观察器
/*
 父类的属性在它自己的初始化器中赋值不会触发属性观察器, 但在子类的初始化器中赋值会触发属性观察器
 */

do {
    class Person {
        var age: Int {
            willSet {
                print("willSet", newValue)
            }
            didSet {
                print("didSet", oldValue, age)
            }
        }
        init() {
            self.age = 0
        }
    }
    class Student: Person {
        override init() {
            super.init()
            self.age = 1
        }
    }
    var stu = Student()
}

// MARK: - 可失败初始化器
/*
 不允许同时定义参数标签, 参数个数, 参数类型相同的可是白初始化器和非可失败初始化器
 可以用init!定义隐式解包的可失败初始化器
 可是白初始化器可以调用非可失败初始化器, 非可失败初始化器调用可失败初始化器需要进行解包
 如果初始化器调用一个可失败初始化器导致初始化失败, 那么整个初始化过程都失败, 并且之后的代码都停止执行
 可以用一个非可失败初始化器重写一个可失败初始化器, 但反过来是不行的
 */

do {
    class Person {
        var name: String
        init?(name: String) {
            if name.isEmpty {
                return nil
            }
            self.name = name
        }
    }
}

do {
    var num = Int("123")
//    public init?(_ description: String)
}

do {
    enum Answer: Int {
        case wrong, right
    }
    var an = Answer(rawValue: 1)
}

// MARK: - 反初始化器 (deinit)
/*
 deinit不接受任何参数, 不能写小括号, 不能自行调用
 父类的deinit能被子类继承
 子类的deinit实现执行完毕后会调用父类的deinit
 */

do {
    class Person {
        deinit {
            print("Person对象销毁了")
        }
    }
}
