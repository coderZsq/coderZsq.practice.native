//
//  MusicTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import AVFoundation

let playerFinished = Notification.Name("playerFinished")

class MusicTool: NSObject {
    
    override init() {
        super.init()
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            try session.setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
        } catch {
            print(error)
            return
        }
    }
    
    var player: AVAudioPlayer?
    
    func playMusic(musicName: String) {
        guard let url = Bundle.main.url(forResource: musicName, withExtension: nil) else {
            return
        }
        if player?.url == url {
            player?.play()
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
        } catch {
            print(error)
            return
        }
        player?.prepareToPlay()
        player?.play()
    }
    
    func pauseCurrentMusic() {
        player?.pause()
    }
    
    func playCurrentMusic() {
        player?.play()
    }
    
    func stopCurrentMusic() {
        player?.currentTime = 0
        player?.stop()
    }
    
    func setTime(currentTime: TimeInterval) {
        player?.currentTime = currentTime
    }
}

extension MusicTool: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NotificationCenter.default.post(name: playerFinished, object: nil)
    }
}

