//
//  MusicOperationTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class MusicOperationTool: NSObject {
    
    static let shared = MusicOperationTool()
    
    var musicModels: [MusicModel]?
    
    var currentIndex = 0 {
        didSet {
            if let musicModels = musicModels {
                if currentIndex < 0 {
                    currentIndex = musicModels.count - 1
                }
                if currentIndex > musicModels.count - 1 {
                    currentIndex = 0
                }
            }
        }
    }
    
    private let tool = MusicTool()
    
    func playMusic(musicModel: MusicModel) {
        if  let musicName = musicModel.filename {
            tool.playMusic(musicName: musicName)
        }
        currentIndex = musicModels?.firstIndex(of: musicModel) ?? 0
    }
    
    func playCurrentMusic() {
        tool.playCurrentMusic()
    }
    
    func pauseCurrentMusic() {
        tool.pauseCurrentMusic()
    }
    
    func nextMusic() {
        currentIndex += 1
        if let musicModel = musicModels?[currentIndex] {
            playMusic(musicModel: musicModel)
        }
    }
    
    func preMusic() {
        currentIndex -= 1
        if let musicModel = musicModels?[currentIndex] {
            playMusic(musicModel: musicModel)
        }
    }
}
