//
//  RxModel.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class RxModel: NSObject {
    
    var name: String = ""
    var icon: String = ""
    var download: String = ""
    
    init(dict: [String : Any]) {
        super.init()
        name = dict["name"] as! String
        icon = dict["icon"] as! String
        download = dict["download"] as! String
    }
    
}
