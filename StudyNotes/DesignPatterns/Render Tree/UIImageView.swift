//
//  UIImageView.swift
//  DesignPatterns
//
//  Created by 朱双泉 on 2018/4/21.
//  Copyright © 2018 Castie!. All rights reserved.
//

import CoreGraphics

class UIImageView: UIView {

    var _image: String
    
    init(_ origin: CGPoint, _ size: CGSize, _ image: String) {
        _image = image
        super.init(origin, size)
    }
    
    @discardableResult static func create(_ origin: CGPoint, _ size: CGSize, _ image: String) -> UIImageView {
        let ret = UIImageView(origin, size, image)
        ret.autoRelease()
        return ret
    }
    
    override func description() {
        print("description: _origin: \(_origin), _size: \(_size), _image: \(_image)")
    }
    
    func autoRelease() {
        next = UIView.head
        UIView.head = self
    }

}
