//
//  QuickCheck.swift
//  Functional
//
//  Created by 朱双泉 on 2018/5/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation
import CoreGraphics

func plusIsCommutative(x: Int, y: Int) -> Bool {
    return x + y == y + x
}

func minusIsCommutative(x: Int, y: Int) -> Bool {
    return x - y == y - x
}
#if false
    protocol Arbitrary {
        static func arbitrary() -> Self
    }
#endif
extension Int: Arbitrary {
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
}

//Int.arbitrary()

extension Int {
    static func arbitrary(in range: CountableRange<Int>) -> Int {
        let diff = range.upperBound - range.lowerBound
        return range.lowerBound + (Int.arbitrary() % diff)
    }
}
#if false
    extension UnicodeScalar: Arbitrary {
        static func arbitrary() -> UnicodeScalar {
            return UnicodeScalar(Int.arbitrary(in: 65..<90))!
        }
    }
    
    extension String: Arbitrary {
        static func arbitrary() -> String {
            let randomLength = Int.arbitrary(in: 0..<40)
            let randomScalars = (0..<randomLength).map { _ in
                UnicodeScalar.arbitrary()
            }
            return String(UnicodeScalarView(randomScalars))
        }
    }
#endif
//String.arbitrary()

let numberOfIterations = 10000

func check1<A: Arbitrary>(_ message: String, _ property: (A) -> Bool) -> () {
    for _ in 0..<numberOfIterations {
        let value = A.arbitrary()
        guard property(value) else {
            print("\"\(message)\" doesn't hold: \(value)")
            return
        }
    }
    print("\"\(message)\" passed \(numberOfIterations) tests.")
}

extension CGSize {
    var area: CGFloat {
        return width * height
    }
}
#if false
    extension CGSize: Arbitrary {
        static func arbitrary() -> CGSize {
            return CGSize(width: .arbitrary(), height: .arbitrary())
        }
    }
#endif
protocol Smaller {
    func smaller() -> Self?
}

extension Int: Smaller {
    func smaller() -> Int? {
        return self == 0 ? nil : self / 2
    }
}

//100.smaller()

extension String: Smaller {
    func smaller() -> String? {
        return isEmpty ? nil : String(characters.dropFirst())
    }
}

protocol Arbitrary: Smaller {
    static func arbitrary() -> Self
}

func iterate<A>(while condition: (A) -> Bool, initial: A, next: (A) -> A?) -> A {
    guard let x = next(initial), condition(x) else {
        return initial }
    return iterate(while: condition, initial: x, next: next)
}

func check2<A: Arbitrary>(_ message: String, _ property: (A) -> Bool) -> () {
    
    for _ in 0..<numberOfIterations {
        let value = A.arbitrary()
        guard property(value) else {
            let smallerValue = iterate(while: {!property($0)}, initial: value) {
                $0.smaller()
            }
            print("\"\(message)\" doesn't hold: \(smallerValue)")
            return
        }
    }
    print("\"\(message)\" passed \(numberOfIterations) tests.")
}

func qsort(_ input: [Int]) -> [Int] {
    var array = input
    if array.isEmpty { return [] }
    let pivot = array.removeFirst()
    let lesser = array.filter { $0 < pivot }
    let greater = array.filter { $0 >= pivot }
    let intermediate = qsort(lesser) + [pivot]
    return intermediate + qsort(greater)
}

extension Array: Smaller {
    func smaller() -> [Element]? {
        guard !isEmpty else {return nil}
        return Array(dropLast())
    }
}

extension Array where Element: Arbitrary {
    static func arbitrary() -> [Element] {
        let randomLength = Int.arbitrary(in: 0..<50)
        return (0..<randomLength).map { _ in .arbitrary() }
    }
}

struct ArbitraryInstance<T> {
    let arbitray: () -> T
    let smaller: (T) -> T?
}

func checkHelper<A>(_ arbitraryInstance: ArbitraryInstance<A>, _ property: (A) -> Bool, _ message: String) -> () {
    for _ in 0..<numberOfIterations {
        let value = arbitraryInstance.arbitray()
        guard property(value) else {
            let smallerValue = iterate(while: {!property($0)}, initial: value, next: arbitraryInstance.smaller)
            print("\"\(message)\" doesn't hold: \(smallerValue)")
            return
        }
    }
    print("\"\(message)\" passed \(numberOfIterations) tests.")
}

func check<X: Arbitrary>(_ message: String, _ property: ([X]) -> Bool) -> () {
    let instance = ArbitraryInstance(arbitray: Array.arbitrary, smaller: {(x: [X]) in x.smaller()})
    checkHelper(instance, property, message)
}
#if false
protocol Smaller {
    func smaller() -> AnyIterator<Self>
}

extension Array {
    func smaller() -> AnyIterator<[Element]> {
        var i = 0
        return AnyIterator {
            guard i < self.endIndex else { return nil }
            var result = self
            result.remove(at: i)
            i += 1
            return result
        }
    }
}
#endif
//Array([1, 2, 3].smaller())
