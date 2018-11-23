//
//  LrcLabel.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class LrcLabel: UILabel {

    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIColor.green.set()
        UIRectFillUsingBlendMode(CGRect(x: 0, y: 0, width: rect.width * progress, height: rect.height), .sourceIn)
    }
}
