//
//  IteratorsAndSequences.swift
//  Functional
//
//  Created by 朱双泉 on 2018/5/21.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

struct ReversedIndexIterator: IteratorProtocol {
    var index: Int
    
    init<T>(array: [T]) {
        index = array.endIndex - 1
    }
    
    mutating func next() -> Int? {
        guard index >= 0 else { return nil }
        defer { index -= 1 }
        return index
    }
}

class _Iterator {
    static func run() {
        let letters = ["A", "B", "C"]
        var iterator = ReversedIndexIterator(array: letters)
        while let i = iterator.next() {
            print("Element\(i) of the array is \(letters[i])")
        }
    }
}

struct PowerIterator: IteratorProtocol {
    var power: NSDecimalNumber = 1
    
    mutating func next() -> NSDecimalNumber? {
        power = power.multiplying(by: 2)
        return power
    }
}

extension PowerIterator {
    mutating func find(where predicate: (NSDecimalNumber) -> Bool) -> NSDecimalNumber? {
        while let x = next() {
            if predicate(x) {
                return x
            }
        }
        return nil
    }
}

extension _Iterator {
    static func run2() {
        var powerIterator = PowerIterator()
        print(powerIterator.find { $0.intValue > 1000 } ?? "")
    }
}

struct FileLinesIterator: IteratorProtocol {
    let lines: [String]
    var currentLine: Int = 0
    
    init(filename: String) throws {
        let contents: String = try String(contentsOfFile: filename)
        lines = contents.components(separatedBy: .newlines)
    }
    
    mutating func next() -> String? {
        guard currentLine < lines.endIndex else { return nil }
        defer { currentLine += 1 }
        return lines[currentLine]
    }
}

extension IteratorProtocol {
    mutating func find(predicate: (Element) -> Bool) -> Element? {
        while let x = next() {
            return x
        }
        return nil
    }
}

struct LimmitIterator<I: IteratorProtocol>: IteratorProtocol {
    var limit = 0
    var iterator: I
    
    init(limit: Int, iterator: I) {
        self.limit = limit
        self.iterator = iterator
    }
    
    mutating func next() -> I.Element? {
        guard limit > 0 else { return nil }
        limit -= 1
        return iterator.next()
    }
}

extension Int {
    func countDown() -> AnyIterator<Int> {
        var i = self - 1
        return AnyIterator {
            guard i >= 0 else { return nil }
            defer { i -= 1 }
            return i
        }
    }
}
#if false
func +<I: IteratorProtocol, J: IteratorProtocol>(first: I, second: J) -> AnyIterator<I.Element> where I.Element == J.Element {
    var i = first
    var j = second
    return AnyIterator { i.next() ?? j.next() }
}
#endif

func +<I: IteratorProtocol, J: IteratorProtocol>(first: I, second: @escaping @autoclosure () -> J) -> AnyIterator<I.Element> where I.Element == J.Element {
    var one = first
    var other: J? = nil
    return AnyIterator {
        if other != nil {
            return other!.next()
        } else if let result = one.next() {
            return result
        } else {
            other = second()
            return other!.next()
        }
    }
}

struct ReverseArrayIndices<T>: Sequence {
    let array: [T]
    
    init(array: [T]) {
        self.array = array
    }
    
    func makeIterator() -> ReversedIndexIterator {
        return ReversedIndexIterator(array: array)
    }
}

class _Sequence {
    static func run() {
        var array = ["one", "two", "three"]
        let reverseSequence = ReverseArrayIndices(array: array)
        var reverseIterator = reverseSequence.makeIterator()
        while let i = reverseIterator.next() {
            print("index\(i) is \(array[i])")
        }
    }
    
    static func run2() {
        var array = ["one", "two", "three"]
        let reverseElements = ReverseArrayIndices(array: array).map { array[$0] }
        for x in reverseElements {
            print("Element is \(x)")
        }
    }
    
    static func run3() {
        print((1...10).filter {$0 % 3 == 0}.map {$0 * $0})
    }
    
    static func run4() {
        var result: [Int] = []
        for element in 1...10 {
            if element % 3 == 0 {
                result.append(element * element)
            }
        }
        print(result)
    }
    
    static func run5() {
        let lazyResult = (1...10).lazy.filter { $0 % 3 == 0 }.map { $0 * $0 }
        print(Array(lazyResult))
    }
}


