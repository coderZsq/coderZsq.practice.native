//
//  SortedArrays.swift
//  OptimizingCollections
//
//  Created by 朱双泉 on 2018/7/2.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

struct SortedArrays {
    
    static func run() {
        var set = SortedArray<Int>()
        for i in (0..<22).shuffled() {
            set.insert(2 * i)
        }
        print(set)
        print(set.contains(42))
        print(set.contains(13))
        
        let copy = set
        set.insert(13)
        print(set.contains(13))
        print(copy.contains(13))
        
        for size in (0..<20).map({1 << $0}) {
            benchmark(count: size) {name, body in
                let start = Date()
                body()
                let end = Date()
                print("\(name), \(size), \(end.timeIntervalSince(start))")
            }
        }
    }
}

public protocol SortedSet: BidirectionalCollection, CustomStringConvertible where Element: Comparable {
    init()
    func contains(_ element: Element) -> Bool
    mutating func insert(_ newElement: Element) -> (inserted: Bool, memberAfterInsert: Element)
}

extension SortedSet {
    public var description: String {
        let contents = self.lazy.map {"\($0)"}.joined(separator: ", ")
        return "[\(contents)]"
    }
}

public struct SortedArray<Element: Comparable>: SortedSet {
    fileprivate var storage: [Element] = []
    public init() {}
}

extension SortedArray {
    func index(for element: Element) -> Int {
        var start = 0
        var end = storage.count
        while start < end {
            let middle = start + (end - start) / 2// + (end - start) >> 6
            if element > storage[middle] {
                start = middle + 1
            } else {
                end = middle
            }
        }
        return start
    }
}

extension SortedArray {
    public func index(of element: Element) -> Int? {
        let index = self.index(for: element)
        guard index < count, storage[index] == element else {
            return nil
        }
        return index
    }
}

extension SortedArray {
    public func contains(_ element: Element) -> Bool {
        let index = self.index(for: element)
        return index < count && storage[index] == element
    }
}

extension SortedArray {
    public func forEach(_ body: (Element) throws -> Void) rethrows {
        try storage.forEach(body)
    }
}

extension SortedArray {
    public func sorted() -> [Element] {
        return storage
    }
}

extension SortedArray {
    @discardableResult public mutating func insert(_ newElement: Element) -> (inserted: Bool, memberAfterInsert: Element) {
        let index = self.index(for: newElement)
        if index < count && storage[index] == newElement {
            return (false, storage[index])
        }
        storage.insert(newElement, at: index)
        return (true, newElement)
    }
}

extension SortedArray: RandomAccessCollection {
    public typealias Indices = CountableRange<Int>
    public var startIndex: Int {return storage.startIndex}
    public var endIndex: Int {return storage.endIndex}
    
    public subscript(index: Int) -> Element {return storage[index]}
}

func benchmark(count: Int, measure: (String, () -> Void) -> Void) {
    var set = SortedArray<Int>()
    let input = (0..<count).shuffled()
    measure("SortedArray.insert") {
        for value in input {
            set.insert(value)
        }
    }
    
    let lookups = (0..<count).shuffled()
    measure("SortArray.contains") {
        for element in lookups {
            guard set.contains(element) else {
                fatalError()
            }
        }
    }
    
    measure("SortedArray.forEach") {
        var i = 0
        set.forEach {element in
            guard element == i else {
                fatalError()
            }
            i += 1
        }
        guard i == input.count else {
            fatalError()
        }
    }
    
    measure("SortedArray.for-in") {
        var i = 0
        for element in set {
            guard element == i else {
                fatalError()
            }
            i += 1
        }
        guard i == input.count else {
            fatalError()
        }
    }
}
