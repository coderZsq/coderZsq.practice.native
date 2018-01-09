//
//  LinkList.swift
//  DataStructure
//
//  Created by 朱双泉 on 09/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Node<Element: Hashable>: Hashable {
    
    var hashValue: Int = 0
    static func ==(lhs: Node, rhs: Node) -> Bool {
        func address(of pointer: Node) -> UnsafeMutableRawPointer {
            return Unmanaged.passUnretained(pointer).toOpaque()
        }
        return address(of: lhs) == address(of: rhs) ? true : false
    }
    
    var data: Element?
    var next: Node?
    
    init() {}
    
    func printNode() {
        guard let data = data else { return }
        print(data)
    }
}

class LinkList<Element: Hashable> {
    
    private var head: Node<Element>
    private var length: Int = 0
    
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
