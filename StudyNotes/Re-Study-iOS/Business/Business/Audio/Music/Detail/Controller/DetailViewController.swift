//
//  DetailViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var lrcBackView: UIScrollView!
    @IBOutlet weak var lrcLabel: UILabel!
    @IBOutlet weak var foreImageView: UIImageView!
    var lrcView: UIView?
}

extension DetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLrcView()
        setLrcBackView()
        setSlider()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setLrcFrame()
        setLrcBackViewFrame()
        setForeImageView()
    }
    
    @IBAction func close() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func preMusic() {
        MusicOperationTool.shared.preMusic()
    }
    
    @IBAction func playOrPause(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            MusicOperationTool.shared.playCurrentMusic()
        } else {
            MusicOperationTool.shared.pauseCurrentMusic()
        }
    }
    
    @IBAction func nextMusic() {
        MusicOperationTool.shared.nextMusic()
    }
}

extension DetailViewController {
    
}

extension DetailViewController {
    
    func setLrcBackView() {
        lrcBackView.delegate = self
        lrcBackView.isPagingEnabled = true
        lrcBackView.showsHorizontalScrollIndicator = false
    }
    
    func setLrcBackViewFrame() {
        lrcBackView.contentSize = CGSize(width: lrcBackView.width * 2, height: 0)
    }
    
    func addLrcView() {
        lrcView = UIView()
        lrcView?.backgroundColor = .clear
        if let lrcView = lrcView {
            lrcBackView.addSubview(lrcView)
        }
    }
    
    func setLrcFrame() {
        lrcView?.frame = lrcBackView.bounds
        lrcView?.left = lrcBackView.width
    }
    
    func setForeImageView() {
        foreImageView.layer.cornerRadius = foreImageView.width * 0.5
        foreImageView.layer.masksToBounds = true
    }
    
    func setSlider() {
        progressSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), for: .normal)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = 1 - scrollView.contentOffset.x / scrollView.width
        foreImageView.alpha = alpha
        lrcLabel.alpha = alpha
    }
}
