//
//  GiftPackage.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class GiftPackage: BaseModel {
    var t : Int = 0
    var list : [GiftModel] = [GiftModel]()

    override init(dict: [String : Any]) {
        super.init()
        t = dict["t"] as! Int
        if let listArray = dict["list"] as? [[String : Any]] {
            for listDict in listArray {
                list.append(GiftModel(dict: listDict))
            }
        }
    }
}
