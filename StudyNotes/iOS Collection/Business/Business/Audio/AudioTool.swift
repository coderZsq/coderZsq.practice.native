//
//  AudioTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import AVFoundation

class AudioTool: NSObject {
    
    class func playAudio(path: String, isAlert: Bool, result: @escaping () -> ()) {
        let url =  URL(fileURLWithPath: path, isDirectory: false) as CFURL
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url, &soundID)
        if isAlert {
            AudioServicesPlayAlertSoundWithCompletion(soundID) {
                AudioServicesDisposeSystemSoundID(soundID)
                result()
            }
        } else {
            //            AudioServicesPlaySystemSound(soundID)
            AudioServicesPlaySystemSoundWithCompletion(soundID) {
                AudioServicesDisposeSystemSoundID(soundID)
                result()
            }
        }
    }
}
