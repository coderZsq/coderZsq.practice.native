//
//  main.swift
//  DataStructure
//
//  Created by 朱双泉 on 05/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

var bits = BitSet(size: 140)

public func scope(of description: String, execute: Bool, action: () -> ()) {
    guard execute else { return }
    print("--- scope of:", description, "---")
    action()
}

scope(of: "queue", execute: true) {
    
    let queue_i = Queue_<Int>()
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
    
    let queue_s = Queue_<String>(5)
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
    
    let stack_i = Stack_<Int>(3)
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

    let stack_s = Stack_<String>()
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
        let stack = Stack_<Int>(30)
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
        let stack = Stack_<Character>(30)
        let needStack = Stack_<Character>(30)
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
    
    scope(of: "array-list", execute: true, action: {
        
        let list_i = List1<Int>(10)
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
        
        let list_s = List1<String>()
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
    })
    
    scope(of: "link-list", execute: true) {
        
        let list_i = List2<Int>()
        for i in 1...7 {
            list_i.insertTail(node: Node<Int>(data: i))
        }
        list_i.traverse()
        
        list_i.getElement(loc: 2)?.printNode()
        
        let node_i = Node<Int>(data: 1024)
        list_i.insert(loc: 5, node: node_i)
        list_i.traverse()
        
        print(list_i.locate(of: node_i))
        print(list_i.size())
        
        list_i.prior(of: node_i)?.printNode()
        list_i.next(of: node_i)?.printNode()
        list_i.delete(loc: 5)?.printNode()
        
        list_i.traverse()
        
        let list_s = List2<String>()
        let alphabet = "ABCDEFG"
        for i in alphabet {
            list_s.insertHead(node: Node<String>(data: String(i)))
        }
        list_s.traverse()
        
        list_s.getElement(loc: 6)?.printNode()
        
        let node_s = Node<String>(data: "Castie!")
        list_s.insert(loc: 3, node: node_s)
        list_s.getElement(loc: 3)?.printNode()
        
        list_s.traverse()
        
        list_s.prior(of: node_s)?.printNode()
        list_s.next(of: node_s)?.printNode()
    }
}

scope(of: "tree", execute: true) {
    
    scope(of: "array-tree", execute: true, action: {
        
        let tree_i = Tree1(15, root: Node<Int>(data: 3))
        tree_i.addNode(loc: 0, direction: .right, node: Node<Int>(data: 4))
        tree_i.addNode(loc: 2, direction: .left, node: Node<Int>(data: 5))
        tree_i.addNode(loc: 5, direction: .right, node: Node<Int>(data: 6))
        
        tree_i.traverse()
        
        tree_i.searchNode(loc: 5)?.printNode()
        tree_i.deleteNode(loc: 2)
        
        tree_i.traverse()
        
        let tree_s = Tree1(7, root: Node<String>(data: "root"))
        tree_s.addNode(loc: 0, direction: .left, node: Node<String>(data: "one"))
        tree_s.addNode(loc: 1, direction: .right, node: Node<String>(data: "two"))
        
        tree_s.traverse()
    })
    
    scope(of: "link-tree", execute: true) {
        
        let tree_i = Tree2(root: Node<Int>(data: 0))
        tree_i.addNode(loc: 0, direction: .right, node: Node<Int>(index: 1, data: 4))
        tree_i.addNode(loc: 1, direction: .left, node: Node<Int>(index: 2, data: 5))
        tree_i.addNode(loc: 2, direction: .right, node: Node<Int>(index: 3, data: 6))
        
        tree_i.preorderTraversal()
        tree_i.inorderTraversal()
        tree_i.postorderTraversal()
        
        tree_i.searchNode(loc: 3)?.printNode()
        tree_i.deleteNode(loc: 1)
        
        tree_i.preorderTraversal()
        tree_i.inorderTraversal()
        tree_i.postorderTraversal()
        
        let tree_s = Tree2(root: Node<String>(data: "root"))
        tree_s.addNode(loc: 0, direction: .left, node: Node<String>(index: 1, data: "one"))
        tree_s.addNode(loc: 1, direction: .right, node: Node<String>(index: 2, data: "two"))
        tree_s.addNode(loc: 2, direction: .left, node: Node<String>(index: 3, data: "three"))
        tree_s.addNode(loc: 3, direction: .right, node: Node<String>(index: 4, data: "four"))
        tree_s.addNode(loc: 4, direction: .left, node: Node<String>(index: 5, data: "five"))
        tree_s.addNode(loc: 5, direction: .right, node: Node<String>(index: 6, data: "six"))
        tree_s.addNode(loc: 6, direction: .left, node: Node<String>(index: 7, data: "seven"))
        
        tree_s.preorderTraversal()
        tree_s.inorderTraversal()
        tree_s.postorderTraversal()
    }
}

