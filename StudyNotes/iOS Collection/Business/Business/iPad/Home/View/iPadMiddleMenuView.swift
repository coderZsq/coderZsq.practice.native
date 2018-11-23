//
//  iPadMiddleMenuView.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

protocol iPadMiddleMenuViewDelegate {
    func dockDidSelect(toIndex: Int)
}

class iPadMiddleMenuView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addMenus()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: iPadMiddleMenuViewDelegate?
    
    func addMenus() {
        for i in 0..<6 {
            let button = iPadMenuButton(type: .system)
            button.tintColor = .lightGray
            button.setTitle("  CoderZsq - " + "\(i)", for: .normal)
            button.setImage(UIImage(named: "Mark"), for: .normal)
            button.addTarget(self, action: #selector(menuClick(sender:)), for: .touchDown)
            button.tag = subviews.count
            addSubview(button)
        }
    }
    
    @objc
    func menuClick(sender: UIButton) {
        delegate?.dockDidSelect(toIndex: sender.tag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var index: CGFloat = 0
        for view in subviews {
            view.height = height / CGFloat(subviews.count)
            view.width = width
            view.left = 0
            view.top = view.height * index
            index += 1
        }
    }
}
