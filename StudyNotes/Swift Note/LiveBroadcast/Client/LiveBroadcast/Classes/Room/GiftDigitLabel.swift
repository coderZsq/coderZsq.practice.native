//
//  GiftDigitLabel.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class GiftDigitLabel: UILabel {

    override func drawText(in rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(5)
        context?.setLineJoin(.round)
        context?.setTextDrawingMode(.stroke)
        textColor = .orange
        super.drawText(in: rect)
        context?.setTextDrawingMode(.fill)
        textColor = .white
        super.drawText(in: rect)
    }
 
    func showDigitAnimation(_ completion: @escaping () -> ()) {
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
        }) { (isFinished) in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: {
                self.transform = CGAffineTransform.identity
            }, completion: { (isFinished) in
                completion()
            })
        }
    }
    
}
