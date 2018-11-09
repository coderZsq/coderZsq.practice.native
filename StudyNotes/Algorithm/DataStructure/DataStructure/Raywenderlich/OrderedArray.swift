//
//  OrderedArray.swift
//  DataStructure
//
//  Created by 朱双泉 on 2018/5/28.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

public struct OrderedArray<T: Comparable> {
    fileprivate var array = [T]()
    
    public init(array: [T]) {
        self.array = array.sorted()
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public subscript(index: Int) -> T {
        return array[index]
    }
    
    public mutating func removeIndex(index: Int) -> T {
        return array.remove(at: index)
    }
    
    public mutating func removeAll() {
        array.removeAll()
    }
    
    public mutating func insert(newElement: T) -> Int {
        let i = findInsertionPoint(newElement: newElement)
        array.insert(newElement, at: i)
        return i
    }
    
    public func findInsertionPoint(newElement: T) -> Int {
        var startIndex = 0
        var endIndex = array.count
        
        while startIndex < endIndex {
            let midIndex = startIndex + (endIndex - startIndex) / 2
            if array[midIndex] == newElement {
                return midIndex
            } else if array[midIndex] < newElement {
                startIndex = midIndex + 1
            } else {
                endIndex = midIndex
            }
        }
        return startIndex
    }
}

extension OrderedArray: CustomStringConvertible {
    public var description: String {
        return array.description
    }
}


