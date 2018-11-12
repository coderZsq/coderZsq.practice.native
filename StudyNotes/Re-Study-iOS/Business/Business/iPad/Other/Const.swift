//
//  Const.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

func isLanscap() -> Bool {
    let bounds = UIScreen.main.bounds
    return bounds.size.width > bounds.size.height
}

var kDockWidth: CGFloat {
    return isLanscap() ? 210 : 70
}

var kDockTabbarHeight: CGFloat {
    return isLanscap() ? 70 : 210
}

var kDockMiddleMenuHeight: CGFloat {
    return 420
}

var kDockHeadIconWidth: CGFloat {
    return isLanscap() ? 160 : 50
}

var kDockHeadIconHeight: CGFloat {
    return isLanscap() ? 180 : 50
}

