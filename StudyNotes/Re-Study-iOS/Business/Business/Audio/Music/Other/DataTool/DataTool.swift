//
//  DataTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class DataTool: NSObject {
    
    class func getMusicListData() -> [MusicModel] {
        guard let path = Bundle.main.path(forResource: "Musics.plist", ofType: nil) else {
            return []
        }
        guard let keyedValuesArr = NSArray(contentsOfFile: path) else {
            return []
        }
        var musicModels = [MusicModel]()
        for keyedValues in keyedValuesArr {
            print(keyedValues)
            if let keyedValues = keyedValues as? [String : AnyObject] {
                let musicModel = MusicModel(keyedValues: keyedValues)
                musicModels.append(musicModel)
            }
        }
        return musicModels
    }
    
    class func getLrcModelData(lrcName: String) -> [LrcModel] {
        guard let path = Bundle.main.path(forResource: lrcName, ofType: nil) else {
            return []
        }
        var lrcContent: String?
        do {
            lrcContent = try String(contentsOfFile: path)
        } catch {
            print(error)
            return []
        }
        var lrcModels = [LrcModel]()
        if let lrcContent = lrcContent {
            let lrcStrArray = lrcContent.components(separatedBy: "\n")
            for lrcStr in lrcStrArray {
                if lrcStr.contains("[ti:") || lrcStr.contains("[ar:") || lrcStr.contains("[al:") {
                    continue
                }
                let resultStr = lrcStr.replacingOccurrences(of: "[", with: "")
                let timeAndLrc = resultStr.components(separatedBy: "]")
                if timeAndLrc.count == 2 {
                    let timeFormat = timeAndLrc[0]
                    let lrc = timeAndLrc[1]
                    let lrcModel = LrcModel()
                    lrcModel.startTime = TimeTool.getTime(format: timeFormat)
                    lrcModel.lrcContent = lrc
                    lrcModels.append(lrcModel)
                }
            }
            for i in 0..<lrcModels.count {
                if i == lrcModels.count - 1 {
                    break
                }
                lrcModels[i].endTime = lrcModels[i + 1].startTime
            }
        }
        return lrcModels
    }
    
    class func getRowLrcModel(lrcModels: [LrcModel], currentTime: TimeInterval) -> (row: Int, lrcModel: LrcModel?) {
        for i in 0..<lrcModels.count {
            if currentTime > lrcModels[i].startTime && currentTime < lrcModels[i].endTime {
                return (i, lrcModels[i])
            }
        }
        return (0, nil)
    }
}
