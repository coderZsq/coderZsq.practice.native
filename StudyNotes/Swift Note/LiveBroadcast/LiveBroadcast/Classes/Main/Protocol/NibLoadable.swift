//
//  NibLoadable.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

protocol NibLoadable {
    
}

extension NibLoadable where Self: UIView {
    
    static func loadFromNib(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
    
}
