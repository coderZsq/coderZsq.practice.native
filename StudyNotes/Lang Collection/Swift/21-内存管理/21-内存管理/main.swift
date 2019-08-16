//
//  main.swift
//  21-内存管理
//
//  Created by 朱双泉 on 2019/8/16.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - weak, unowned的使用限制
// weak, unowned只能用在类实例上面

protocol Livable: AnyObject {}

do {
    class Person {}
    
    weak var p0: Person?
    weak var p1: AnyObject?
    weak var p2: Livable?
    
    unowned var p10: Person?
    unowned var p11: AnyObject?
    unowned var p12: Livable?
}

// MARK: - Autoreleasepool
// public func autoreleasepool<Result>(invoking body: () throws -> Result) rethrows -> Result
    
import Foundation
class SQPerson: NSObject {
    var age: Int
    var name: String
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    func run() {
        print(#line, #function)
    }
    deinit {
        print(#line, #function)
    }
}

autoreleasepool {
    let p = SQPerson(age: 20, name: "Jack")
    p.run()
}

// MARK: - 闭包的循环引用
/*
 闭包表达式默认会对用到的外层对象产生额外的强引用 (对外层对象进行了 retain 操作)
 下面代码会产生循环引用, 导致 Person 对象无法释放 (看不到 Person 的 deinit 被调用)
 在闭包表达式的捕获列表声明 weak 或 unowned 引用, 解决循环引用问题
 */

do {
    class Person {
        var fn: (() -> ())?
        func run() { print("run") }
        deinit { print("deinit") }
    }
    func test() {
        let p = Person()
        p.fn = { p.run() }
    }
    test()
}

do {
    class Person {
        var fn: (() -> ())?
        func run() { print("run") }
        deinit { print("deinit") }
    }
    func test() {
        let p = Person()
        p.fn = {
            [weak p] in
            p?.run()
        }
    }
    test()
}

do {
    class Person {
        var fn: (() -> ())?
        func run() { print("run") }
        deinit { print("deinit") }
    }
    func test() {
        let p = Person()
        p.fn = {
            [unowned p] in
            p.run()
        }
    }
    test()
}

do {
    class Person {
        var fn: (() -> ())?
        func run() { print("run") }
        deinit { print("deinit") }
    }
    func test() {
        let p = Person()
        p.fn = {
            [weak wp = p, unowned up = p, a = 10 + 20] in
            wp?.run()
        }
    }
    test()
}

/*
 如果想在定义闭包属性的同时引用self, 这个闭包必须是lazy的 (因为在实例初始化完毕之后才能引用self)
 下边的闭包fn内部如果用到了实例成员 (属性, 方法)
 编译器会强制要求明确写出self
 */

do {
    class Person {
        lazy var fn: (() -> ()) = {
            [weak self] in
            self?.run()
        }
        func run() { print("run") }
        deinit { print("deinit") }
    }
}

// 如果lazy属性是闭包调用的结果, 那么不用考虑循环引用的问题 (因为闭包调用后, 闭包的生命周期就结束了)

do {
    class Person {
        var age: Int = 0
        lazy var getAge: Int = {
            self.age
        }()
        deinit { print("deinit") }
    }
}

// MARK: - @escaping
/*
 非逃逸闭包, 逃逸闭包, 一般都是当做参数传递给函数
 非逃逸闭包: 闭包调用发生在函数结束前, 闭包调用在函数作用域内
 逃逸闭包: 闭包有可能在函数结束后调用, 闭包调用逃离了函数的作用域, 需要通过@escaping声明
 */

import Dispatch

do {
    typealias Fn = () -> ()
    func test1(_ fn: Fn) { fn() }
    var gFn: Fn?
    func test2(_ fn: @escaping Fn) { gFn = fn }
    func test3(_ fn: @escaping Fn) {
        DispatchQueue.global().async {
            fn()
        }
    }
}

do {
    typealias Fn = () -> ()
    class Person {
        var fn: Fn
        init(fn: @escaping Fn) {
            self.fn = fn
        }
        func run() {
            // DispatchQueue.global().async 也是一个逃逸闭包
            // 它用到了实例成员 (属性, 方法), 编译器会强制要求明确写出self
            DispatchQueue.global().async {
                self.fn()
            }
        }
    }
}

// MARK: - 逃逸闭包的注意点
// 逃逸闭包不可以捕获inout参数

do {
    typealias Fn = () -> ()
    func other1(_ fn: Fn) { fn() }
    func other2(_ fn: @escaping Fn) { fn() }
//    func test(value: inout Int) -> Fn {
//        other1 { value += 1 }
//        Escaping closure captures 'inout' parameter 'value'
//        other2 { value += 1 }
//        func plus() { value += 1}
//        Escaping closure captures 'inout' parameter 'value'
//        return plus
//    }
}

// MARK: - 内存访问冲突 (Conflicting Access to Memory)
/*
 内存访问冲突会在两个访问满足下列条件时发生:
 至少一个是写入操作
 它们访问的是同一块内存
 它们的访问时间重叠 (比如在同一个函数内)
 */

do {
    func plus(_ num: inout Int) -> Int { num + 1 }
    var number = 1
    number = plus(&number)
}

do {
//    Simultaneous accesses to 0x1021787f0, but modification requires exclusive access.
    var step = 1
    func increment(_ num: inout Int) { num += step }
//    increment(&step)
}

do {
    var step = 1
    func increment(_ num: inout Int) { num += step }
    var copyOfStep = step
    increment(&copyOfStep)
    step = copyOfStep
}

do {
    func balance(_ x: inout Int, _ y: inout Int) {
        let sum = x + y
        x = sum / 2
        y = sum - x
    }
    var num1 = 42
    var num2 = 30
    balance(&num1, &num2)
//    Inout arguments are not allowed to alias each other
//    balance(&num1, &num1)
    
    struct Player {
        var name: String
        var health: Int
        var energy: Int
        mutating func shareHealth(with teammate: inout Player) {
            balance(&teammate.health, &health)
        }
    }
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    var maria = Player(name: "Maria", health: 5, energy: 10)
    oscar.shareHealth(with: &maria)
//    Inout arguments are not allowed to alias each other
//    oscar.shareHealth(with: &oscar)
    
    // 全局作用域 会内存访问冲突
    var tulpe = (health: 10, energy: 20)
    balance(&tulpe.health, &tulpe.energy)

    // 全局作用域 会内存访问冲突
    var holly = Player(name: "Holly", health: 10, energy: 10)
    balance(&holly.health, &holly.energy)
    
    /*
     如果下面的条件可以满足, 就说明重叠访问结构体的属性时安全的
     你只访问实例存储属性, 不是计算属性或者类属性
     结构体是局部变量而非全局变量
     结构体要么没有被闭包捕获要么只被非逃逸闭包捕获
     */
    func test() {
        var tulpe = (health: 10, energy: 20)
        balance(&tulpe.health, &tulpe.energy)
        
        var holly = Player(name: "Holly", health: 10, energy: 10)
        balance(&holly.health, &holly.energy)
    }
    test()
}

// MARK: - 指针
/*
 Swift中也有专门的指针类型, 这些都被定性为"Unsafe" (不安全的), 常见的有以下4种类型
 UnsafePointer<Pointee> 类似于 const Pointee *
 UnsafeMutablePointer<Pointee> 类似于 Pointee *
 UnsafeRawPointer 类似于 const void *
 UnsafeMutableRawPointer 类似于 void *
 */

do {
    var age = 10
    func test1(_ ptr: UnsafeMutablePointer<Int>) {
        ptr.pointee += 10
    }
    func test2(_ ptr: UnsafePointer<Int>) {
        print(ptr.pointee)
    }
    test1(&age)
    test2(&age)
    print(age)
}

do {
    var age = 10
    func test3(_ ptr: UnsafeMutableRawPointer) {
        ptr.storeBytes(of: 20, as: Int.self)
    }
    func test4(_ ptr: UnsafeRawPointer) {
        print(ptr.load(as: Int.self))
    }
    test3(&age)
    test4(&age)
    print(age)
}

// MARK: - 指针的应用示例

do {
    var arr = NSArray(objects: 11, 22, 33, 44)
    arr.enumerateObjects { (obj, idx, stop) in
        print(idx, obj)
        if idx == 2 {
            stop.pointee = true
        }
    }
}

do {
    var arr = NSArray(objects: 11, 22, 33, 44)
    for (idx, obj) in arr.enumerated() {
        print(idx, obj)
        if idx == 2 {
            break
        }
    }
}

// MARK: - 获得指向某个变量的指针

do {
    var age = 11
    var ptr1 = withUnsafeMutablePointer(to: &age) { $0 }
    var ptr2 = withUnsafePointer(to: &age) { $0 }
    ptr1.pointee = 22
    print(ptr2.pointee)
    print(age)
    
    var ptr3 = withUnsafeMutablePointer(to: &age) { UnsafeMutableRawPointer($0) }
    var ptr4 = withUnsafePointer(to: &age) { UnsafeRawPointer($0) }
    ptr3.storeBytes(of: 33, as: Int.self)
    print(ptr4.load(as: Int.self))
    print(age)
}

// MARK: - 获得指向对空间实例的指针

do {
    class Person {}
    var person = Person()
    var ptr = withUnsafePointer(to: &person) { UnsafeRawPointer($0) }
    var heapPtr = UnsafeRawPointer(bitPattern: ptr.load(as: UInt.self))
    print(heapPtr!)
}

// MARK: - 创建指针

do {
    var ptr = UnsafeRawPointer(bitPattern: 0x100001234)
}

do {
    var ptr = malloc(16)
    ptr?.storeBytes(of: 11, as: Int.self)
    ptr?.storeBytes(of: 22, toByteOffset: 8, as: Int.self)
    print((ptr?.load(as: Int.self))!)
    print((ptr?.load(fromByteOffset: 8, as: Int.self))!)
    free(ptr)
}

do {
    var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
    ptr.storeBytes(of: 11, as: Int.self)
    ptr.advanced(by: 8).storeBytes(of: 22, as: Int.self)
    print(ptr.load(as: Int.self))
    print(ptr.advanced(by: 8).load(as: Int.self))
    ptr.deallocate()
}

do {
    var ptr = UnsafeMutablePointer<Int>.allocate(capacity: 3)
    ptr.initialize(to: 11)
    ptr.successor().initialize(to: 22)
    ptr.successor().successor().initialize(to: 33)
    
    print(ptr.pointee)
    print((ptr + 1).pointee)
    print((ptr + 2).pointee)
    
    print(ptr[0])
    print(ptr[1])
    print(ptr[2])
    
    ptr.deinitialize(count: 3)
    ptr.deallocate()
}

do {
    class Person {
        var age: Int
        var name: String
        init(age: Int, name: String) {
            self.age = age
            self.name = name
        }
        deinit { print(name, "deinit") }
    }
    var ptr = UnsafeMutablePointer<Person>.allocate(capacity: 3)
    ptr.initialize(to: Person(age: 10, name: "Jack"))
    (ptr + 1).initialize(to: Person(age: 11, name: "Rose"))
    (ptr + 2).initialize(to: Person(age: 12, name: "Kate"))
    ptr.deinitialize(count: 3)
    ptr.deallocate()
}

// MARK: - 指针之间的转换
/*
 unsafeBitCast是忽略数据类型的强制转换, 不会因为数据类型的变化而改变原来的内存数据
 类似于C++中的reinterpret_cast
 */
do {
    var ptr = UnsafeMutableRawPointer.allocate(byteCount: 16, alignment: 1)
    ptr.assumingMemoryBound(to: Int.self).pointee = 11
    (ptr + 8).assumingMemoryBound(to: Double.self).pointee = 22.0
    print(unsafeBitCast(ptr, to: UnsafePointer<Int>.self).pointee)
    print(unsafeBitCast(ptr + 8, to: UnsafePointer<Double>.self).pointee)
    ptr.deallocate()
}

do {
    class Person {}
    var person = Person()
    var ptr = unsafeBitCast(person, to: UnsafeRawPointer.self)
    print(ptr)
}
