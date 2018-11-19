//
//  TimeTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class TimeTool: NSObject {
    
    class func getFormat(time: TimeInterval?) -> String? {
        guard let time = time else {return nil}
        let min = Int(time) / 60
        let sec = Int(time) % 60
        return String(format: "%02i:%02i", min, sec)
    }
    
    class func getTime(format: String) -> TimeInterval {
        let minSec = format.components(separatedBy: ":")
        if minSec.count == 2, let min = Double(minSec[0]), let sec = Double(minSec[1]) {
            return min * 60 + sec
        }
        return 0
    }
}
