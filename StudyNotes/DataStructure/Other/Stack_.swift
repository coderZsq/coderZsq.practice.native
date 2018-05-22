//
//  Stack.swift
//  DataStructure
//
//  Created by 朱双泉 on 05/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Stack_<Element> {
    
    private var capacity: Int
    private lazy var peek: Int = 0
    private lazy var buffer: [Element] = [Element]()

    init(_ stackCapacity: Int = 16) {
        capacity = stackCapacity
    }
    
    func isEmpty() -> Bool {
        return peek == 0 ? true : false
    }
    
    func isFull() -> Bool {
        return peek == capacity ? true : false
    }
    
    func clear() {
        peek = 0
    }
    
    func size() -> Int {
        return peek
    }
    
    @discardableResult func push(_ element: Element) -> Bool {
        guard !isFull() else { return false }
        buffer.append(element)
        buffer[peek] = element
        peek += 1
        return true
    }
    
    @discardableResult func pop() -> Element? {
        guard !isEmpty() else { return nil }
        peek -= 1
        return buffer[peek]
    }
    
    func traverse(reversed: Bool = false) {
        print("︵")
        if reversed {
            for i in (0..<peek).reversed() {
                print(buffer[i])
            }
        } else {
            for i in 0..<peek {
                print(buffer[i])
            }
        }
        print("︶")
    }
}
