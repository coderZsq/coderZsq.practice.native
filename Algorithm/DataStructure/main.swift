//
//  main.swift
//  DataStructure
//
//  Created by 朱双泉 on 05/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

public func scope(of description: String, execute: Bool, action: () -> ()) {
    guard execute else { return }
    print("--- scope of:", description, "---")
    action()
}

scope(of: "queue", execute: true) {
    
    let queue_i = Queue<Int>()
    queue_i.entry(1)
    queue_i.entry(2)
    queue_i.entry(3)
    queue_i.traverse()
    
    print(queue_i.depart()!)
    queue_i.traverse()
    
    print(queue_i.depart()!)
    queue_i.traverse()
    
    queue_i.entry(4)
    queue_i.entry(5)
    queue_i.traverse()
    
    print(queue_i.depart()!)
    queue_i.traverse()
    
    let queue_s = Queue<String>(5)
    queue_s.entry("one")
    queue_s.entry("two")
    queue_s.entry("three")
    queue_s.entry("four")
    queue_s.entry("five")
    queue_s.entry("six")
    queue_s.entry("seven")
    queue_s.entry("eight")
    queue_s.entry("nine")
    queue_s.traverse()
    
    print(queue_s.depart()!)
    print(queue_s.depart()!)
    print(queue_s.depart()!)
    queue_s.entry("ten")
    queue_s.traverse()
}

scope(of: "stack", execute: true) {
    
    let stack_i = Stack<Int>(3)
    stack_i.push(1)
    stack_i.push(2)
    stack_i.push(3)
    stack_i.push(4)
    stack_i.traverse()

    print(stack_i.pop()!)
    stack_i.traverse()

    stack_i.push(5)
    stack_i.push(6)
    stack_i.traverse()

    print(stack_i.pop()!)
    stack_i.traverse()

    let stack_s = Stack<String>()
    stack_s.push("one")
    stack_s.push("two")
    stack_s.push("three")
    stack_s.traverse()

    stack_s.pop()
    stack_s.pop()
    stack_s.pop()
    stack_s.pop()
    stack_s.traverse()

    func converse(_ origin: Int , format: Int) -> String {
        let stack = Stack<Int>(30)
        var ori = origin
        var mod = 0
        var char = ["0","1","2","3","4","5","6","7","8","9",
                    "A","B","C","D","E","F"]
        var conversed = ""
        while ori != 0 {
            mod = ori % format
            stack.push(mod)
            ori /= format
        }
        while !stack.isEmpty() {
            guard let index = stack.pop() else { continue }
            conversed += char[index]
        }
        stack.clear()
        return "(\(conversed))"
    }
    print(converse(1000, format: 2))
    print(converse(1000, format: 8))
    print(converse(1000, format: 10))
    print(converse(123456789, format: 16))

    func match(_ brackets: String) -> Bool {
        let stack = Stack<Character>(30)
        let needStack = Stack<Character>(30)
        var currentNeed = Character(" ")
        for i in 0..<brackets.count {
            let char = brackets[brackets.index(brackets.startIndex, offsetBy: i)]
            if  char != currentNeed {
                stack.push(char)
                switch char {
                case "[":
                    if currentNeed != Character(" ") {
                        needStack.push(currentNeed)
                    }
                    currentNeed = "]"
                    break
                case "(":
                    if currentNeed != Character(" ") {
                        needStack.push(currentNeed)
                    }
                    currentNeed = ")"
                    break
                default:
                    return false
                }
            } else {
                stack.pop()
                guard let need = needStack.pop() else { currentNeed = Character(" "); continue }
                currentNeed = need
            }
        }
        return stack.isEmpty()
    }
    print(match("[]()[]()[]") ? "match" : "not match")
}

scope(of: "list", execute: true) {
    
    let list_i = List<Int>(10)
    list_i.insert(loc: 0, element: 1)
    list_i.insert(loc: 1, element: 2)
    list_i.insert(loc: 2, element: 3)
    list_i.insert(loc: 3, element: 4)
    list_i.insert(loc: 4, element: 5)
    list_i.insert(loc: 5, element: 6)
    list_i.insert(loc: 6, element: 7)
    list_i.traverse()

    list_i.delete(loc: 3)
    list_i.delete(loc: 2)
    list_i.traverse()
    
    print(list_i.prior(of: 6)!)
    print(list_i.next(of: 1)!)
    print(list_i.getElement(loc: 2)!)
    
    let list_s = List<String>()
    list_s.insert(loc: 0, element: "one")
    list_s.insert(loc: 1, element: "two")
    list_s.insert(loc: 2, element: "three")
    list_s.insert(loc: 3, element: "four")
    list_s.insert(loc: 4, element: "five")
    list_s.insert(loc: 5, element: "six")
    list_s.insert(loc: 6, element: "seven")
    list_s.traverse()
    
    list_s.delete(loc: 2)
    list_s.delete(loc: 5)
    list_s.traverse()
    
    print(list_s.prior(of: "two")!)
    print(list_s.next(of: "five")!)
    print(list_s.getElement(loc: 3)!)
}

scope(of: "linkList", execute: true) {

    let linkList_i = LinkList<Int>()
    for i in 1...7 {
        linkList_i.insertTail(node: Node<Int>(data: i))
    }
    linkList_i.traverse()
    
    linkList_i.getElement(loc: 2)?.printNode()
    
    let node_i = Node<Int>(data: 1024)
    linkList_i.insert(loc: 5, node: node_i)
    linkList_i.traverse()
    
    print(linkList_i.locate(of: node_i))
    print(linkList_i.size())
    
    linkList_i.prior(of: node_i)?.printNode()
    linkList_i.next(of: node_i)?.printNode()
    linkList_i.delete(loc: 5)?.printNode()
    
    linkList_i.traverse()

    let linkList_s = LinkList<String>()
    let alphabet = "ABCDEFG"
    for i in alphabet {
        linkList_s.insertHead(node: Node<String>(data: String(i)))
    }
    linkList_s.traverse()
    
    linkList_s.getElement(loc: 6)?.printNode()
    
    let node_s = Node<String>(data: "Castie!")
    linkList_s.insert(loc: 3, node: node_s)
    linkList_s.getElement(loc: 3)?.printNode()
    
    linkList_s.traverse()
    
    linkList_s.prior(of: node_s)?.printNode()
    linkList_s.next(of: node_s)?.printNode()
}

scope(of: "tree", execute: true) {
    
    let tree_i = Tree(15, root: Node<Int>(data: 3))
    tree_i.addNode(loc: 0, direction: .right, node: Node<Int>(data: 4))
    tree_i.addNode(loc: 2, direction: .left, node: Node<Int>(data: 5))
    tree_i.addNode(loc: 5, direction: .right, node: Node<Int>(data: 6))
    
    tree_i.traverse()
    
    tree_i.searchNode(loc: 5)?.printNode()
    tree_i.deleteNode(loc: 2)
    
    tree_i.traverse()
    
    let tree_s = Tree(7, root: Node<String>(data: "root"))
    tree_s.addNode(loc: 0, direction: .left, node: Node<String>(data: "one"))
    tree_s.addNode(loc: 1, direction: .right, node: Node<String>(data: "two"))
    
    tree_s.traverse()
}
