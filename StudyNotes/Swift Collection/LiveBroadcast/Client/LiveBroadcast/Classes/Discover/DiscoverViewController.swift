//
//  DiscoverViewController.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import LFLiveKit

class DiscoverViewController: UIViewController {

    lazy var session: LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.default()
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: .low2, outputImageOrientation: .portrait)
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        session?.preView = self.view
        return session!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func startRunning(_ sender: UIButton) {
        let stream = LFLiveStreamInfo()
        stream.url = "rtmp://59.110.27.24/live/demo"
        session.startLive(stream)
        session.running = true
    }
    
}
