//
//  DetailViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var playOrPauseButton: UIButton!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var costTimeLabel: UILabel!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var lrcBackView: UIScrollView!
    @IBOutlet weak var lrcLabel: LrcLabel!
    @IBOutlet weak var foreImageView: UIImageView!
    
    lazy var lrcViewController = LrcViewController()
    var updateTimersTimer: Timer?
    var displayLink: CADisplayLink?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension DetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLrcView()
        setLrcBackView()
        setSlider()
        setupOnce()
        NotificationCenter.default.addObserver(self, selector: #selector(nextMusic), name: playerFinished, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setLrcFrame()
        setLrcBackViewFrame()
        setForeImageView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTimer()
        addDisplayLink()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeTimer()
        removeDisplayLink()
    }
    
    @IBAction func close() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func preMusic() {
        MusicOperationTool.shared.preMusic()
        setupOnce()
    }
    
    @IBAction func playOrPause(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            MusicOperationTool.shared.playCurrentMusic()
            resumeRotationAnimation()
        } else {
            MusicOperationTool.shared.pauseCurrentMusic()
            pauseRotationAnimation()
        }
    }
    
    @IBAction func nextMusic() {
        MusicOperationTool.shared.nextMusic()
        setupOnce()
    }

    func addTimer() {
        updateTimersTimer = Timer(timeInterval: 1, target: self, selector: #selector(setupTimes), userInfo: nil, repeats: true)
        if let updateTimersTimer = updateTimersTimer {
            RunLoop.current.add(updateTimersTimer, forMode: .common)
        }
    }
    
    func removeTimer() {
        updateTimersTimer?.invalidate()
        updateTimersTimer = nil
    }
    
    func addDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateLrcData))
        if let displayLink = displayLink {
            displayLink.add(to: .current, forMode: .common)
        }
    }
    
    func removeDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @IBAction func down(_ sender: UISlider) {
        removeTimer()
    }
    
    @IBAction func up(_ sender: UISlider) {
        let musicMessageModel = MusicOperationTool.shared.getMusicMessageModel()
        let currentTime = (musicMessageModel.totalTime ?? 0) * Double(sender.value)
        MusicOperationTool.shared.setTime(currentTime: currentTime)
        addTimer()
    }

    @IBAction func change(_ sender: UISlider) {
        let musicMessageModel = MusicOperationTool.shared.getMusicMessageModel()
        let currentTime = (musicMessageModel.totalTime ?? 0) * Double(sender.value)
        costTimeLabel.text = TimeTool.getFormat(time: currentTime)
    }
}

extension DetailViewController {
    
    func setupOnce() {
        let musicMessageModel = MusicOperationTool.shared.getMusicMessageModel()
        guard
            let name = musicMessageModel.musicModel?.name,
            let singer = musicMessageModel.musicModel?.singer,
            let totalTimeFormat = musicMessageModel.totalTimeFormat,
            let icon = musicMessageModel.musicModel?.icon,
            let isPlaying = musicMessageModel.isPlaying,
            let lrcname = musicMessageModel.musicModel?.lrcname
            else {return}
        backImageView.image = UIImage(named: icon)
        songNameLabel.text = name
        singerNameLabel.text = singer
        totalTimeLabel.text = "\(totalTimeFormat)"
        foreImageView.image = UIImage(named: icon)
        addRotationAnimation()
        if isPlaying {
            resumeRotationAnimation()
        } else {
            pauseRotationAnimation()
        }
        let lrcModels = DataTool.getLrcModelData(lrcName: lrcname)
        lrcViewController.lrcModels = lrcModels
        progressSlider.value = 0
    }
    
    @objc func setupTimes() {
        let musicMessageModel = MusicOperationTool.shared.getMusicMessageModel()
        guard
            let costTime = musicMessageModel.costTime,
            let costTimeFormat = musicMessageModel.costTimeFormat,
            let isPlaying = musicMessageModel.isPlaying,
            let totalTime = musicMessageModel.totalTime
            else {return}
        costTimeLabel.text = "\(costTimeFormat)"
        if playOrPauseButton.isSelected != musicMessageModel.isPlaying {
            playOrPauseButton.isSelected = isPlaying
            progressSlider.value = Float(costTime / totalTime)
            if isPlaying {
                resumeRotationAnimation()
            } else {
                pauseRotationAnimation()
            }
        }
    }
    
    @objc func updateLrcData() {
        if let costTime = MusicOperationTool.shared.getMusicMessageModel().costTime {
            let (row, lrcModel) = DataTool.getRowLrcModel(lrcModels: lrcViewController.lrcModels, currentTime: costTime)
            lrcViewController.scrollRow = row
            lrcLabel.text = lrcModel?.lrcContent
            if let lrcModel = lrcModel {
                lrcLabel.progress = CGFloat((costTime - lrcModel.startTime) / (lrcModel.endTime - lrcModel.startTime))
                lrcViewController.progress = lrcLabel.progress
            }
            if UIApplication.shared.applicationState == .background {
                MusicOperationTool.shared.setupLockMessage()
            }
        }
    }
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
        lrcBackView.addSubview(lrcViewController.tableView)
    }
    
    func setLrcFrame() {
        lrcViewController.tableView.frame = lrcBackView.bounds
        lrcViewController.tableView.left = lrcBackView.width
    }
    
    func setForeImageView() {
        foreImageView.layer.cornerRadius = foreImageView.width * 0.5
        foreImageView.layer.masksToBounds = true
    }
    
    func setSlider() {
        progressSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), for: .normal)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let alpha = 1 - scrollView.contentOffset.x / scrollView.width
        foreImageView.alpha = alpha
        lrcLabel.alpha = alpha
    }
    
    func addRotationAnimation() {
        foreImageView.layer.removeAnimation(forKey: "rotation")
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.duration = 30
        animation.repeatCount = Float.infinity
        animation.isRemovedOnCompletion = false
        foreImageView.layer.add(animation, forKey: "rotation")
    }
    
    func pauseRotationAnimation() {
        foreImageView.layer.pauseAnimate()
    }
    
    func resumeRotationAnimation() {
        foreImageView.layer.resumeAnimate()
    }
}

extension DetailViewController {
    
    override func remoteControlReceived(with event: UIEvent?) {
        guard let event = event else {
            return
        }
        switch event.subtype {
        case .remoteControlPlay:
            MusicOperationTool.shared.playCurrentMusic()
        case .remoteControlPause:
            MusicOperationTool.shared.pauseCurrentMusic()
        case .remoteControlNextTrack:
            MusicOperationTool.shared.nextMusic()
        case .remoteControlPreviousTrack:
            MusicOperationTool.shared.preMusic()
        default:
            break
        }
        setupOnce()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        MusicOperationTool.shared.nextMusic()
        setupOnce()
    }
}