scope(of: "map", execute: true) {
    
    let map_s = Map<String>(8)
    map_s.addNode(Node<String>(data: "A"))
    map_s.addNode(Node<String>(data: "B"))
    map_s.addNode(Node<String>(data: "C"))
    map_s.addNode(Node<String>(data: "D"))
    map_s.addNode(Node<String>(data: "E"))
    map_s.addNode(Node<String>(data: "F"))
    map_s.addNode(Node<String>(data: "G"))
    map_s.addNode(Node<String>(data: "H"))
    
    map_s.setValueToMatrixForUndirectedGraph(row: 0, col: 1)
    map_s.setValueToMatrixForUndirectedGraph(row: 0, col: 3)
    map_s.setValueToMatrixForUndirectedGraph(row: 1, col: 2)
    map_s.setValueToMatrixForUndirectedGraph(row: 1, col: 5)
    map_s.setValueToMatrixForUndirectedGraph(row: 3, col: 6)
    map_s.setValueToMatrixForUndirectedGraph(row: 3, col: 7)
    map_s.setValueToMatrixForUndirectedGraph(row: 6, col: 7)
    map_s.setValueToMatrixForUndirectedGraph(row: 2, col: 4)
    map_s.setValueToMatrixForUndirectedGraph(row: 4, col: 5)

    map_s.printMatrix()
    map_s.depthFirstTraverse(loc: 0)
    map_s.resetNode()
    map_s.breadthFirstTraverse(loc: 0)
    
    scope(of: "prim-tree / kruskal-tree", execute: true, action: {
        
        let map = Map<String>(6)
        map.addNode(Node<String>(data: "A"))
        map.addNode(Node<String>(data: "B"))
        map.addNode(Node<String>(data: "C"))
        map.addNode(Node<String>(data: "D"))
        map.addNode(Node<String>(data: "E"))
        map.addNode(Node<String>(data: "F"))
        
        map.setValueToMatrixForUndirectedGraph(row: 0, col: 1, val: 6)
        map.setValueToMatrixForUndirectedGraph(row: 0, col: 4, val: 5)
        map.setValueToMatrixForUndirectedGraph(row: 0, col: 5, val: 1)
        map.setValueToMatrixForUndirectedGraph(row: 1, col: 2, val: 3)
        map.setValueToMatrixForUndirectedGraph(row: 1, col: 5, val: 2)
        map.setValueToMatrixForUndirectedGraph(row: 2, col: 5, val: 8)
        map.setValueToMatrixForUndirectedGraph(row: 2, col: 3, val: 7)
        map.setValueToMatrixForUndirectedGraph(row: 3, col: 5, val: 4)
        map.setValueToMatrixForUndirectedGraph(row: 3, col: 4, val: 2)
        map.setValueToMatrixForUndirectedGraph(row: 4, col: 5, val: 9)
        
        map.printMatrix()
        map.primTree(loc: 0)
        map.kruskalTree()
    })
}
