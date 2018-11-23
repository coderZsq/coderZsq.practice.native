//
//  iPadDockView.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

protocol iPadDockViewDelegate: iPadTabbarViewDelegate, iPadMiddleMenuViewDelegate {
    func dockHeadIconDidClick()
}

class iPadDockView: UIView {

    lazy var tabbar: iPadTabbarView = {
        let tabbar = iPadTabbarView()
        addSubview(tabbar)
        return tabbar
    }()
    
    lazy var middleMenu: iPadMiddleMenuView = {
        let middleMenu = iPadMiddleMenuView()
        addSubview(middleMenu)
        return middleMenu
    }()
    
    lazy var headIcon: iPadHeadIconButton = {
        let headIcon = iPadHeadIconButton()
        headIcon.setImage(UIImage(named: "Castiel"), for: .normal)
        headIcon.setTitle("Castie!", for: .normal)
        headIcon.addTarget(self, action: #selector(headIconClick), for: .touchUpInside)
        addSubview(headIcon)
        return headIcon
    }()
    
    @objc
    func headIconClick() {
        delegate?.dockHeadIconDidClick()
    }
    
    var delegate: iPadDockViewDelegate? {
        didSet {
            tabbar.delegate = delegate
            middleMenu.delegate = delegate
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews")
        tabbar.height = kDockTabbarHeight
        tabbar.width = width
        tabbar.top = height - tabbar.height
        middleMenu.height = kDockMiddleMenuHeight
        middleMenu.width = width
        middleMenu.left = 0
        middleMenu.top = height - tabbar.height - middleMenu.height
        headIcon.width = kDockHeadIconWidth
        headIcon.height = kDockHeadIconHeight
        headIcon.left = (width - headIcon.width) * 0.5
        headIcon.top = 100
    }
}
