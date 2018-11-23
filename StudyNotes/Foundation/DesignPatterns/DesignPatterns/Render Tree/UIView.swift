//
//  UIView.swift
//  DesignPatterns
//
//  Created by 朱双泉 on 2018/4/21.
//  Copyright © 2018 Castie!. All rights reserved.
//

import CoreGraphics

class UIView {

    var _origin: CGPoint
    var _size: CGSize
    static var head: UIView?
    var next: UIView?
    
    func description() {}
    init(_ origin: CGPoint, _ size: CGSize) {
        _origin = origin
        _size = size
    }
    static func renderTreeList() {
        var t = head
        while t != nil {
            t?.description()
            t = t?.next
        }
    }
}
