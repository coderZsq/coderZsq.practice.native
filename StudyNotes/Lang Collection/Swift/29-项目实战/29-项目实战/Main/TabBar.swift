//
//  TabBar.swift
//  29-项目实战
//
//  Created by 朱双泉 on 2019/8/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

import UIKit

class TabBar: UITabBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for button in subviews where button is UIControl {
            var frame = button.frame
            frame.origin.y = -2
            button.frame = frame
        }
    }

}
