//
//  NSOrderedSet.swift
//  OptimizingCollections
//
//  Created by 朱双泉 on 2018/7/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

struct NSOrderedSet {
    
    static func run() {
        var set = OrderedSet<Int>()
        for i in (1...20).shuffled() {
            set.insert(i)
        }
        print(set)
        print(set.contains(7))
        print(set.contains(42))
        print(set.reduce(0, +))
        let copy = set
        set.insert(42)
        print(copy)
        print(set)
        
        let value = Value(42)
        let a = value as AnyObject
        let b = value as AnyObject
        print(a.isEqual(b))
        print(a.hash)
        print(b.hash)
        
        var values = OrderedSet<Value>()
        (1...20).shuffled().map(Value.init).forEach{values.insert($0)}
        print(values.contains(Value(7)))
        print(values.contains(Value(42)))
    }
}

private class Canary {}

public struct OrderedSet<Element: Comparable>: SortedSet {
    fileprivate var storage = NSMutableOrderedSet()
    fileprivate var canary = Canary()
    public init() {}
}

extension OrderedSet {
    public func forEach(_ body: (Element) -> Void) {
        storage.forEach {body($0 as! Element)}
    }
}

//extension OrderedSet {
//    public func contains(_ element: Element) -> Bool {
//        return storage.contains(element) //BUG!
//    }
//}

extension OrderedSet {
    fileprivate static func compare(_ a: Any, _ b: Any) -> ComparisonResult {
        let a = a as! Element, b = b as! Element
        if a < b {
            return .orderedAscending
        }
        if a > b {
            return .orderedDescending
        }
        return .orderedSame
    }
}

extension OrderedSet {
    public func index(of element: Element) -> Int? {
        let index = storage.index(
            of: element,
            inSortedRange: NSRange(0..<storage.count),
            usingComparator: OrderedSet.compare
        )
        return index == NSNotFound ? nil : index
    }
}

extension OrderedSet {
    public func contains(_ element: Element) -> Bool {
        return index(of: element) != nil
    }
}

extension OrderedSet {
    public func contains2(_ element: Element) -> Bool {
        return storage.contains(element) || index(of: element) != nil
    }
}

extension OrderedSet: RandomAccessCollection {
    public typealias Index = Int
    public typealias Indices = CountableRange<Int>
    public var startIndex: Int {return 0}
    public var endIndex: Int {return storage.count}
    public subscript(i: Int) -> Element {return storage[i] as! Element}
}

extension OrderedSet {
    fileprivate mutating func makeUnique() {
        if !isKnownUniquelyReferenced(&canary) {
            storage = storage.mutableCopy() as! NSMutableOrderedSet
            canary = Canary()
        }
    }
}

extension OrderedSet {
    fileprivate func index(for value: Element) -> Int {
        return storage.index(
            of: value,
            inSortedRange: NSRange(0..<storage.count),
            options: .insertionIndex,
            usingComparator: OrderedSet.compare
        )
    }
}

extension OrderedSet {
    @discardableResult public mutating func insert(_ newElement: Element) -> (inserted: Bool, memberAfterInsert: Element) {
        let index = self.index(for: newElement)
        if index < storage.count, storage[index] as! Element == newElement {
            return (false, storage[index] as! Element)
        }
        makeUnique()
        storage.insert(newElement, at: index)
        return (true, newElement)
    }
}

struct Value: Comparable {
    let value: Int
    init(_ value: Int) {
        self.value = value
    }
    static func == (left: Value, right: Value) -> Bool {
        return left.value == right.value
    }
    static func < (left: Value, right: Value) -> Bool {
        return left.value < right.value
    }
}
