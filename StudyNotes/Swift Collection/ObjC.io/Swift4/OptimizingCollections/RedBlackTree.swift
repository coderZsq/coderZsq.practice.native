//
//  RedBlackTree.swift
//  OptimizingCollections
//
//  Created by 朱双泉 on 2018/7/4.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

struct RedBlackTree_ {
    
    static func run() {
        let emptyTree: RedBlackTree<Int> = .empty
        print(emptyTree)
        let tinyTree: RedBlackTree<Int> = .node(.black, 42, .empty, .empty)
        print(tinyTree)
        let smallTree: RedBlackTree<Int> =
            .node(.black, 2,
                  .node(.red, 1, .empty, .empty),
                  .node(.red, 3, .empty, .empty)
        )
        print(smallTree)
        let bigTree: RedBlackTree<Int> =
            .node(.black, 9,
                  .node(.red, 5,
                        .node(.black, 1, .empty, .node(.red, 4, .empty, .empty)),
                        .node(.black, 8, .empty, .empty)
                ),
                  .node(.red, 12,
                        .node(.black, 11, .empty, .empty),
                        .node(.black, 16,
                              .node(.red, 14, .empty, .empty),
                              .node(.red, 17, .empty, .empty)
                    )
                )
        )
        print(bigTree)
        var set = RedBlackTree<Int>.empty
        for i in (1...20).shuffled() {
            set.insert(i)
        }
        print(set)
        print(set.lazy.filter{$0 % 2 == 0}.map{"\($0)"}.joined(separator: ", "))
    }
}

public enum Color {
    case black
    case red
}

public enum RedBlackTree<Element: Comparable> {
    case empty
    indirect case node(Color, Element, RedBlackTree, RedBlackTree)
}

public extension RedBlackTree {
    func contains(_ element: Element) -> Bool {
        switch self {
        case .empty:
            return false
        case .node(_, element, _, _):
            return true
        case let .node(_, value, left, _) where value > element:
            return left.contains(element)
        case let .node(_, _, _, right):
            return right.contains(element)
        }
    }
}

public extension RedBlackTree {
    func forEach(_ body: (Element) throws -> Void) rethrows {
        switch self {
        case .empty:
            break
        case let .node(_, value, left, right):
            try left.forEach(body)
            try body(value)
            try right.forEach(body)
        }
    }
}

extension Color {
    var symbol: String {
        switch self {
        case .black: return "■"
        case .red:   return "□"
        }
    }
}

extension RedBlackTree: CustomStringConvertible {
    func diagram(_ top: String, _ root: String, _ bottom: String) -> String {
        switch self {
        case .empty:
            return root + "•\n"
        case let .node(color, value, .empty, .empty):
            return root + "\(color.symbol) \(value)\n"
        case let .node(color, value, left, right):
            return right.diagram(top + "    ", top + "┌───", top + "│   ")
                + root + "\(color.symbol) \(value)\n"
                + left.diagram(bottom + "│   ", bottom + "└───", bottom + "    ")
        }
    }
    
    public var description: String {
        return self.diagram("", "", "")
    }
}

extension RedBlackTree {
    @discardableResult public mutating func insert(_ element: Element) -> (inserted: Bool, memberAfterInsert: Element) {
        let (tree, old) = inserting(element)
        self = tree
        return (old == nil, old ?? element)
    }
}

extension RedBlackTree {
    public func inserting(_ element: Element) -> (tree: RedBlackTree, existingMember: Element?) {
        let (tree, old) = _inserting(element)
        switch tree {
        case let .node(.red, value, left, right):
            return (.node(.black, value, left, right), old)
        default:
            return (tree, old)
        }
    }
}

extension RedBlackTree {
    func _inserting(_ element: Element) -> (tree: RedBlackTree, old: Element?) {
        switch self {
        case .empty:
            return (.node(.red, element, .empty, .empty), nil)
        case let .node(_, value, _, _) where value == element:
            return (self, value)
        case let .node(color, value, left, right) where value > element:
            let (l, old) = left._inserting(element)
            if let old = old {
                return (self, old)
            }
            return (balanced(color, value, l, right), nil)
        case let .node(color, value, left, right):
            let (r, old) = right._inserting(element)
            if let old = old {
                return (self, old)
            }
            return (balanced(color, value, left, r), nil)
        }
    }
}

