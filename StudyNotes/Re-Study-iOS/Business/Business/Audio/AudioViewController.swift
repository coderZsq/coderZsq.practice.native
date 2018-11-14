//
//  AudioViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {
    
    @IBAction func music(_ sender: UIButton) {
        navigationController?.pushViewController(MusicViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Audio"
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            try session.setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
        } catch {
            print(error)
            return
        }
    }
    
    var recoder: AVAudioRecorder?
    
    @IBAction func startRecoding(_ sender: UIButton) {
        if let url = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first {
            let fullPath = url + "/test.caf"
            guard let fullURL = URL(string: fullPath) else {return}
            let settings = [
                //编码格式
                AVFormatIDKey : NSNumber(integerLiteral: Int(kAudioFormatLinearPCM)),
                //采样率
                AVSampleRateKey : NSNumber(floatLiteral: 11025.0),
                //通道数
                AVNumberOfChannelsKey : NSNumber(integerLiteral: 2),
                //录音质量
                AVEncoderAudioQualityKey : NSNumber(integerLiteral: Int(AVAudioQuality.min.rawValue))
            ]
            do {
                recoder = try AVAudioRecorder(url: fullURL, settings: settings)
            } catch {
                print("错误")
                return
            }
            if let recoder = recoder {
                recoder.prepareToRecord()
                recoder.record()
                print(fullPath)
                //                recoder.record(atTime: recoder.deviceCurrentTime + 2)
                //                recoder.record(atTime: recoder.deviceCurrentTime + 2, forDuration: 3)
                //                recoder.record(forDuration: 5)
            }
        }
    }
    
    @IBAction func stopRecoding(_ sender: UIButton) {
        guard let recoder = recoder else {
            return
        }
        if recoder.currentTime < 2 {
            print("录音时间太短")
            recoder.stop()
            //            recoder.deleteRecording()
        } else {
            print("录音成功")
            recoder.stop()
        }
    }
    
    @IBAction func playAudio(_ sender: UIButton) {
        if let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first {
            AudioTool.playAudio(path: path + "/test.caf", isAlert: true) {
                print("播放完成")
            }
        }
    }
    
    lazy var audioPlayer: AVAudioPlayer? = {
        guard let url = Bundle.main.url(forResource: "老李.mp3", withExtension: nil) else {return nil}
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.enableRate = true //开始速率播放的开关必须放到准备播放之前
            audioPlayer.prepareToPlay()
            return audioPlayer
        } catch {
            print(error)
            return nil
        }
    }()
    
    @IBAction func playMusic(_ sender: UIButton) {
        audioPlayer?.delegate = self
        audioPlayer?.play()
    }
    
    @IBAction func pauseMusic(_ sender: UIButton) {
        audioPlayer?.pause()
    }
    
    @IBAction func stopMusic(_ sender: UIButton) {
        audioPlayer?.currentTime = 0
        audioPlayer?.stop()
    }
    
    @IBAction func forward5s(_ sender: UIButton) {
        audioPlayer?.currentTime += 5
    }
    
    @IBAction func rewind5s(_ sender: UIButton) {
        audioPlayer?.currentTime -= 5 //系统做了容错处理
    }
    
    @IBAction func play2x(_ sender: UIButton) {
        audioPlayer?.rate = 2.0
    }
    
    @IBAction func volumn(_ sender: UISlider) {
        audioPlayer?.volume = sender.value
    }
}

extension AudioViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("播放完成")
    }
}
