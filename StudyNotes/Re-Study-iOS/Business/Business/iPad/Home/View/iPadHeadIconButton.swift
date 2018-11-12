//
//  iPadHeadIconButton.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class iPadHeadIconButton: UIButton {

    let radio: CGFloat = 0.85
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = .lightGray
        imageView?.layer.cornerRadius = 10
        imageView?.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        if isLanscap() {
            return CGRect(x: 0, y: 0, width: contentRect.width, height: contentRect.height * radio)
        } else {
            return contentRect
        }
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if isLanscap() {
            return CGRect(x: 0, y: contentRect.height * radio, width: contentRect.width, height: contentRect.height * (1 - radio))
        } else {
            return .zero
        }
    }
}
