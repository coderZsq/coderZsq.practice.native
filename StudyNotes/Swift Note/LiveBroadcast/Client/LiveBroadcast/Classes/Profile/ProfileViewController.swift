//
//  ProfileViewController.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import AVFoundation

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://59.110.27.24:8080/live/demo.m3u8")
        let player = AVPlayer(url: url!)
        
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        
        player.play()
    }

}
