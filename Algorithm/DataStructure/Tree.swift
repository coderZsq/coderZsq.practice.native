//
//  Tree.swift
//  DataStructure
//
//  Created by 朱双泉 on 10/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

enum Direction {
    case left
    case right
}

class Tree1<Element> {
    
    private var tree: [Any]
    private var capacity: Int
    
    init(_ treeCapacity: Int, root: Element) {
        capacity = treeCapacity
        tree = [Any](repeating: 0, count: treeCapacity)
        tree[0] = root
    }
    
    func searchNode(loc index: Int) -> Element? {
        if index < 0 || index >= capacity {
            return nil
        }
        if tree[index] as? Int == 0 {
            return nil
        }
        return tree[index] as? Element
    }
    
    @discardableResult func addNode(loc index: Int, direction: Direction, node: Element) -> Bool {
        if index < 0 || index >= capacity {
            return false
        }
        if tree[index] as? Int == 0 {
            return false
        }
        switch direction {
        case .left:
            if index * 2 + 1 >= capacity {
                return false
            }
            if tree[index * 2 + 1] as? Int != 0 {
                return false
            }
            tree[index * 2 + 1] = node
        case .right:
            if index * 2 + 2 >= capacity {
                return false
            }
            if tree[index * 2 + 2] as? Int != 0 {
                return false
            }
            tree[index * 2 + 2] = node
        }
        return true
    }
    
    @discardableResult func deleteNode(loc index: Int) -> Bool {
        if index < 0 || index >= capacity {
            return false
        }
        if tree[index] as? Int == 0 {
            return false
        }
        tree[index] = 0
        deleteNode(loc: index * 2 + 1)
        deleteNode(loc: index * 2 + 2)
        return true
    }
    
    func traverse() {
        print("︵")
        for i in 0..<capacity {
            if tree[i] is Node<Int> {
                let node = tree[i] as? Node<Int>
                node?.printNode()
            } else if tree[i] is Node<String> {
                let node = tree[i] as? Node<String>
                node?.printNode()
            } else {
                print(tree[i])
            }
        }
        print("︶")
    }
}

class Tree2<Element: Hashable> {
    
    private var root: Node<Element>
    
    init(root node: Node<Element>) {
        root = node
    }
    
    func searchNode(loc index: Int) -> Node<Element>? {
        return root.searchNode(nodeIndex: index)
    }
    
    @discardableResult  func addNode(loc index: Int, direction: Direction, node: Node<Element>) -> Bool {
        guard let temp = searchNode(loc: index) else { return false }
        let newNode = Node<Element>()
        newNode.index = node.index
        newNode.data = node.data
        newNode.parent = temp
        if direction == .left {
            temp.leftChild = newNode
        }
        if direction == .right {
            temp.rightChild = newNode
        }
        return true
    }
    
    @discardableResult func deleteNode(loc index: Int) -> Node<Element>? {
        guard let temp = searchNode(loc: index) else { return nil }
        temp.deleteNode()
        return temp
    }
    
    func preorderTraversal() {
        print("︵")
        root.printNode(.preorder)
        print("︶")
    }
    
    func inorderTraversal() {
        print("︵")
        root.printNode(.inorder)
        print("︶")
    }
    
    func postorderTraversal() {
        print("︵")
        root.printNode(.postorder)
        print("︶")
    }
}
