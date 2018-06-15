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
        
        let isEven = {$0 % 2 == 0}
        print((0..<5).contains(where: isEven))
        print([1, 3, 99].contains(where: isEven))
        
        print([[1, 2]].isSubset(of: [[1, 2] as [Int], [3, 4]]) {$0 == $1})
        
        let ints = [1, 2]
        let strings = ["1", "2", "3"]
        print(ints.isSubset(of: strings) {String($0) == $1})
        
        let a = ["a", "b", "c", "d", "e", "f", "g"]
        let r = a.reversed()
        print(r.binarySearch(for: "g", areInIncreasingOrder: >) == r.startIndex)
        
        let s = a[2..<5]
        print(s.startIndex)
        print(s.binarySearch(for: "d"))
        
        var numbers = Array(1...10)
        numbers.shuffle()
        print(numbers)
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

//extension Sequence {
//    func contains(where predicate: (Element) throws -> Bool) rethrows -> Bool
//}

extension Sequence {
    func isSubset<S: Sequence>(of other: S, by areEquivalent:(Element, S.Element) -> Bool) -> Bool {
        for element in self {
            guard other.contains(where: {areEquivalent(element, $0)}) else {
                return false
            }
        }
        return true
    }
}

extension Array {
    func binarySearch(for value: Element, areInIncreasingOrder: (Element, Element) -> Bool) -> Int? {
        var left = 0
        var right = count - 1
        while left <= right {
            let mid = (left + right) / 2
            let candidate = self[mid]
            if areInIncreasingOrder(candidate, value) {
                left = mid + 1
            } else if areInIncreasingOrder(value, candidate) {
                right = mid - 1
            } else {
                return mid
            }
        }
        return nil
    }
}

extension Array where Element: Comparable {
    func binarySearch(for value: Element) -> Int? {
        return self.binarySearch(for: value, areInIncreasingOrder: <)
    }
}

extension RandomAccessCollection {
    public func binarySearch(for value: Element, areInIncreasingOrder: (Element, Element) -> Bool) -> Index? {
        guard !isEmpty else {return nil}
        var left = startIndex
        var right = index(before: endIndex)
        while left <= right {
            let dist = distance(from: left, to: right)
            let mid = index(left, offsetBy: dist / 2)
            let candidate = self[mid]
            if areInIncreasingOrder(candidate, value) {
                left = index(after: mid)
            } else if areInIncreasingOrder(value, candidate) {
                right = index(before: mid)
            } else {
                return mid
            }
        }
        return nil
    }
}

extension RandomAccessCollection where Element: Comparable {
    func binarySearch(for value: Element) -> Index? {
        return binarySearch(for: value, areInIncreasingOrder: <)
    }
}

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            self.swapAt(i, j)
        }
    }
    
    func shuffled() -> [Element] {
        var clone = self
        clone.shuffle()
        return clone
    }
}

extension BinaryInteger {
    static func arc4random_uniform(_ upper_bound: Self) -> Self {
        precondition(upper_bound > 0 && UInt32(upper_bound) < UInt32.max, "arc4random_uniform only callable up to \(UInt32(upper_bound))")
        return Self(Darwin.arc4random_uniform(UInt32(upper_bound)))
    }
}

extension MutableCollection where Self: RandomAccessCollection {
    mutating func shuffle() {
        var i = startIndex
        let beforeEndIndex = index(before: endIndex)
        while i < beforeEndIndex {
            let dist = distance(from: i, to: endIndex)
            let randomDistance = IndexDistance.arc4random_uniform(dist)
            let j = index(i, offsetBy: randomDistance)
            self.swapAt(i, j)
            formIndex(after: &i)
        }
    }
}

extension Sequence {
    func shuffled() -> [Element] {
        var clone = Array(self)
        clone.shuffle()
        return clone
    }
}

extension MutableCollection where Self: RandomAccessCollection, Self: RangeReplaceableCollection {
    func shuffled() -> Self {
        var clone = Self()
        clone.append(contentsOf: self)
        clone.shuffle()
        return clone
    }
}

func min<T: Comparable>(_ x: T, _ y: T) -> T {
    return y < x ? y : x
}


