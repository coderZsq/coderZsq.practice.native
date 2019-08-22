//
//  ViewController.swift
//  26-面向协议编程
//
//  Created by 朱双泉 on 2019/8/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

import UIKit

protocol Runnable {
    func run()
}

extension Runnable {
    func run() {
        print("run")
    }
}

struct SQ<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

protocol SQCompatible {}
extension SQCompatible {
    static var sq: SQ<Self>.Type {
        get { SQ<Self>.self }
        set {}
    }
    var sq: SQ<Self> {
        get { SQ(self) }
        set {}
    }
}

extension String: SQCompatible {}
extension SQ where Base == String {
    func numberCount() -> Int {
        var count = 0
        for c in base where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
}

class Person {}
class Student: Person {}

extension Person: SQCompatible {}
extension SQ where Base: Person {
    func run() {}
    static func test() {}
}

extension NSString: SQCompatible {}
extension SQ where Base: ExpressibleByStringLiteral {
    func numberCount() -> Int {
        let string = base as! String
        var count = 0
        for c in string where ("0"..."9").contains(c) {
            count += 1
        }
        return count
    }
}

protocol ArrayType {}
extension Array: ArrayType {}
extension NSArray: ArrayType {}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // MARK: - OOP的不足
        
        do {
            class BVC: UIViewController {
                func run() {
                    print("run")
                }
            }
            
            class DVC: UITableViewController {
                func run() {
                    print("run")
                }
            }
        }
        
        // MARK: - POP的解决方案
        
        do {
            class BVC: UIViewController, Runnable {}
            class DVC: UITableViewController, Runnable {}
        }
        
        // MARK: - 利用协议实现前缀效果
        
        do {
            var string = "123fds434"
            print(string.sq.numberCount())
        }

        // MARK: - Base: 类
        
        do {
            Person.sq.test()
            Student.sq.test()
            
            let p = Person()
            p.sq.run()
            
            let s = Student()
            s.sq.run()
        }
        
        // MARK: - Base: 协议
        
        do {
            var s1: String = "123fds434"
            var s2: NSString = "123fds434"
            var s3: NSMutableString = "123fds434"
            print(s1.sq.numberCount())
            print(s2.sq.numberCount())
            print(s3.sq.numberCount())
        }
        
        // MARK: - 利用协议实现类型判断
        
        do {
            func isArray(_ value: Any) -> Bool { value is [Any] }
            print(isArray([1, 2]))
            print(isArray(["1", 2]))
            print(isArray(NSArray()))
            print(isArray(NSMutableArray()))
        }
        
        do {
            func isArrayType(_ type: Any.Type) -> Bool { type is ArrayType.Type }
            print(isArrayType([Int].self))
            print(isArrayType([Any].self))
            print(isArrayType(NSArray.self))
            print(isArrayType(NSMutableArray.self))
        }
    }
}

