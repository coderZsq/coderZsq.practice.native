//
//  MusicOperationTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import MediaPlayer

class MusicOperationTool: NSObject {
    
    private var musicMessageModel = MusicMessageModel()
    
    func getMusicMessageModel() -> MusicMessageModel {
        musicMessageModel.musicModel = musicModels?[currentIndex]
        musicMessageModel.costTime = tool.player?.currentTime
        musicMessageModel.totalTime = tool.player?.duration
        musicMessageModel.isPlaying = tool.player?.isPlaying
        return musicMessageModel
    }
    
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
    
    func setTime(currentTime: TimeInterval) {
        tool.setTime(currentTime: currentTime)
    }
    
    func setupLockMessage() {
        let musicMessageModel = getMusicMessageModel()
        let infoCenter = MPNowPlayingInfoCenter.default()
        if
            let name = musicMessageModel.musicModel?.icon,
            let lrcname = musicMessageModel.musicModel?.lrcname,
            let costTime = musicMessageModel.costTime {
            let image = UIImage(named: name)
            let lrcModels = DataTool.getLrcModelData(lrcName: lrcname)
            let (_, lrcModel) = DataTool.getRowLrcModel(lrcModels: lrcModels, currentTime: costTime)
            let resultImage = ImageTool.getImage(sourceImage: image, text: lrcModel?.lrcContent)
            let albumArtwork: MPMediaItemArtwork?
            if #available(iOS 10.0, *) {
                albumArtwork = MPMediaItemArtwork(boundsSize: resultImage.size, requestHandler: { (size) -> UIImage in
                    return resultImage
                })
            } else {
                albumArtwork = MPMediaItemArtwork(image: resultImage)
            }

            let info: [String : Any] = [
                MPMediaItemPropertyAlbumTitle: musicMessageModel.musicModel?.name ?? "",
                MPMediaItemPropertyArtist: musicMessageModel.musicModel?.singer ?? "",
                MPMediaItemPropertyPlaybackDuration: musicMessageModel.totalTime ?? 0,
                MPMediaItemPropertyArtwork: albumArtwork!]
            infoCenter.nowPlayingInfo = info
        }
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
}
