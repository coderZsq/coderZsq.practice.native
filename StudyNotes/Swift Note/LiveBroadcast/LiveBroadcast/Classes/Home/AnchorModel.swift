//
//  AnchorModel.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class AnchorModel: BaseModel {
    var roomid : String = ""
    var name : String = ""
    var pic51 : String = ""
    var pic74 : String = ""
    var live : Int = 0
    var push : Int = 0
    var focus : Int = 0
    var isEvenIndex : Bool = false
    override init(dict : [String : Any]) {
        super.init()
        roomid = dict["roomid"] as! String
        name = dict["name"] as! String
        pic51 = dict["pic51"] as! String
        pic74 = dict["pic74"] as! String
        live = dict["live"] as! Int
        push = dict["push"] as! Int
        focus = dict["focus"] as! Int
    }
}
