//
//  Built-inCollectionType.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/5/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

extension Sequence {
    
    func last(where predicate: (Element) -> Bool) -> Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
    
    public func all(matching predicate: (Element) -> Bool) -> Bool {
        return !contains {!predicate($0)}
    }
}

extension Array where Element: Equatable {
    
    func index(of element: Element) -> Int? {
        for idx in self.indices where self[idx] == element {
            return idx
        }
        return nil
    }
    //wrong code
    func index_foreach(of element: Element) -> Int? {
        self.indices.filter {idx in
            self[idx] == element
            }.forEach {idx in
                return idx
        }
        return nil
    }
}

extension Array {

    func map<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        result.reserveCapacity(count)
        for x in self {
            result.append(transform(x))
        }
        return result
    }
    
    func accumulate<Result>(_ initialResult: Result, _ nextPartialResult:(Result, Element) -> Result) -> [Result] {
        var running = initialResult
        return map {next in
            running = nextPartialResult(running, next)
            return running
        }
    }
    
    func filter(_ isIncluded: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where isIncluded(x) {
            result.append(x)
        }
        return result
    }
    
    func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) -> Result) -> Result {
        var result = initialResult
        for x in self {
            result = nextPartialResult(result, x)
        }
        return result
    }
    
    func map2<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([]) {
            $0 + [transform($1)]
        }
    }
    
    func filter2(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce([]) {
            isIncluded($1) ? $0 + [$1] : $0
        }
    }
    
    func filter3(_ isIncluded: (Element) -> Bool) -> [Element] {
        return reduce(into: []) { result, element in
            if isIncluded(element) {
                result.append(element)
            }
        }
    }
    
    func flatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var result: [T] = []
        for x in self {
            result.append(contentsOf: transform(x))
        }
        return result
    }
    
    func run() {
        let fibs = [0, 1, 1, 2, 3, 5]
//        fib.append(1) Cannot use mutating member on immutable value: 'fib' is a 'let' constant
        
        var mutableFibs = [0, 1, 2, 3, 5]
        mutableFibs.append(8)
        mutableFibs.append(contentsOf: [13, 21])
        print(mutableFibs)
        
        var x = [1, 2, 3]
        var y = x
        y.append(4)
        print(y)
        print(x)
        
        let a = NSMutableArray(array: [1, 2, 3])
        let b: NSArray = a
        a.insert(4, at: 3)
        print(b)
        
        let c = NSMutableArray(array: [1, 2, 3])
        let d = c.copy() as! NSArray
        c.insert(4, at: 3)
        print(d)
        
        var squared: [Int] = []
        for fib in fibs {
            squared.append(fib * fib)
        }
        print(squared)
        
        let squares = fibs.map {fib in fib * fib}
        print(squares)
        
        let names = ["Paula", "Elena", "Zoe"]
        
        var lastNameEndingInA: String?
        for name in names.reversed() where name.hasSuffix("a") {
            lastNameEndingInA = name
            break
        }
        print(lastNameEndingInA)
        
//        let match = names.last { $0.hasSuffix("a") }
        guard let match = names.last(where: {$0.hasSuffix("a")}) else {return}
        print(match)
        
        print([1, 2, 3, 4].accumulate(0, +))
        
        let nums = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        print(nums.filter {num in num % 2 == 0})
        print(nums.filter {$0 % 2 == 0})
        
        print((1..<10).map {$0 * $0}.filter {$0 % 2 == 0})
        
        let evenNams = nums.filter {$0 % 2 == 0}
        print(evenNams.all {$0 % 2 == 0})
        
        var total = 0
        for num in fibs {
            total = total + num
        }
        print(total)
        
        let sum = fibs.reduce(0) {total, num in total + num}
        print(sum)
        print(fibs.reduce(0, +))
        
        print(fibs.reduce("") {str, num in str + "\(num), "})
        
        let suits = ["♠", "♥", "♣", "♦"]
        let ranks = ["J", "Q", "K", "A"]
        let result = suits.flatMap {suit in
            ranks.map {rank in
                (suit, rank)
            }
        }
        print(result)
        
        for element in [1, 2, 3] {
            print(element)
        }
        
        [1, 2, 3].forEach {element in
            print(element)
        }
        
        (1..<10).forEach {number in
            print(number)
            if number > 2 {return}
        }
        
        let slice = fibs[1...]
        print(slice)
        print(type(of: slice))
        let newArray = Array<Int>(slice)
        print(type(of: newArray))
    }
}
