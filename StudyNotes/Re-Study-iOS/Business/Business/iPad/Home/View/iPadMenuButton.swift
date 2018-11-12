//
//  iPadMenuButton.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class iPadMenuButton: UIButton {

    let radio: CGFloat = 0.3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        if isLanscap() {
            return CGRect(x: contentRect.width * radio, y: 0, width: contentRect.width * (1 - radio), height: contentRect.height)
        }
        return .zero
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        if isLanscap() {
            return CGRect(x: 0, y: 0, width: contentRect.width * radio, height:
                contentRect.height)
        }
        return contentRect
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let imageView = imageView else {
            return
        }
        imageView.width = 20
        imageView.height = 25
        imageView.top = 22
        imageView.left = 25
    }
}
