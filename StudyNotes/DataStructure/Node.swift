//
//  Node.swift
//  DataStructure
//
//  Created by 朱双泉 on 10/01/2018.
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
    // for list
    var next: Node?
    // for tree
    var index: Int = 0
    var leftChild: Node?
    var rightChild: Node?
    var parent: Node?
    // for map
    var visited: Bool = false
    
    init() {}
    
    init(data nodeData: Element) {
        data = nodeData
    }
    
    init(index nodeIndex: Int, data nodeData: Element) {
        index = nodeIndex
        data = nodeData
    }
    
    func searchNode(nodeIndex: Int) -> Node<Element>? {
        if index == nodeIndex {
            return self
        }
        var temp: Node<Element>? = nil
        if leftChild != nil {
            if leftChild?.index == nodeIndex {
                return leftChild
            } else {
                temp = leftChild?.searchNode(nodeIndex: nodeIndex)
                if temp != nil {
                    return temp
                }
            }
        }
        if rightChild != nil {
            if rightChild?.index == nodeIndex {
                return rightChild
            } else {
                temp = rightChild?.searchNode(nodeIndex: nodeIndex)
                if temp != nil {
                    return temp
                }
            }
        }
        return nil
    }
    
    func deleteNode() {
        if leftChild != nil {
            leftChild?.deleteNode()
        }
        if rightChild != nil {
            rightChild?.deleteNode()
        }
        if parent != nil {
            if parent?.leftChild == self {
                parent?.leftChild = nil
            }
            if parent?.rightChild == self {
                parent?.rightChild = nil
            }
        }
        parent = nil
    }
    
    enum PrintType {
        case dafault
        case preorder
        case inorder
        case postorder
    }
    
    func printNode(_ type: PrintType = .dafault) {
        guard let data = data else { return }
        switch type {
        case .dafault:
            print(data)
        case .preorder:
            print("\(index), \(data)")
            if leftChild != nil {
                leftChild?.printNode(.preorder)
            }
            if rightChild != nil {
                rightChild?.printNode(.preorder)
            }
        case .inorder:
            if leftChild != nil {
                leftChild?.printNode(.inorder)
            }
            print("\(index), \(data)")
            if rightChild != nil {
                rightChild?.printNode(.inorder)
            }
        case .postorder:
            if leftChild != nil {
                leftChild?.printNode(.postorder)
            }
            if rightChild != nil {
                rightChild?.printNode(.postorder)
            }
            print("\(index), \(data)")
        }
    }
}
