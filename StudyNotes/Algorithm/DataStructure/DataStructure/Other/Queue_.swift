//
//  Queue.swift
//  DataStructure
//
//  Created by 朱双泉 on 04/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Queue_<Element> {
    
    private var capacity: Int
    private lazy var head: Int = 0
    private lazy var tail: Int = 0
    private lazy var length: Int = 0
    private lazy var queue: [Element] = [Element]()
    
    init(_ queueCapacity: Int = 16) {
        capacity = queueCapacity
    }
    
    func clear() {
        head = 0
        tail = 0
        length = 0
    }
    
    func isEmpty() -> Bool {
        return length == 0 ? true : false
    }
    
    func isFull() -> Bool {
        return length == capacity ? true : false
    }
    
    func size() -> Int {
        return length
    }
    
    @discardableResult func entry(_ element: Element) -> Bool {
        guard !isFull() else { return false }
        queue.append(element)
        queue[tail] = element
        tail += 1
        tail %= capacity
        length += 1
        return true
    }
    
    @discardableResult func depart() -> Element? {
        guard !isEmpty() else { return nil }
        let element = queue[head]
        head += 1
        head %= capacity
        length -= 1
        return element
    }
    
    func traverse() {
        print("︵")
        for i in head..<length + head {
            print(queue[i % capacity])
        }
        print("︶")
    }
}
