//
//  CoreGraphics.swift
//  Functional
//
//  Created by 朱双泉 on 2018/5/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import CoreGraphics
import UIKit

class DrawView: UIView {
    
    override func draw(_ rect: CGRect) {
//        CoreGraphics.renderer.draw(in: rect)
//        UIGraphicsGetCurrentContext()?.draw(CoreGraphics.example1, in: rect)
//        UIGraphicsGetCurrentContext()?.draw(CoreGraphics.example2, in: rect)
        UIGraphicsGetCurrentContext()?.draw(barGraph(
            [("Moscow", 700),
             ("Shanghai", 1000),
             ("Istanbul", 900),
             ("Berlin", 200),
             ("New York", 500)]
        ), in: rect)
    }
}

class CoreGraphics {
    static var renderer: UIImage {
        let bounds = CGRect(origin: .zero, size: CGSize(width: 300, height: 200))
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            UIColor.blue.setFill()
            context.fill(CGRect(x: 0.0, y: 37.5, width: 75.0, height: 75.0))
            UIColor.red.setFill()
            context.fill(CGRect(x: 75.0, y: 0.0, width: 150.0, height: 150.0))
            UIColor.green.setFill()
            context.cgContext.fillEllipse(in: CGRect(x: 225.0, y: 37.5, width: 75.0, height: 75.0))
        }
    }
}

enum Primitive {
    case ellipase
    case rectangle
    case text(String)
}

indirect enum Diagram {
    case primitive(CGSize, Primitive)
    case beside(Diagram, Diagram)
    case below(Diagram, Diagram)
    case attributed(Attribute, Diagram)
    case align(CGPoint, Diagram)
}

enum Attribute {
    case fillColor(UIColor)
}

extension Diagram {
    var size: CGSize {
        switch self {
        case .primitive(let size, _):
            return size
        case .attributed(_, let x):
            return x.size
        case let .beside(l, r):
            let sizeL = l.size
            let sizeR = r.size
            return CGSize(width: sizeL.width + sizeR.width, height: max(sizeL.height, sizeR.height))
        case let .below(l, r):
            return CGSize(width: max(l.size.width, r.size.width), height: l.size.height + r.size.height)
        case .align(_, let r):
            return r.size
        }
    }
}

func *(l: CGFloat, r: CGSize) -> CGSize {
    return CGSize(width: l * r.width, height: l * r.height)
}

func *(l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: l.width * r.width, height: l.height * r.height)
}

func -(l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: l.width - r.width, height: l.height - r.height)
}

func +(l: CGPoint, r: CGPoint) -> CGPoint {
    return CGPoint(x: l.x + r.x, y: l.y + r.y)
}

extension CGSize {
    var point: CGPoint {
        return CGPoint(x: self.width, y: self.height)
    }
}

extension CGPoint {
    var size: CGSize { return CGSize(width: x, height: y) }
}

extension CGSize {
    func fit(into rect: CGRect, alignment: CGPoint) -> CGRect {
        let scale = min(rect.width / width, rect.height / height)
        let targetSize = scale * self
        let spacerSize = alignment.size * (rect.size - targetSize)
        return CGRect(origin: rect.origin + spacerSize.point, size: targetSize)
    }
}

extension CoreGraphics {
    static func run() {
        let center = CGPoint(x: 0.5, y: 0.5)
        let target = CGRect(x: 0, y: 0, width: 200, height: 100)
        print(CGSize(width: 1,height: 1).fit(into: target, alignment: center))
        
        let topLeft = CGPoint(x: 0, y: 0)
        print(CGSize(width: 1, height: 1).fit(into: target, alignment: topLeft))
    }
}

extension CGContext {
    func draw(_ primitive: Primitive, in frame: CGRect) {
        switch primitive {
        case .rectangle:
            fill(frame)
        case .ellipase:
            fillEllipse(in: frame)
        case .text(let text):
            let font = UIFont.systemFont(ofSize: 12)
            let attributes = [NSAttributedStringKey.font : font]
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            attributedText.draw(in: frame)
        }
    }
}

extension CGPoint {
    static let bottom = CGPoint(x: 0.5, y: 1)
    static let top = CGPoint(x: 0.5, y: 1)
    static let center = CGPoint(x: 0.5, y: 0.5)
}

