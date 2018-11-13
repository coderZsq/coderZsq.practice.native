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

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Audio"
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
            let url =  URL(fileURLWithPath: path + "/test.caf", isDirectory: false) as CFURL
            var soundID: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(url, &soundID)
//            AudioServicesPlaySystemSound(soundID)
            AudioServicesPlaySystemSoundWithCompletion(soundID) {
                print("")
            }
        }
    }
}

