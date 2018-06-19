//
//  Protocol.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/6/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation
import UIKit

struct Protocol {
    
    static func run() {
        var context: Drawing = SVG()
        let rect1 = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rect2 = CGRect(x: 0, y: 0, width: 50, height: 50)
        context.addRectangle(rect: rect1, fill: .yellow)
        context.addEllipse(rect: rect2, fill: .blue)
        print(context)
        
        var sample = SVG()
        sample.addCircle(center: .zero, radius: 20, fill: .red)
        print(sample)
        
        var otherSample: Drawing = SVG()
        otherSample.addCircle(center: .zero, radius: 20, fill: .red)
        print(otherSample)
//    Protocol 'Equatable' can only be used as a generic constraint because it has Self or associated type requirements
//        let x: Equatable = MonetaryAmount(currency: "EUR", amountInCents: 100)
        
        let one = IntegerRef(1)
        let otherOne = IntegerRef(1)
        print(one == otherOne)
        
        let two: NSObject = IntegerRef(2)
        let otherTwo: NSObject = IntegerRef(2)
        print(two == otherTwo)
        
        print(f(5))
        print(g(5))
        
//        typealias Any = protocol<>
        print(MemoryLayout<Any>.size)

        typealias P = Prot & Prot2 & Prot3 & Prot4
        print(MemoryLayout<P>.size)
        
        print(MemoryLayout<ClassOnly>.size)
        
        print(MemoryLayout<NSObjectProtocol>.size)
    }
}

//extension Sequence where Element: Comparable {
//    func sorted() -> [Self.Element]
//}

//extension MutableCollection where Self: RandomAccessCollection, Self.Element: Comparable {
//    mutating func sort()
//}

protocol Drawing {
    mutating func addEllipse(rect: CGRect, fill: UIColor)
    mutating func addRectangle(rect: CGRect, fill: UIColor)
    mutating func addCircle(center: CGPoint, radius: CGFloat, fill: UIColor)
}

extension CGContext: Drawing {
    func addEllipse(rect: CGRect, fill: UIColor) {
        setFillColor(fill.cgColor)
        fillEllipse(in: rect)
    }
    func addRectangle(rect: CGRect, fill fillColor: UIColor) {
        setFillColor(fillColor.cgColor)
        fill(rect)
    }
}

struct XMLNode {
    let tag: String
    var children = [XMLNode]()
    
    init(tag: String) {
        self.tag = tag
    }
    
    init(tag: String, attributes: [String : String]) {
        self.tag = tag
    }
}

struct SVG {
    var rootNode = XMLNode(tag: "tag")
    mutating func append(node: XMLNode) {
        rootNode.children.append(node)
    }
}

extension CGRect {
    var svgAttributes: [String : String] {
        return ["" : ""]
    }
}

extension String {
    init(hexColor: UIColor) {
        self.init()
    }
}

extension SVG: Drawing {
    mutating func addEllipse(rect: CGRect, fill: UIColor) {
        var attributes: [String : String] = rect.svgAttributes
        attributes["fill"] = String(hexColor: fill)
        append(node: XMLNode(tag: "ellipse", attributes: attributes))
    }
    mutating func addRectangle(rect: CGRect, fill: UIColor) {
        var attributes: [String : String] = rect.svgAttributes
        attributes["fill"] = String(hexColor: fill)
        append(node: XMLNode(tag: "rect", attributes: attributes))
    }
}

extension Drawing {
    mutating func addCircle(center: CGPoint, radius: CGFloat, fill: UIColor) {
        let diameter = radius * 2
        let origin = CGPoint(x: center.x - radius, y: center.y - radius)
        let size = CGSize(width: diameter, height: diameter)
        let rect = CGRect(origin: origin, size: size)
        addEllipse(rect: rect, fill: fill)
    }
}

extension SVG {
    mutating func addCircle(center: CGPoint, radius: CGFloat, fill: UIColor) {
        var attributes: [String : String] = [
            "cx" : "\(center.x)",
            "cy" : "\(center.y)",
            "r" : "\(radius)"
        ]
        attributes["fill"] = String(hexColor: fill)
        append(node: XMLNode(tag: "circle", attributes: attributes))
    }
}

class IntIterator {
    var nextImpl: () -> Int?
    
    init<I: IteratorProtocol>(_ iterator: I) where I.Element == Int {
        var iteratorCopy = iterator
        self.nextImpl = {iteratorCopy.next()}
    }
}

extension IntIterator: IteratorProtocol {
    func next() -> Int? {
        return nextImpl()
    }
}

//class AnyIterator<A>: IteratorProtocol {
//    var nextImpl: () -> A?
//
//    init<I: IteratorProtocol>(_ iterator: I) where I.Element == A {
//        var iteratorCopy = iterator
//        self.nextImpl = {iteratorCopy.next()}
//    }
//
//    func next() -> A? {
//        return nextImpl()
//    }
//}
//
class IteratorBox<Element>: IteratorProtocol {
    func next() -> Element? {
        fatalError("This method is abstract.")
    }
}
#if false
class IteratorBoxHelper<I: IteratorProtocol> {
    var iterator: I
    init(iterator: I) {
        self.iterator = iterator
    }
    func next() -> I.Element? {
        return iterator.next()
    }
}
#endif
class IteratorBoxHelper<I: IteratorProtocol>: IteratorBox<I.Element> {
    var iterator: I
    init(_ iterator: I) {
        self.iterator = iterator
    }
    override func next() -> I.Element? {
        return iterator.next()
    }
}

struct MonetaryAmount: Equatable {
    var currency: String
    var amountInCents: Int

    static func ==(lhs: MonetaryAmount, rhs: MonetaryAmount) -> Bool {
        return lhs.currency == rhs.currency && lhs.amountInCents == rhs.amountInCents
    }
}

func allEqual<E: Equatable>(x: [E]) -> Bool {
    guard let firstElement = x.first else {return true}
    for element in x {
        guard element == firstElement else {return false}
    }
    return true
}

extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        guard let firstElement = first else {return true}
        for element in self {
            guard element == firstElement else {return false}
        }
        return true
    }
}

class IntegerRef: NSObject {
    let int: Int
    init(_ int: Int) {
        self.int = int
    }
}

func ==(lhs: IntegerRef, rhs: IntegerRef) -> Bool {
    return lhs.int == rhs.int
}

func f<C: CustomStringConvertible>(_ x: C) -> Int {
    return MemoryLayout.size(ofValue: x)
}

func g(_ x: CustomStringConvertible) -> Int {
    return MemoryLayout.size(ofValue: x)
}

protocol Prot {}
protocol Prot2 {}
protocol Prot3 {}
protocol Prot4 {}

protocol ClassOnly: AnyObject {}

func printProtocol(array: [CustomStringConvertible]) {
    print(array)
}

func printGeneric<A: CustomStringConvertible>(array: [A]) {
    print(array)
}

