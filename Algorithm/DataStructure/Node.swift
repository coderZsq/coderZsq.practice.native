//
//  Node.swift
//  DataStructure
//
//  Created by 朱双泉 on 10/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Node<Element: Hashable>: Hashable {
    
    enum PrintType {
        case dafault
        case preorder
        case inorder
        case postorder
    }
    
    var hashValue: Int = 0
    static func ==(lhs: Node, rhs: Node) -> Bool {
        func address(of pointer: Node) -> UnsafeMutableRawPointer {
            return Unmanaged.passUnretained(pointer).toOpaque()
        }
        return address(of: lhs) == address(of: rhs) ? true : false
    }
    
    var data: Element?
    var next: Node?
    var index: Int = 0
    var leftChild: Node?
    var rightChild: Node?
    var parent: Node?
    
    init() {}
    
    init(data nodeData: Element) {
        data = nodeData
    }
    
    func searchNode(nodeIndex: Int) -> Node<Element>? {
        if index == nodeIndex {
            return self
        }
        if leftChild != nil && leftChild?.index == nodeIndex {
            return leftChild
        }
        if rightChild != nil && rightChild?.index == nodeIndex {
            return rightChild
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
    }
    
    func printNode(_ type: PrintType = .dafault) {
        guard let data = data else { return }
        switch type {
        case .dafault:
            print(data)
        case .preorder:
            print("data: \(data), index: \(index)")
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
            print("data: \(data), index: \(index)")
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
            print("data: \(data), index: \(index)")
        }
    }
}
