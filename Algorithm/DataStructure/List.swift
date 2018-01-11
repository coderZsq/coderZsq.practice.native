//
//  List.swift
//  DataStructure
//
//  Created by 朱双泉 on 08/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class List1<Element: Comparable> {
    
    private var capacity: Int  = 0
    private lazy var length: Int = 0
    private lazy var list: [Element] = [Element]()
    
    init(_ listCapacity: Int = 16) {
        capacity = listCapacity
    }
    
    func clear() {
        length = 0
    }
    
    func isEmpty() -> Bool {
        return length == 0 ? true : false
    }
    
    func size() -> Int {
        return length
    }
    
    func getElement(loc index: Int) -> Element? {
        if index < 0 || index >= capacity || length == 0 {
            return nil
        }
        return list[index]
    }
    
    func locate(of element: Element) -> Int {
        for i in 0..<length {
            if list[i] == element {
                return i
            }
        }
        return -1
    }
    
    func prior(of element: Element) -> Element? {
        let temp = locate(of: element)
        if temp == -1 {
            return nil
        } else {
            if temp == 0 {
                return nil
            } else {
                return list[temp - 1]
            }
        }
    }
    
    func next(of element: Element) -> Element? {
        let temp = locate(of: element)
        if temp == -1 {
            return nil
        } else {
            if temp == length - 1 {
                return nil
            } else {
                return list[temp + 1]
            }
        }
    }
    
    @discardableResult func insert(loc index: Int, element: Element) -> Bool {
        if index < 0 || index > length {
            return false
        }
        list.append(element)
        for i in (index..<length).reversed() {
            list[i + 1] = list[i]
        }
        list[index] = element
        length += 1
        return true
    }
    
    @discardableResult func delete(loc index: Int) -> Element? {
        if index < 0 || index >= length {
            return nil
        }
        for i in (index + 1)..<length {
            list[i - 1] = list[i]
        }
        length -= 1
        return list[index]
    }
    
    func traverse() {
        print("︵")
        for i in 0..<length {
            print(list[i])
        }
        print("︶")
    }
}

class List2<Element: Hashable> {
    
    private var head: Node<Element>
    private lazy var length: Int = 0
    
    init() {
        head = Node()
        head.data = nil
        head.next = nil
    }
    
    func clear() {
        var node = head.next
        while node != nil {
            let temp = node?.next
            node = nil
            node = temp
        }
        head.next = nil
    }
    
    func isEmpty() -> Bool {
        return length == 0 ? true : false
    }
    
    func size() -> Int {
        return length
    }
    
    func getElement(loc index: Int) -> Node<Element>? {
        if index < 0 || index >= length {
            return nil
        }
        var currentNode = head
        for _ in 0...index {
            guard let node = currentNode.next else { continue }
            currentNode = node
        }
        let node = Node<Element>()
        node.data = currentNode.data
        return node
    }
    
    func locate(of node: Node<Element>) -> Int {
        var currentNode = head
        var count = 0
        while currentNode.next != nil {
            currentNode = currentNode.next!
            if currentNode.data == node.data {
                return count
            }
            count += 1
        }
        return -1
    }
    
    func prior(of node: Node<Element>) -> Node<Element>? {
        var currentNode = head
        var tempNode: Node<Element>? = nil
        while currentNode.next != nil {
            tempNode = currentNode
            currentNode = currentNode.next!
            if currentNode.data == node.data {
                guard let tempNode = tempNode else { continue }
                if tempNode == head {
                    return nil
                }
                let node = Node<Element>()
                node.data = tempNode.data
                return node
            }
        }
        return nil
    }
    
    func next(of node: Node<Element>) -> Node<Element>? {
        var currentNode = head
        while currentNode.next != nil {
            currentNode = currentNode.next!
            if currentNode.data == node.data {
                if currentNode.next == nil {
                    return nil
                }
                guard let data = currentNode.next?.data else { continue }
                let node = Node<Element>()
                node.data = data
                return node
            }
        }
        return nil
    }
    
    @discardableResult func insert(loc index: Int, node: Node<Element>) -> Bool {
        if index < 0 || index >= length {
            return false
        }
        var currentNode = head
        for _ in 0..<index {
            guard let nextNode = currentNode.next else { continue }
            currentNode = nextNode
        }
        let newNode = Node<Element>()
        newNode.data = node.data
        newNode.next = currentNode.next
        currentNode.next = newNode
        length += 1
        return true
    }
    
    @discardableResult func delete(loc index: Int) -> Node<Element>? {
        if index < 0 || index >= length {
            return nil
        }
        var currentNode = head
        var currentNodeBefore: Node<Element>? = nil
        for _ in 0...index {
            currentNodeBefore = currentNode
            guard let nextNode = currentNode.next else { continue }
            currentNode = nextNode
        }
        currentNodeBefore?.next = currentNode.next
        let node = Node<Element>()
        node.data = currentNode.data
        length -= 1
        return node
    }
    
    @discardableResult func insertHead(node: Node<Element>) -> Bool {
        let temp = head.next
        let newNode = Node<Element>()
        newNode.data = node.data
        head.next = newNode
        newNode.next = temp
        length += 1
        return true
    }
    
    @discardableResult func insertTail(node: Node<Element>) -> Bool {
        var currentNode = head
        while currentNode.next != nil {
            currentNode = currentNode.next!
        }
        let newNode = Node<Element>()
        newNode.data = node.data
        newNode.next = nil
        currentNode.next = newNode
        length += 1
        return true
    }
    
    func traverse() {
        print("︵")
        var currentNode = head
        while currentNode.next != nil {
            currentNode = currentNode.next!
            currentNode.printNode()
        }
        print("︶")
    }
}
