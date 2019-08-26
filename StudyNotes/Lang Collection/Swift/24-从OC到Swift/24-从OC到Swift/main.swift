//
//  main.swift
//  24-从OC到Swift
//
//  Created by 朱双泉 on 2019/8/19.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - MARK, TODO, FIXME

do {
    func test() {
        // TODO: 未完成
        #warning("undo")
    }
    
    func test2() {
        var age = 10
        // FIXME: 有待修复
        age += 20
    }
    
    class Person {
        // MARK: - 属性
        var age = 0
        var weight = 0
        var height = 0
        
        // MARK: - 私有方法
        // MARK: 跑步
        private func run1() {}
        private func run2() {}
        // MARK: 走路
        private func walk1() {}
        private func walk2() {}
        
        // MARK: - 公共方法
        public func eat1() {}
        public func eat2() {}
    }
}

// MARK: - 条件编译

// 操作系统: macOS\iOS\tvOS\watchOS\Linux\Android\Windows\FreeBSD
#if os(macOS) || os(iOS)
// CPU架构: i386\x86_64\arm\arm64
#elseif arch(x86_64) || arch(arm64)
// swift版本
#elseif swift(<5) && swift(>=3)
// 模拟器
#elseif targetEnvironment(simulator)
// 可以导入某模块
#elseif canImport(Foundation)
#else
#endif

// debug模式
#if DEBUG
// release模式
#else
#endif

#if TEST
print("test")
#endif

#if OTHER
print("other")
#endif

// MARK: - 打印

import Foundation

do {
    func log<T>(_ msg: T,
                file: NSString = #file,
                line: Int = #line,
                fn: String = #function) {
        #if DEBUG
        let prefix = "\(file.lastPathComponent)_\(line)_\(fn):"
        print(prefix, msg)
        #endif
    }
}

// MARK: - 系统版本检测

do {
    if #available(iOS 10, macOS 10.12, *) {
        // 对于iOS平台, 只在iOS10及以上版本执行
        // 对于maxOS平台, 只在macOS 10.12及以上版本执行
        // 最后的*表示在其他所有平台都执行
    }
}

// MARK: - API可用性说明

do {
    @available(iOS 10, macOS 10.15, *)
    class Person {}
    
    struct Student {
        @available(*, unavailable, renamed: "study")
        func study_() {}
        func study() {}
        
        @available(iOS, deprecated: 11)
        @available(macOS, deprecated: 10.12)
        func run() {}
    }
}

// MARK: - iOS程序的入口
/*
 在AppDelegate上面默认有个@UIApplicationMain标记, 这表示
 编译器自动生成入口代码(mian函数代码), 自动设置AppDelegate为APP的代理
 也可以删掉@UIApplicationMain, 自定义入口代码: 新建一个main.swift文件
 */

import UIKit

do {
    class SQApplication: UIApplication {}

    UIApplicationMain(CommandLine.argc,
                      CommandLine.unsafeArgv,
                      NSStringFromClass(SQApplication.self),
                      NSStringFromClass(AppDelegate.self))
}

// MARK: -  Swift调用OC
/*
 如果C语言暴露给Swift的函数名跟Swift中的其他函数名冲突了
 可以在Swift中使用@_silgen_name修改C函数名
 */

do {
    var p = SQPerson(age: 10, name: "Jack")
    p.age = 18
    p.name = "Rose"
    p.run()
    p.eat("Apple", other: "Water")
    
    SQPerson.run()
    SQPerson.eat("Pizza", other: "Banana")
    
    print(sum(10, 20))
}

func sum(_ v1: Int, _ v2: Int) -> Int { v1 - v2 }
@_silgen_name("sum") func swift_sum(_ v1: Int32, _ v2:Int32) -> Int32

do {
    print(swift_sum(10, 20))
    print(sum(10, 20))
}

// MARK: - 选择器 (Selector)
/*
 Swift中依然可以使用选择器, 使用#selector(name)定义一个选择器
 必须是被@objcMember或@objc修饰的方法才可以定义选择器
 */