extension CGRect {
    func split(ratio: CGFloat, edge: CGRectEdge) -> (CGRect, CGRect) {
        let length = edge.isHorizontal ? width : height
        return divided(atDistance: length * ratio, from: edge) }
}

extension CGRectEdge { var isHorizontal: Bool {
    return self == .maxXEdge || self == .minXEdge; }
}

extension CGContext {
    func draw(_ diagram: Diagram, in bounds: CGRect) {
        switch diagram {
        case let .primitive(size, primitive):
            let bounds = size.fit(into: bounds, alignment: .center)
            draw(primitive, in: bounds)
        case .align(let alignment, let diagram):
            let bounds = diagram.size.fit(into: bounds, alignment: alignment)
            draw(diagram, in: bounds)
        case let .beside(left, right):
            let (lBounds, rBounds) = bounds.split(
                ratio: left.size.width / diagram.size.width, edge: .minXEdge)
            draw(left, in: lBounds)
            draw(right, in: rBounds)
        case .below(let top, let bottom):
            let (tBounds, bBounds) = bounds.split(ratio: top.size.height / diagram.size.height, edge: .minYEdge)
            draw(top, in: tBounds)
            draw(bottom, in: bBounds)
        case let .attributed(.fillColor(color), diagram):
            saveGState()
            color.set()
            draw(diagram, in: bounds)
            restoreGState()
        }
    }
}

func rect(width: CGFloat, height: CGFloat) -> Diagram {
    return .primitive(CGSize(width: width, height: height), .rectangle)
}

func circle(diameter: CGFloat) -> Diagram {
    return .primitive(CGSize(width: diameter, height: diameter), .ellipase)
}

func text(_ theText: String, width: CGFloat, height: CGFloat) -> Diagram {
    return .primitive(CGSize(width: width, height: height), .text(theText))
}

func square(side: CGFloat) -> Diagram {
    return rect(width: side, height: side)
}

precedencegroup VerticalCombination {
    associativity: left
}

infix operator ---: VerticalCombination
func ---(l: Diagram, r: Diagram) -> Diagram {
    return .below(l, r)
}

precedencegroup HorizontalCombination {
    higherThan: VerticalCombination
    associativity: left
}

infix operator |||: HorizontalCombination
func |||(l: Diagram, r: Diagram) -> Diagram {
    return .beside(l, r)
}

extension Diagram {
    func filled(_ color: UIColor) -> Diagram {
        return .attributed(.fillColor(color), self)
    }
    
    func aligned(to position: CGPoint) -> Diagram {
        return .align(position, self)
    }
}

extension Diagram {
    init() {
        self = rect(width: 0, height: 0)
    }
}

extension Sequence where Iterator.Element == Diagram {
    var hcat: Diagram {
        return reduce(Diagram(), |||)
    }
}

extension Sequence where Iterator.Element == CGFloat {
    var normalized: [CGFloat] {
        let maxVal = reduce(0, Swift.max)
        return map { $0 / maxVal }
    }
}

func barGraph(_ input: [(String, Double)]) -> Diagram {
    let values: [CGFloat] = input.map { CGFloat($0.1) }
    let bars = values.normalized.map { x in
        return rect(width: 1, height: 3 * x).filled(.black).aligned(to: .bottom)
    }.hcat
    let labels = input.map { label, _ in
        return text(label, width: 1, height: 0.3).aligned(to: .top)
    }.hcat
    return bars --- labels
}

extension CoreGraphics {
    static var example1: Diagram {
        let blueSquare = square(side: 1).filled(.blue)
        let redSquare = square(side: 2).filled(.red)
        let greenCircle = circle(diameter: 1).filled(.green)
        return blueSquare ||| redSquare ||| greenCircle
    }
    
    static var example2: Diagram {
        let blueSquare = square(side: 1).filled(.blue)
        let redSquare = square(side: 2).filled(.red)
        let greenCircle = circle(diameter: 1).filled(.green)
        let cyanCircle = circle(diameter: 1).filled(.cyan)
        return blueSquare ||| cyanCircle ||| redSquare ||| greenCircle
    }
}
