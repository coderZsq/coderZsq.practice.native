//
//  Generic.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/6/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation
import UIKit

struct Generic {
    
    static func run() {
        let double = raise(2.0, to: 3.0)
        print(double)
        print(type(of: double))
        let float: Float = raise(2.0, to: 3.0)
        print(float)
        print(type(of: float))
        
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 32))
        label.text = "Password"
        log(label)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        log(button)
        
        let views = [label, button]
        for view in views {
            log(view)
        }
        
        print(2.0 ** 3.0)
        
        let intResult: Int = 2 ** 3
        print(intResult)
        
        let oneToThree = [1, 2, 3]
        let fiveToOne = [5, 4, 3, 2, 1]
        print(oneToThree.isSubset(of: fiveToOne))
        
        print([5, 4, 3].isSubset(of: 1...10))
    }
}

func raise(_ base: Double, to exponent: Double) -> Double {
    return pow(base, exponent)
}

func raise(_ base: Float, to exponent: Float) -> Float {
    return powf(base, exponent)
}

func log<View: UIView>(_ view: View) {
    print("It's a \(type(of: view)), frame: \(view.frame)")
}

func log(_ view: UILabel) {
    let text = view.text ?? "(empty)"
    print("It's a label, text: \(text)")
}

precedencegroup ExponentiationPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator **: ExponentiationPrecedence

func **(lhs: Double, rhs: Double) -> Double {
    return pow(lhs, rhs)
}

func **(lhs: Float, rhs: Float) -> Float {
    return powf(lhs, rhs)
}

func **<I: BinaryInteger>(lhs: I, rhs: I) -> I {
    let result = Double(Int64(lhs)) ** Double(Int64(rhs))
    return I(result)
}

extension Sequence where Element: Equatable {
    func isSubset(of other: [Element]) -> Bool {
        for element in self {
            guard other.contains(element) else {
                return false
            }
        }
        return true
    }
}

extension Sequence where Element: Hashable {
    func isSubset(of other: [Element]) -> Bool {
        let otherSet = Set(other)
        for element in self {
            guard otherSet.contains(element) else {
                return false
            }
        }
        return true
    }
}

extension Sequence where Element: Hashable {
    func isSubset<S: Sequence>(of other: S) -> Bool where S.Element == Element {
        let otherSet = Set(other)
        for element in self {
            guard otherSet.contains(element) else {
                return false
            }
        }
        return true
    }
}
