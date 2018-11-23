//
//  CALayer+extension.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

extension CALayer {

    func pauseAnimate() {
        let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0;
        timeOffset = pausedTime;
    }

    func resumeAnimate() {
        let pausedTime = timeOffset
        speed = 1.0;
        timeOffset = 0.0;
        beginTime = 0.0;
        let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause;
    }
}
