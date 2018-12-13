//
//  Emitterable.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

protocol Emitterable {
    
}

extension Emitterable where Self: UIViewController {
    
    func startEmittering(_ point: CGPoint) {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = point
        emitter.preservesDepth = true
        var cells = [CAEmitterCell]()
        for i in 0..<10 {
            let cell = CAEmitterCell()
            cell.velocity = 150
            cell.velocityRange = 100
            cell.scale = 0.7
            cell.scaleRange = 0.3
            cell.emissionLongitude = -CGFloat.pi / 2.0
            cell.emissionRange = CGFloat.pi / 18.0
            cell.lifetime = 3
            cell.lifetimeRange = 1.5
            cell.spin = CGFloat.pi / 2.0
            cell.spinRange = CGFloat.pi / 4.0
            cell.birthRate = 2
            cell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            cells.append(cell)
        }
        emitter.emitterCells = cells
        view.layer.addSublayer(emitter)
    }
    
    func stopEmittering() {
//        for layer in view.layer.sublayers! {
//            if layer.isKind(of: CAEmitterLayer.self) {
//                layer.removeFromSuperlayer()
//            }
//        }
        view.layer.sublayers?.filter {$0.isKind(of: CAEmitterLayer.self)}.first?.removeFromSuperlayer()
    }
    
}
