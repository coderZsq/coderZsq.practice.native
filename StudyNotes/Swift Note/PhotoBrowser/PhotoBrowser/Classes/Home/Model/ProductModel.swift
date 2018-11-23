//
//  ProductModel.swift
//  PhotoBrowser
//
//  Created by 朱双泉 on 2018/10/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class ProductModel: NSObject {
    
    var hd_thumb_url: String = ""
    var thumb_url: String = ""
    
    override init() {
        
    }
    
    init(dic: [String : Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
