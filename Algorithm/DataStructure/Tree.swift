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

class Tree<Element> {
    
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

class LinkTree<Element: Hashable> {
    
    private var m_pRoot: Node<Element> = Node<Element>()
    
    func searchNode(nodeIndex: Int) -> Node<Element>? {
        return m_pRoot.searchNode(nodeIndex: nodeIndex)
    }
    
    func addNode(nodeIndex: Int, direction: Direction, pNode: Node<Element>) -> Bool {
        guard let temp = searchNode(nodeIndex: nodeIndex) else { return false }
        let node = Node<Element>()
        node.index = pNode.index
        node.data = pNode.data
        if direction == .left {
            temp.leftChild = node
        }
        if direction == .right {
            temp.rightChild = node
        }
        return true
    }
    
    func deleteNode(nodeIndex: Int, pNode: Node<Element>?) -> Bool {
        guard let temp = searchNode(nodeIndex: nodeIndex) else { return false }
        if pNode != nil {
            pNode?.data = temp.data
        }
        temp.deleteNode()
        return true
    }
    
    func preorderTraversal() {
        m_pRoot.printNode(.preorder)
    }
    
    func inorderTraversal() {
        m_pRoot.printNode(.inorder)
    }
    
    func postorderTraversal() {
        m_pRoot.printNode(.postorder)
    }
}
