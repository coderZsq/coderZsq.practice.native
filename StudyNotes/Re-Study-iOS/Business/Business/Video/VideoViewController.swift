//
//  VideoViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit

class VideoViewController: UIViewController {
    
    var layer: AVPlayerLayer? = {
        var layer: AVPlayerLayer?
        if let url = Bundle.main.url(forResource: "video.mov", withExtension: nil) {
            let playItem = AVPlayerItem(url: url)
            let player = AVPlayer(playerItem: playItem)
            //            let player = AVPlayer(url: url)
            //            player.play()
            layer = AVPlayerLayer(player: player)
        }
        return layer
    }()
    
    var moviePlayer: MPMoviePlayerController? = {
        var moviePlayer: MPMoviePlayerController?
        if let url = Bundle.main.url(forResource: "video.mov", withExtension: nil) {
            moviePlayer = MPMoviePlayerController(contentURL: url)
            moviePlayer?.prepareToPlay()
        }
        return moviePlayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Video"
        if let layer = layer {
            self.view.layer.addSublayer(layer)
        }
//        if let movieView = moviePlayer?.view {
//            self.view.addSubview(movieView)
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layer?.frame = view.bounds
        moviePlayer?.view.frame = view.bounds
    }
    
    @IBAction func avPlayer(_ sender: Any) {
        if let url = Bundle.main.url(forResource: "video.mov", withExtension: nil) {
            let vc = AVPlayerViewController()
            let player = AVPlayer(url: url)
            vc.player = player
            vc.allowsPictureInPicturePlayback = true
            present(vc, animated: true) {
                vc.player?.play()
            }
        }
    }
    
    @IBAction func moviePlayer(_ sender: UIButton) {
//        moviePlayer?.play()
        if let url = Bundle.main.url(forResource: "video.mov", withExtension: nil),
            let vc = MPMoviePlayerViewController(contentURL: url) {
            present(vc, animated: true) {
                vc.moviePlayer.play()
            }
        }
    }
    
    @IBAction func remotePlay(_ sender: UIButton) {
        layer?.player?.play()
    }
}
