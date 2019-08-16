//
//  main.swift
//  20-访问控制
//
//  Created by 朱双泉 on 2019/8/16.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 元组类型
// 元祖类型的访问级别是所有成员类型最低的那个

internal struct Dog {}
fileprivate class Person {}

fileprivate var data1: (Dog, Person)
private var data2: (Dog, Person)

// MARK: - 泛型类型
// 泛型类型的访问级别是类型的访问级别以及所有泛型类型参数的访问级别中最低的那个

internal class Car {}
fileprivate class Dog2 {}
public class Person2<T1, T2> {}

fileprivate var p = Person2<Car, Dog2>()

// 成员, 嵌套类型
/*
 类型的访问级别会影响成员(属性, 方法, 初始化器, 下标), 嵌套类型的默认访问级别
 一般情况下, 类型为private或fileprivate, 那么成员/嵌套类型默认也是private或fileprivate
 一般情况下, 类型internal或public, 那么成员/嵌套类型默认是internal
 */

public class PublicClass {
    public var p1 = 0
    var p2 = 0 // internal
    fileprivate func f1() {}
    private func f2() {}
}

class InternalClass { // internal
    var p = 0 // internal
    fileprivate func f1() {}
    private func f2() {}
}

fileprivate class FilePrivateClass {
    func f1() {} // fileprivate
    private func f2() {}
}

private class PrivateClass {
    func f() {} // private
}

// MARK: -  成员的重写
/*
 子类重写成员的访问级别必须 >= 子类的访问级别, 或者 >= 父类被重写成员的访问级别
 父类的成员不能被成员作用域外定义的子类重写
 */

public class Person3 {
    private var age: Int = 0
}
public class Student: Person3 {
//    Property does not override any property from its superclass
//    override var age: Int {
//        set {}
//        get {10}
//    }
}

public class Person4 {
    private var age: Int = 0
    
    public class Student: Person4 {
        override var age: Int {
            set {}
            get {10}
        }
    }
}

// MARK: - 下面代码能否编译通过
// 直接在全局作用域下定义的private等价于fileprivate

private class Person5 {}
fileprivate class Student2: Person5 {}

private struct Dog3 {
    var age: Int = 0
    func run() {}
}

fileprivate struct Person6 {
    var dog: Dog3 = Dog3()
    mutating func walk() {
        dog.run()
        dog.age = 1
    }
}

private struct Dog4 {
    private var age: Int = 0
    private func run() {}
}

fileprivate struct Person7 {
    var dog: Dog4 = Dog4()
    mutating func walk() {
//        'run' is inaccessible due to 'private' protection level
//        dog.run()
//        'age' is inaccessible due to 'private' protection level
//        dog.age = 1
    }
}

class Test {
    private struct Dog {
        var age: Int = 0
        func run() {}
    }
    private struct Person {
        var dog: Dog = Dog()
        mutating func walk() {
            dog.run()
            dog.age = 1
        }
    }
}

// MARK: - getter, setter
/*
 getter, setter 默认自动接收它们所属环境的访问级别
 可以给 setter 单独设置一个比 getter 更低的访问级别, 用以限制写的权限
 */

fileprivate(set) public var num = 10
class Person8 {
    private(set) var age = 0
    fileprivate(set) public var weight: Int {
        set {}
        get { 10 }
    }
    internal(set) public subscript(index: Int) -> Int {
        set {}
        get { index }
    }
}

// MARK: - 协议
/*
 协议中定义的要求自动接收协议的访问级别, 不能单独设置访问级别
 public 协议定义的要求也是 public
 
 协议实现的访问级别必须 >= 类型的访问级别, 或者 >= 协议的访问级别
 下面代码能编译通过么?
 */

public protocol Runnable {
    func run()
}

public class Person9: Runnable {
//    Method 'run()' must be declared public because it matches a requirement in public protocol 'Runnable'
//    func run() {}
    public func run() {}
}

// MARK: - 扩展
/*
 如果有显示设置扩展的访问级别, 扩展添加的成员自动接收扩展的访问级别
 
 如果没有显示设置扩展的访问级别, 扩展添加的成员的默认访问级别, 跟直接在类型中定义的成员一样
 
 可以单独给扩展添加的成员设置访问级别
 
 不能给用于遵守协议的扩展显式扩展的访问级别
 
 在同一个文件中的扩展, 可以写成类似多个部分的类型声明
 在原本的声明中声明一个私有成员, 可以在同一文件的扩展中访问它
 在扩展中声明一个私有成员, 可以在同一文件的其他扩展中, 原本声明中访问它
 */

public class Person10 {
    private func run0() {}
    private func eat0() {
        run1()
    }
}

extension Person10 {
    private func run1() {}
    private func eat1() {
        run0()
    }
}

extension Person10 {
    private func eat2() {
        run1()
    }
}
