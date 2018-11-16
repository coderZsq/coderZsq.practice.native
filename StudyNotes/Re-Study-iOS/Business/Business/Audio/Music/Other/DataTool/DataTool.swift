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
}