extension RedBlackTree {
//    func balanced(_ color: Color, _ value: Element, _ left: RedBlackTree, _ right: RedBlackTree) -> RedBlackTree {
//        //Matching a generic value in multiple patterns is not yet supported; use separate cases instead
//        switch (color, value, left, right) {
//        case let (.black, z, .node(.red, y, .node(.red, x, a, b), c), d),
//             let (.black, z, .node(.red, x, a, .node(.red, y, b, c)), d),
//             let (.black, x, a, .node(.red, z, .node(.red, y, b, c), d)),
//             let (.black, x, a, .node(.red, y, b, .node(.red, z, c, d))):
//            return .node(.red, y, .node(.black, x, a, b), .node(.black, z, c, d))
//        default:
//            return .node(color, value, left, right)
//        }
//    }
    func balanced(_ color: Color, _ value: Element, _ left: RedBlackTree, _ right: RedBlackTree) -> RedBlackTree {
        switch (color, value, left, right) {
        case let (.black, z, .node(.red, y, .node(.red, x, a, b), c), d):
            return .node(.red, y, .node(.black, x, a, b), .node(.black, z, c, d))
        case let (.black, z, .node(.red, x, a, .node(.red, y, b, c)), d):
            return .node(.red, y, .node(.black, x, a, b), .node(.black, z, c, d))
        case let (.black, x, a, .node(.red, z, .node(.red, y, b, c), d)):
            return .node(.red, y, .node(.black, x, a, b), .node(.black, z, c, d))
        case let (.black, x, a, .node(.red, y, b, .node(.red, z, c, d))):
            return .node(.red, y, .node(.black, x, a, b), .node(.black, z, c, d))
        default:
            return .node(color, value, left, right)
        }
    }
}

extension RedBlackTree {
    public struct Index {
        fileprivate var value: Element?
    }
}

extension RedBlackTree.Index: Comparable {
    public static func == (left: RedBlackTree<Element>.Index, right: RedBlackTree<Element>.Index) -> Bool {
        return left.value == right.value
    }
    public static func < (left: RedBlackTree<Element>.Index, right: RedBlackTree<Element>.Index) -> Bool {
        if let lv = left.value, let rv = right.value {
            return lv < rv
        }
        return left.value != nil
    }
}

extension RedBlackTree {
    func min() -> Element? {
        switch self {
        case .empty:
            return nil
        case let .node(_, value, left, _):
            return left.min() ?? value
        }
    }
}

extension RedBlackTree {
    func max() -> Element? {
        var node = self
        var maximun: Element? = nil
        while case let .node(_, value, _, right) = node {
            maximun = value
            node = right
        }
        return maximun
    }
}

extension RedBlackTree: Collection {
    public var startIndex: Index {
        return Index(value: self.min())
    }
    public var endIndex: Index {
        return Index(value: nil)
    }
    public subscript(i: Index) -> Element {
        return i.value!
    }
}

extension RedBlackTree: BidirectionalCollection {
    public func index(after i: Index) -> Index {
        let v = self.value(following: i.value!)
        precondition(v.found)
        return Index(value: v.next)
    }
}

extension RedBlackTree {
    func value(following element: Element) -> (found: Bool, next: Element?) {
        switch self {
        case .empty:
            return (false, nil)
        case .node(_, element, _, let right):
            return (true, right.min())
        case let .node(_, value, left, _) where value > element:
            let v = left.value(following: element)
            return (v.found, v.next ?? value)
        case let .node(_, _, _, right):
            return right.value(following: element)
        }
    }
}

extension RedBlackTree {
    func value(preceding element: Element) -> (found: Bool, next: Element?) {
        var node = self
        var previous: Element? = nil
        while case let .node(_, value, left, right) = node {
            if value > element {
                node = left
            }
            else if value < element {
                previous = value
                node = right
            }
            else {
                return (true, left.max() ?? previous)
            }
        }
        return (false, previous)
    }
}

extension RedBlackTree {
    public func index(before i: Index) -> Index {
        if let value = i.value {
            let v = self.value(preceding: value)
            precondition(v.found)
            return Index(value: v.next)
        }
        else {
            return Index(value: max()!)
        }
    }
}

extension RedBlackTree {
    public var count: Int {
        switch self {
        case .empty:
            return 0
        case let .node(_, _, left, right):
            return left.count + 1 + right.count
        }
    }
}

extension RedBlackTree: SortedSet {
    public init() {
        self = .empty
    }
}
