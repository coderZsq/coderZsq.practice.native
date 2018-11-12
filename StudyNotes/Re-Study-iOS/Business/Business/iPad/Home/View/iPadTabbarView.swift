//
//  iPadTabbarView.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

enum iPadTabbarType: Int {
    case block = 1
    case mood = 2
    case photo = 3
}

protocol iPadTabbarViewDelegate {
    func dockDidSelect(type: iPadTabbarType)
}

class iPadTabbarView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate: iPadTabbarViewDelegate?
    
    func addButtons() {
        let imageNames = ["Mark", "Mark", "Mark"]
        for imageName in imageNames {
            let button = UIButton(type: .system)
            button.tintColor = .lightGray
            button.setImage(UIImage(named: imageName), for: .normal)
            button.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
            addSubview(button)
            button.tag = subviews.count
        }
    }
    
    @objc
    func buttonClick(sender: UIButton) {
        if let type = iPadTabbarType(rawValue: sender.tag) {
            delegate?.dockDidSelect(type: type)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if isLanscap() {
            var index: CGFloat = 0
            for view in subviews {
                view.width = width / CGFloat(subviews.count)
                view.height = height
                view.left = index * view.width
                view.top = 0
                index += 1
            }
        } else {
            var index: CGFloat = 0
            for view in subviews {
                view.width = width
                view.height = height / CGFloat(subviews.count)
                view.left = 0
                view.top = index * view.height
                index += 1
            }
        }
    }
}
