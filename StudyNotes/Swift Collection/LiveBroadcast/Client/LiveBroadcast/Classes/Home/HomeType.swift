//
//  HomeType.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class HomeType: BaseModel {
    
    var title : String = ""
    var type : Int = 0
    
    override init(dict : [String : Any]) {
        super.init()
        title = dict["title"] as! String
        type = dict["type"] as! Int
    }
}
