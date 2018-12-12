//
//  GiftModel.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class GiftModel: BaseModel {
    var img2 : String = ""
    var coin : Int = 0
    var subject : String = "" { 
        didSet {
            if subject.contains("(有声)") {
                subject = subject.replacingOccurrences(of: "(有声)", with: "")
            }
        }
    }
    
    override init(dict: [String : Any]) {
        super.init()
        img2 = dict["img2"] as! String
        coin = dict["coin"] as! Int
        subject = dict["subject"] as! String
    }
}
