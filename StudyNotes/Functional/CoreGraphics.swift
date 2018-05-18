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
        CoreGraphics.renderer.draw(in: rect)
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
