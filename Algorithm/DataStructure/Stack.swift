//
//  Stack.swift
//  DataStructure
//
//  Created by 朱双泉 on 05/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Stack<Element> {
    
    private var capacity: Int
    private lazy var top: Int = 0
    private lazy var buffer: [Element] = [Element]()

    init(_ stackCapacity: Int = 16) {
        capacity = stackCapacity
    }
    
    func isEmpty() -> Bool {
        return top == 0 ? true : false
    }
    
    func isFull() -> Bool {
        return top == capacity ? true : false
    }
    
    func clear() {
        top = 0
    }
    
    func size() -> Int {
        return top
    }
    
    @discardableResult func push(_ element: Element) -> Bool {
        guard !isFull() else { return false }
        buffer.append(element)
        buffer[top] = element
        top += 1
        return true
    }
    
    @discardableResult func pop() -> Element? {
        guard !isEmpty() else { return nil }
        top -= 1
        return buffer[top]
    }
    
    func traverse(reversed: Bool = false) {
        print("︵")
        if reversed {
            for i in (0..<top).reversed() {
                print(buffer[i])
            }
        } else {
            for i in 0..<top {
                print(buffer[i])
            }
        }
        print("︶")
    }
}
