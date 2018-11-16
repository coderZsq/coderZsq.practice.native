//
//  MusicModel.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class MusicModel: NSObject {
    
    var name: String?
    var filename: String?
    var lrcname: String?
    var singer: String?
    var singerIcon: String?
    var icon: String?
    
    override init() {
        super.init()
    }
    
    init(keyedValues: [String : AnyObject]) {
        super.init()
        name = keyedValues["name"] as? String
        filename = keyedValues["filename"] as? String
        lrcname = keyedValues["lrcname"] as? String
        singer = keyedValues["singer"] as? String
        singerIcon = keyedValues["singerIcon"] as? String
        icon = keyedValues["icon"] as? String
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
