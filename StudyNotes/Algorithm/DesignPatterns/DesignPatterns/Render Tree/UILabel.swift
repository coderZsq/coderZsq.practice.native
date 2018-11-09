//
//  UILabel.swift
//  DesignPatterns
//
//  Created by 朱双泉 on 2018/4/21.
//  Copyright © 2018 Castie!. All rights reserved.
//

import CoreGraphics

class UILabel: UIView {
    
    var _text: String
    
    init(_ origin: CGPoint, _ size: CGSize, _ text: String) {
        _text = text
        super.init(origin, size)
    }
    
    @discardableResult static func create(_ origin: CGPoint, _ size: CGSize, _ text: String) -> UILabel {
        let ret = UILabel(origin, size, text)
        ret.autoRelease()
        return ret
    }
    
    override func description() {
        print("description: _origin: \(_origin), _size: \(_size), _text: \(_text)")
    }
    
    func autoRelease() {
        next = UIView.head
        UIView.head = self
    }
}
