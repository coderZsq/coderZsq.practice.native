//
//  DataStructures.swift
//  Functional
//
//  Created by 朱双泉 on 2018/5/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

struct MySet<Element: Equatable> {
    var storage: [Element] = []
    
    var isEmpty: Bool {
        return storage.isEmpty
    }
    
    func contains(_ element: Element) -> Bool {
        return storage.contains(element)
    }
    
    func inserting(_ x: Element) -> MySet {
        return contains(x) ? self : MySet(storage: storage + [x])
    }
}

indirect enum BinarySearchTree<Element: Comparable> {
    case leaf
    case node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
}

let leaf: BinarySearchTree<Int> = .leaf
let five: BinarySearchTree<Int> = .node(leaf, 5, leaf)

extension BinarySearchTree {
    init() {
        self = .leaf
    }
    
    init(_ value: Element) {
        self = .node(.leaf, value, .leaf)
    }
}

extension BinarySearchTree {
    var count: Int {
        switch self {
        case .leaf:
            return 0
        case let .node(left, _ , right):
            return 1 + left.count + right.count
        }
    }
}

extension BinarySearchTree {
    var elements: [Element] {
        switch self {
        case .leaf:
            return []
        case let .node(left, x, right):
            return left.elements + [x] + right.elements
        }
    }
}

extension BinarySearchTree {
    func reduce<A>(leaf leafF: A, node nodeF: (A, Element, A) -> A) -> A {
        switch self {
        case .leaf:
            return leafF
        case let .node(left, x, right):
            return nodeF(left.reduce(leaf: leafF, node: nodeF), x, right.reduce(leaf: leafF, node: nodeF))
        }
    }
}

extension BinarySearchTree {
    var elementR: [Element] {
        return reduce(leaf: []) {$0 + [$1] + $2}
    }
    var countR: Int {
        return reduce(leaf: 0) {1 + $0 + $2}
    }
}

extension BinarySearchTree {
    var isEmpty: Bool {
        if case .leaf = self {
            return true
        }
        return false
    }
}

extension BinarySearchTree {
    var isBST: Bool {
        switch self {
        case .leaf:
            return true
        case let .node(left, x, right):
            return left.elements.all {y in y < x}
                && right.elements.all {y in y > x}
                && left.isBST
                && right.isBST
        }
    }
}

extension Sequence {
    func all(predicate: (Iterator.Element) -> Bool) -> Bool {
        for x in self where !predicate(x) {
            return false
        }
        return true
    }
}

extension BinarySearchTree {
    func contains(_ x: Element) -> Bool {
        switch self {
        case .leaf:
            return false
        case let .node(_, y, _) where x == y:
            return true
        case let .node(left, y, _) where x < y:
            return left.contains(x)
        case let .node(_, y, right) where x > y:
            return right.contains(x)
        default:
            fatalError("The impossible occurred")
        }
    }
}

extension BinarySearchTree {
    mutating func insert(_ x: Element) {
        switch self {
        case .leaf:
            self = BinarySearchTree(x)
        case .node(var left, let y, var right):
            if x < y {left.insert(x)}
            if x > y {right.insert(x)}
            self = .node(left, y, right)
        }
    }
}

class DataStructure {
    static func run() {
        let myTree: BinarySearchTree<Int> = BinarySearchTree()
        var copied = myTree
        copied.insert(5)
        print(myTree.elements)
        print(copied.elements)
    }
}