do {
    @objcMembers class Person: NSObject {
        func test1(v1: Int) { print("test1") }
        func test2(v1: Int, v2: Int) { print("test2(v1:v2:)") }
        func test2(_ v1: Double, _ v2: Double) { print("test2(_:_:)") }
        func run() {
            perform(#selector(test1))
            perform(#selector(test1(v1:)))
            perform(#selector(test2(v1:v2:)))
            perform(#selector(test2(_:_:)))
            perform(#selector(test2 as (Double, Double) -> Void))
        }
    }
}

// MARK: - String

do {
    var emptyStr1 = ""
    var emptyStr2 = String()
}

do {
    var str: String = "1"
    str.append("_2")
    str = str + "_3"
    str += "_4"
    str = "\(str)_5"
    print(str.count)
}

do {
    var str = "123456"
    print(str.hasPrefix("123"))
    print(str.hasSuffix("456"))
}

// MARK: - String的插入和删除

do {
    var str = "1_2"
    str.insert("_", at: str.endIndex)
    str.insert(contentsOf: "3_4", at: str.endIndex)
    str.insert(contentsOf: "666", at: str.index(after: str.startIndex))
    str.insert(contentsOf: "888", at: str.index(before: str.endIndex))
    str.insert(contentsOf: "hello", at: str.index(str.startIndex, offsetBy: 4))
    
    str.remove(at: str.firstIndex(of: "1")!)
    str.removeAll { $0 == "6" }
    var range = str.index(str.endIndex, offsetBy: -4)..<str.index(before: str.endIndex)
    str.removeSubrange(range)
}

// MARK: - Substring
/*
 String可以通过下标, prefix, suffix等截取子串, 子串类型不是String, 而是Substring
 Substring和它的base, 共享字符串数据
 Substring发生修改 或者 转为String时, 会分配新的内存存储字符串数据
 */

do {
    var str = "1_2_3_4_5"
    var substr1 = str.prefix(3)
    var substr2 = str.suffix(3)
    var range = str.startIndex..<str.index(str.startIndex, offsetBy: 3)
    var substr3 = str[range]
    // 最初的String
    print(substr3.base)
    // Substring -> String
    var str2 = String(substr3)
}

// MARK: - String与Character

do {
    for c in "jack" {
        print(c)
    }
    var str = "jack"
    var c = str[str.startIndex]
}

// MARK: - 多行String

do {
    let str = """
    1
        "2"
    3
        '4'
    """
}

do {
    let str1 = "These are the same."
    let str2 = """
    These are the same.
    """
}

do {
    let str = """
    Escaping the first quoto \"""
    Escaping two quotes \"\""
    Excaping all three quotos \"\"\"
    """
}

// 缩进以结尾的3引号为对齐线
do {
    let str = """
        1
            2
    3
        4
    """
}

// MARK: - String与NSString

do {
    var str1: String = "jack"
    var str2: NSString = "rose"
    
    /*
    0x10298d5f5 <+8869>:  callq  0x102995098               ; symbol stub for: (extension in Foundation):Swift.String._bridgeToObjectiveC() -> __C.NSString
     */
    var str3 = str1 as NSString
    var str4 = str2 as String
    
    var str5 = str3.substring(with: NSRange(location: 0, length: 2))
    print(str5)
}

// MARK: - 只能被class继承的协议

protocol Runnable: AnyObject {}
protocol Runnable2: class {}
@objc protocol Runnable3 {}

// MARK: - 可选协议
// 可以通过@objc定义可选协议, 这种协议只能被class遵守

@objc protocol Runnable4 {
    func run1()
    @objc optional func run2()
    func run3()
}

do {
    class Dog: Runnable4 {
        func run3() { print("Dog run3") }
        func run1() { print("Dog run1") }
    }
    var d = Dog()
    d.run1()
    d.run3()
}

// MARK: - dynamic
// 被@objc dynamic修饰的内容会具有动态性, 比如调用方法会走runtime那一套流程

do {
    class Dog: NSObject {
        @objc dynamic func test1() {}
        func test2() {}
    }
    var d = Dog()
    /*
     0x10cb9b160 <+800>:  movq   0xb499(%rip), %rsi        ; "test1"
     0x10cb9b167 <+807>:  movq   -0x328(%rbp), %rdx
     0x10cb9b16e <+814>:  movq   %rdx, %rdi
     0x10cb9b171 <+817>:  movq   %rax, -0x330(%rbp)
     0x10cb9b178 <+824>:  callq  0x10cb9f846               ; symbol stub for: objc_msgSend
     */
    d.test1()
    /*
     0x103db1170 <+800>:  movq   -0x328(%rbp), %r13
     0x103db1177 <+807>:  movq   %rax, -0x330(%rbp)
     0x103db117e <+814>:  callq  0x103db3780               ; test2() -> () in Dog #1 in _4_从OC到Swift at main.swift:14
     */
    d.test2()
}

// MARK: - KVC/KVO
/*
 属性所在的类, 监听器最终继承自NSObject
 用@objc dyanmic修饰对应的属性
 */

do {
    class Observer: NSObject {
        override func observeValue(forKeyPath keyPath: String?,
                                         of object: Any?,
                                         change: [NSKeyValueChangeKey : Any]?,
                                         context: UnsafeMutableRawPointer?) {
            print("observeValue", change?[.newKey] as Any)
        }
    }
    class Person: NSObject {
        @objc dynamic var age: Int = 0
        var observer: Observer = Observer()
        override init() {
            super.init()
            self.addObserver(observer,
                             forKeyPath: "age",
                             options: .new,
                             context: nil)
        }
        deinit {
            self.removeObserver(observer,
                                forKeyPath: "age")
        }
    }
    var p = Person()
    p.age = 20
    p.setValue(25, forKey: "age")
}

// MARK: - block方式的KVO

do {
    class Observer: NSObject {
        override func observeValue(forKeyPath keyPath: String?,
                                         of object: Any?,
                                         change: [NSKeyValueChangeKey : Any]?,
                                         context: UnsafeMutableRawPointer?) {
            print("observeValue", change?[.newKey] as Any)
        }
    }
    class Person: NSObject {
        @objc dynamic var age: Int = 0
        var observation: NSKeyValueObservation?
        override init() {
            super.init()
            observation = observe(\Person.age, options: .new) {
                (person, change) in
                print(change.newValue as Any)
            }
        }
    }
    var p = Person()
    p.age = 20
    p.setValue(25, forKey: "age")
}



// MARK: - 关联对象 (Associated Object)
/*
 默认情况, extension不可以增加存储属性
 借助关联对象, 可以实现类似extension为class增加存储属性的效果
 */

class Person {}
extension Person {
    private static var AGE_KEY: Void?
    var age: Int {
        get {
            (objc_getAssociatedObject(self, &Self.AGE_KEY) as? Int) ?? 0
        }
        set {
            objc_setAssociatedObject(self,
                                     &Self.AGE_KEY,
                                     newValue,
                                     .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

do {
    var p = Person()
    print(p.age)
    p.age = 10
    print(p.age)
}

// MARK: - 多线程开发 - 异步

class Async {
    public typealias Task = () -> Void
    public static func async(_ task: @escaping Task) {
        _async(task)
    }
    public static func asynv(_ task: @escaping Task,
                      _ mainTask: @escaping Task) {
        _async(task, mainTask)
    }
    private static func _async(_ task: @escaping Task,
                               _ mainTask: Task? = nil) {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().async(execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
    }
}

// MARK: - 多线程开发 - 延迟

extension Async {
    @discardableResult
    public static func delay(_ seconds: Double,
                             _ block: @escaping Task) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: block)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds,
                                      execute: item)
        return item
    }
}

// MARK: - 多线程开发 - 异步延迟

extension Async {
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ task: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task)
    }
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ task: @escaping Task,
                                  _ mainTask: @escaping Task) -> DispatchWorkItem {
        return _asyncDelay(seconds, task, mainTask)
    }
    private static func _asyncDelay(_ seconds: Double,
                                    _ task: @escaping Task,
                                    _ mainTask: Task? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: task)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds,
                                          execute: item)
        if let main = mainTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
}

// MARK: - 多线程开发 - once
/*
 dispatch_once在Swift中已被废弃, 取而代之
 可以用类型属性或者全局变量\常量
 默认自带lazy + dispatch_once 效果
 */

fileprivate let initTask2: Void = {
   print("initTask2-----------")
}()

do {
    class ViewController2: UIViewController {
        static let initTask1: Void = {
            print("initTask1------------")
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let _ = Self.initTask1
            let _ = initTask2
        }
    }
}

// MARK: - 多线程开发 - 加锁

do {
    class Cache {
        private static var data = [String: Any]()
        private static var lock = DispatchSemaphore(value: 1)
        static func set(_ key: String, _ value: Any) {
            lock.wait()
            defer { lock.signal() }
            data[key] = value
        }
    }
}

do {
    class Cache {
        private static var lock = NSLock()
        static func set(_ key: String, _ value: Any) {
            lock.lock()
            defer { lock.unlock() }
        }
    }
}

do {
    class Cache {
        private static var lock = NSRecursiveLock()
        static func set(_ key: String, _ value: Any) {
            lock.lock()
            defer { lock.unlock() }
        }
    }
}
