//
//  MusicMessageModel.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class MusicMessageModel: NSObject {
    
    var musicModel: MusicModel?
    var costTime: TimeInterval? = 0
    var totalTime: TimeInterval? = 0
    var isPlaying: Bool? = false
    
    var costTimeFormat: String? {
        return TimeTool.getFormat(time: costTime)
    }
    
    var totalTimeFormat: String? {
        return TimeTool.getFormat(time: totalTime)
    }
}
