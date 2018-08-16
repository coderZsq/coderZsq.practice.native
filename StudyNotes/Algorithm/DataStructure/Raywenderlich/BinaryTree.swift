//
//  BinaryTree.swift
//  DataStructure
//
//  Created by 朱双泉 on 2018/6/4.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

public indirect enum BinaryTree<T> {
    case node(BinaryTree<T>, T, BinaryTree<T>)
    case empty
    
    public var count: Int {
        switch self {
        case let .node(left, _, right):
            return left.count + 1 + right.count
        case .empty:
            return 0
        }
    }
}

extension BinaryTree: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case let .node(left, value, right):
            return "value: \(value), left = [\(left.description)], right = [\(right.description)]"
        case .empty:
            return ""
        }
    }
}

extension BinaryTree {
    
    public func traverseInOrder(process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            left.traverseInOrder(process: process)
            process(value)
            right.traverseInOrder(process: process)
        }
    }
    
    public func traversePreOrder(process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            process(value)
            left.traverseInOrder(process: process)
            right.traverseInOrder(process: process)
        }
    }
    
    public func traversePostOrder(process: (T) -> Void) {
        if case let .node(left, value, right) = self {
            left.traverseInOrder(process: process)
            right.traverseInOrder(process: process)
            process(value)
        }
    }
}

extension BinaryTree {
    
    func invert() -> BinaryTree {
        if case let .node(left, value, right) = self {
            return .node(right.invert(), value, left.invert())
        } else {
            return .empty
        }
    }
}
